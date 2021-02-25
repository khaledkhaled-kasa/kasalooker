view: gv_form_ts {
  derived_table: {
    sql:
    WITH timestamped_GVs AS
      (SELECT name, REPLACE(REPLACE(REPLACE(SPLIT(name, '| ')[SAFE_OFFSET(ARRAY_LENGTH(SPLIT(name, '| ')) - 1)],"#",""),"✅","") ,"Same day reservation - ","")confirmationcode,
      CASE WHEN name LIKE "%Reservation Authorized%" THEN "Reservation Authorized"
      WHEN name LIKE "Virtual check-in%✅" THEN "Virtual checkin"
      WHEN name LIKE "❌%Guest%" THEN "Background Failure"
      WHEN name LIKE "Same day reservation%" THEN "Same Day Reservation"
      END verification_type,
      conversation.created_at conversation_created,
      CASE WHEN (name LIKE "❌%Guest%" or name LIKE "Same day reservation%" ) THEN NULL
      ELSE conversation.created_at
      END verified_ts
      FROM kustomer.conversation
      WHERE (name LIKE "%Reservation Authorized%" OR name LIKE "Virtual check-in%✅" or name LIKE "❌%Guest%" or name LIKE "Same day reservation%")),

      timestamped_GVs_MAX AS (SELECT timestamped_GVs.confirmationcode, MAX(conversation_created) conversation_created, count(*) number_of_attempts
      FROM timestamped_GVs
      GROUP BY 1)

      SELECT timestamped_GVs.*, timestamped_GVs_MAX.number_of_attempts
      FROM  timestamped_GVs JOIN timestamped_GVs_MAX ON timestamped_GVs.confirmationcode = timestamped_GVs_MAX.confirmationcode AND timestamped_GVs.conversation_created = timestamped_GVs_MAX.conversation_created

      ;;


      # datagroup_trigger: kustomer_default_datagroup;;
      # indexes: ["night","transaction"]
      #publish_as_db_view: yes

    }

    dimension_group: created {
      type: time
      hidden: yes
      group_label: "Conversation Created Date"
      label: "Conversation Created"
      timeframes: [
        raw,
        time,
        date,
        day_of_week,
        week,
        month,
        quarter,
        year,
        time_of_day
      ]
      sql: ${TABLE}.conversation_created ;;
    }

  dimension_group: verified_ts {
    type: time
    group_label: "Verified TS"
    description: "This will pull the LATEST timestamp of either a reservation authorization, virtual checkin, background failure or same day reservations"
    label: "Verified TS"
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year,
      time_of_day
    ]
    sql: ${TABLE}.verified_ts ;;
  }

    dimension: confirmationcode {
      type: string
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.confirmationcode ;;
    }

  dimension: number_of_attempts {
    type: number
    label: "Number of GV-related Records"
    description: "This will include the total number of GV-related records for the confirmationcode for either a reservation authorization, virtual checkin, background failure or same day reservations "
    sql: ${TABLE}.number_of_attempts ;;
  }

  dimension: conversation_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: verification_type {
    type: string
    sql: ${TABLE}.verification_type ;;
  }

  dimension: days_to_submit {
    label: "Number of Days"
    description: "Number of days ahead of check-in to submit the GV form"
    type:  number
    sql:  date_diff(${reservations_audit.reservation_checkin_date}, ${verified_ts_date}, DAY) ;;
  }

  measure: avg_number_of_days {
    label: "Average Number of Days before Check-in"
    description: "Average number of days ahead of check-in to submit the GV form"
    value_format: "0.0"
    type:  average
    sql:  ${days_to_submit} ;;
  }

  dimension: date_diff {
    label: "Number of Hours before Check-in"
    type: number
    description: "Number of hours ahead of check-in to submit the GV form"
    sql: TIMESTAMP_DIFF(TIMESTAMP(${reservations_audit.reservation_checkin_time}), TIMESTAMP(${verified_ts_time}), HOUR);;
  }

  dimension: hour_bins {
    label: "Hours before Check-in (Bins)"
    type: string
    description: "Distribution of hours ahead of check-in to submit the GV form (6 hours, 12 hours, 24 hours, 48 hours) before checkin"
    sql: CASE
          WHEN ${date_diff} < 6 THEN "b1: < 6 hours"
          WHEN ${date_diff} >= 6 AND ${date_diff} < 12 THEN "b2: 6 - 12 hours"
          WHEN ${date_diff} >= 12 AND ${date_diff} < 24 THEN "b3: 12 - 24 hours"
          WHEN ${date_diff} >= 24 AND ${date_diff} < 48 THEN "b4: 24 - 48 hours"
          WHEN ${date_diff} >= 48 THEN "b5: >= 48 hours"
          ELSE "b6: Not Submitted"
          END;;
  }


  measure: avg_number_of_hours {
    label: "Average Number of Hours"
    description: "Average number of hours ahead of check-in to submit the GV form"
    value_format: "0.0"
    type:  average
    sql:  ${date_diff} ;;
  }


  }
