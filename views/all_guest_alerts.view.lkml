view: all_guest_alerts {
  label: "Guest Alerts"
  derived_table: {
    sql:
      SELECT messages.createdat AS createdat, messages.source AS eventtype, meta.reservationconfirmationcode AS reservation_id, "messages" as source, reservations.confirmationcode as confirmationcode, reservations.unit, reservations.timezone as timezone
      FROM messages JOIN reservations ON meta.reservationconfirmationcode = reservations.confirmationcode
      -- where messages.source IN ("kasa-automessages-production-smokeAlert","kasa-automessages-production-noiseBreach", "kasa-automessages-production-noiseBreach|kasa-airbnb-sync-production-sendAirbnbMessageWorker")

      UNION DISTINCT
      (SELECT textmessages.createdat AS createdat, messagetype AS eventtype, reservation AS reservation_id, "textmessages" as source, reservations.confirmationcode as confirmationcode, reservations.unit, reservations.timezone as timezone
      FROM textmessages JOIN reservations ON reservation = reservations._id
      -- where messagetype IN ("smokeAlert", "noiseBreach2", "noiseBreach")
      )

      ;;

    #datagroup_trigger: reviews_default_datagroup
      persist_for: "12 hours"
    }

    dimension_group: createdat {
      description: "This will return the timestamp at the property's timezone. If the timezone is invalid, then PST timezone would be applied."
      label: "Alert"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      sql: TIMESTAMP(DATETIME(${TABLE}.createdat, ${timezone})) ;;
      # sql: ${TABLE}.createdat ;;
    }


  dimension: timezone {
    hidden: no
    description: "This will pull the timezones of the properties from the reservations table. If the timezone is invalid, then PST timezone would be applied."
    type: string
    sql:
      CASE
      WHEN ${TABLE}.timezone = 'America/Chicago' THEN 'America/Chicago'
      WHEN ${TABLE}.timezone = 'America/Los_Angeles' THEN 'America/Los_Angeles'
      WHEN ${TABLE}.timezone = 'America/San_Jose' THEN 'America/Los_Angeles'
      WHEN ${TABLE}.timezone = 'America/New_York' THEN 'America/New_York'
      WHEN ${TABLE}.timezone = 'America/Phoenix' THEN 'America/Phoenix'
      WHEN ${TABLE}.timezone = 'America/Denver' THEN 'America/Denver'
      ELSE 'America/Los_Angeles'
      END;;
  }

    dimension: reservation_id {
      hidden: yes
      type: string
      sql: ${TABLE}.reservation_id ;;
    }

  dimension: confirmationcode {
    hidden: yes
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: source {
    hidden: no
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: unit_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: primary_key {
    hidden: yes
    description: "A primary key has been created to calculate distinct alert occurrences for different time periods / event types / reservation IDs"
    type: string
    sql: CONCAT(${TABLE}.createdat,${TABLE}.eventtype,${TABLE}.reservation_id) ;;
  }

    dimension: eventtype {
      label: "Event Type"
      type: string
      sql: ${TABLE}.eventtype ;;
    }

    dimension: eventtype_smoke{
      # hidden: yes
      description: "This will filter all eventtypes corresponding to smoke alerts from the messages and textmessages table"
      type: yesno
      sql: ${TABLE}.eventtype IN ("kasa-automessages-production-smokeAlert", "smokeAlert");;
    }

    dimension: eventtype_noise{
      # hidden:yes
      description: "This will filter all eventtypes corresponding to noise alerts from the messages and textmessages table"
      type: yesno
      sql: ${TABLE}.eventtype LIKE ("%noise%");;
    }

    dimension: 30_days_ago {
      type: string
      hidden: yes
      sql:
      CASE WHEN ${createdat_date} BETWEEN (DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 30 DAY)) AND (DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles'))) THEN "yes"
      ELSE "no"
      END;;
}

  dimension: 7_days_ago {
    type: string
    hidden: yes
    sql:
      CASE WHEN ${createdat_date} BETWEEN (DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 7 DAY)) AND (DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles'))) THEN "yes"
      ELSE "no"
      END;;
  }

  measure: alerts_smoke {
    label: "# of Smoke Alerts (Total)"
    description: "This will pull all smoke alerts from the messages and textmessages table"
    type: count_distinct
    sql: ${primary_key}  ;;
    filters: [eventtype_smoke: "yes"]
    drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
  }

    measure: alerts_smoke_30 {
      label: "# of Smoke Alerts in the Past 30 Days"
      description: "This will pull all smoke alerts from the messages and textmessages table in the past 30 days"
      type: count_distinct
      sql: ${primary_key}  ;;
      filters: [eventtype_smoke: "yes", 30_days_ago: "yes"]
      drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
    }


  measure: alerts_smoke_7 {
    label: "# of Smoke Alerts in the Past 7 Days"
    description: "This will pull all smoke alerts from the messages and textmessages table in the past 7 days"
    type: count_distinct
    sql: ${primary_key}  ;;
    filters: [eventtype_smoke: "yes", 7_days_ago: "yes"]
    drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
  }

  measure: alerts_noise {
    label: "# of Noise Alerts (Total)"
    description: "This will pull all noise alerts from the messages and textmessages table"
    type: count_distinct
    sql: ${primary_key}  ;;
    filters: [eventtype_noise: "yes"]
    drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
  }

    measure: alerts_noise_30 {
      label: "# of Noise Alerts in the Past 30 Days"
      description: "This will pull all noise alerts from the messages and textmessages table in the past 30 days"
      type: count_distinct
      sql: ${primary_key}  ;;
      filters: [eventtype_noise: "yes", 30_days_ago: "yes"]
      drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
    }

  measure: alerts_noise_7 {
    label: "# of Noise Alerts in the Past 7 Days"
    description: "This will pull all noise alerts from the messages and textmessages table in the past 7 days"
    type: count_distinct
    sql: ${primary_key}  ;;
    filters: [eventtype_noise: "yes", 7_days_ago: "yes"]
    drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
  }

    measure: num_monitored_units {
    label: "Num of Monitored Units (Minut_v1)"
    description: "This will # of Unique Units by internaltitle"
    type: count_distinct
    sql: ${devices._id}  ;;
    filters: [devices.active: "yes", devices.devicetype: "Minut_v1"]
    drill_fields: [createdat_raw, eventtype, confirmationcode, units.internaltitle]
   }


  }
