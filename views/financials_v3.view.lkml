view: financials_v3{
  label: "Financials"
  derived_table: {
    sql: SELECT financials.*,
        CASE WHEN CAST(financials.night as date) < '2021-01-01' THEN (t2.outstanding_amount / t3.count_nights_room_revenue)
        ELSE null
        END nightly_outstanding_amount
        FROM financials
        LEFT JOIN

        (SELECT confirmationcode, reservation_id, 'roomRevenue' as Type, outstanding_amount
        FROM
          (SELECT reservations.confirmationcode as confirmationcode, financials.reservation as reservation_id,
          (COALESCE(sum(amount),0) + COALESCE(sum(amount__fl),0)) as outstanding_amount
          FROM financials JOIN reservations
          ON financials.reservation = reservations._id
          WHERE (CAST(financials.night AS DATE) < CAST(timestamp(reservations.checkindate) AS DATE) OR CAST(financials.night AS DATE) >= CAST(timestamp(reservations.checkoutdate) AS DATE))
          AND financials.type NOT IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability")
          AND (isvalid is null or isvalid = true)
          GROUP BY 1,2)t1)t2

        ON financials.reservation = t2.reservation_id
        AND financials.type = t2.type

        LEFT JOIN

        (SELECT financials.reservation as reservationid, count(*) as count_nights_room_revenue
        FROM financials JOIN reservations
        ON financials.reservation = reservations._id
        AND financials.type = 'roomRevenue'
        AND (CAST(financials.night AS DATE) >= CAST(timestamp(reservations.checkindate) AS DATE) AND CAST(financials.night AS DATE) < CAST(timestamp(reservations.checkoutdate) AS DATE))
        GROUP BY 1)t3
        ON financials.reservation = t3.reservationid
        where financials.isvalid is null or financials.isvalid = true
      ;;


    # persist_for: "1 hour"
    datagroup_trigger: kasametrics_v3_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }



  dimension: amount_revised {
    hidden: yes
    view_label: "Metrics"
    label: "Amount Revised"
    description: "This will correct for unavailable amount__fl values"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN ${TABLE}.amount__fl IS NULL THEN ${TABLE}.amount
          ELSE ${TABLE}.amount__fl
          END;;
  }


  measure: amount_original {
    view_label: "Metrics"
    label: "Original Amount"
    hidden: yes
    description: "This is amount as per payment received dates"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", types_filtered: "yes"]
    }

  measure: amount_original_unfiltered {
    view_label: "Metrics"
    label: "Original Amount"
    hidden: yes
    description: "This is amount as per payment received dates"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)"]
  }


  measure: amount_outstanding {
    view_label: "Metrics"
    hidden: yes
    label: "Amount Outstanding"
    description: "This is the amount missing from previous scheduled nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", types_filtered: "yes"]
  }

  measure: amount_outstanding_unfiltered {
    view_label: "Metrics"
    hidden: yes
    label: "Amount Outstanding"
    description: "This is the amount missing from previous scheduled nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)"]
  }

  measure: amount {
    view_label: "Metrics"
    label: "Amount"
    description: "This amount will automatically filter for only confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount_original} + ${amount_outstanding};;
  }

  measure: amount_unfiltered {
    view_label: "Metrics"
    label: "Amount (Unfiltered)"
    description: "This amount is unfiltered (all reservation status & financial types)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount_original_unfiltered} + ${amount_outstanding_unfiltered};;
  }


  measure: adr {
    view_label: "Metrics"
    label: "ADR"
    description: "Average daily rate: amount / reservation_night. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
  }

# This is the same as ADR - REQUEST MADE BY TAFT LANDLORD
  measure: revenue_per_booked_room {
    view_label: "Metrics"
    label: "Revenue per Booked Room"
    description: "Average daily rate: amount / reservation_night. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
  }


  measure: revpar {
    view_label: "Metrics"
    label: "RevPar"
    description: "Revenue per available room: amount / capacity. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${capacities_v3.capacity}, 0) ;;
  }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: isvalid {
    type: yesno
    hidden: yes
    sql: ${TABLE}.isvalid is null OR ${TABLE}.isvalid = true;;
  }

  dimension: casheventual {
    type: yesno
    hidden: yes
    sql: ${TABLE}.casheventual ;;
  }

  dimension_group: night {
    hidden:  yes
    view_label: "Date Dimensions"
    group_label: "Financial Night"
    description: "An occupied night at a Kasa"
    label: "Financial"
    type: time
    timeframes: [
      date,
      week_of_year,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.night ;;
    convert_tz: no
  }


  dimension: _id {
    type: string
    primary_key: yes
    sql: ${TABLE}._id ;;
  }

  dimension: reservation {
    type: string
    # primary_key: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension_group: transaction {
    description: "Date of a given financial transaction"
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week
    ]
    sql: cast(${TABLE}.transactiondate as TIMESTAMP);;
  }

  dimension: transactiondate {
    type: string
    hidden: yes
    sql: ${TABLE}.transactiondate ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: types_filtered{
    description: "This will filter out Channel Fees / ToTs"
    type: yesno
    sql: ${TABLE}.type is null or ${TABLE}.type not IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability");;
  }

  dimension: actualizedat {
    type: string
    hidden: yes
    sql: ${TABLE}.actualizedat ;;
  }

  dimension: actualizedat_modified {
    label: "Actualized Record"
    description: "This will only pull actualized records for any financial records up to today and nonactualized records for future nights"
    type: string
    sql:
    CASE WHEN (${night_date} >= CURRENT_DATE("America/Los_Angeles")) THEN "Future Booking"
    WHEN (${TABLE}.actualizedat is not null) THEN "Actualized"
    WHEN (${night_date} < "2020-09-01") THEN "Older Booking"
    WHEN (${TABLE}.actualizedat is null and ${TABLE}._id is not null) THEN "Nonactualized (Historic)"
    END;;
  }


}
