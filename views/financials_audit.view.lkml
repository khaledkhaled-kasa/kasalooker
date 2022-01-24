view: financials_audit {
  derived_table: {
    sql: SELECT financials.*, DATE(financials.night) as partition_date
          FROM financials
          WHERE isvalid is null or isvalid = true
      ;;

    # persist_for: "1 hour"
    datagroup_trigger: kasametrics_reservations_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
    partition_keys: ["partition_date"]

  }

  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
  }


  dimension: amount_revised {
    hidden: no
    view_label: "Metrics"
    label: "Amount Revised"
    description: "This will correct for unavailable amount__fl values"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN ${TABLE}.amount__fl IS NULL THEN ${TABLE}.amount
          ELSE ${TABLE}.amount__fl
          END;;
  }

  dimension: cashatbooking {
    label: "Is Cash at Booking"
    description: "Is there cash at booking?"
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: isvalid {
    label: "Is Financial Valid"
    description: "Is the financial record valid? isvalid is null or equals true."
    type: yesno
    sql: ${TABLE}.isvalid is null OR ${TABLE}.isvalid = true;;
  }

  dimension: casheventual {
    label: "Is Cash Eventual"
    description: "Is cash eventual?"
    type: yesno
    sql: ${TABLE}.casheventual ;;
  }

  dimension: weekend {
    label: "Is Weekend"
    description: "Is night date a weekend date?"
    view_label: "Date Dimensions"
    type:  yesno
    sql:  ${night_day_of_week} in ('Friday', 'Saturday') ;;
  }

  dimension: _id {
    label: "Financial ID"
    type: string
    hidden: no
    primary_key: yes
    sql: ${TABLE}._id ;;
  }

  dimension: reservation {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension: transactiondate {
    type: string
    hidden: yes
    sql: ${TABLE}.transactiondate;;
  }

  dimension: actualizedat {
    type: string
    label: "Actualized Date"
    description: "Date of actualized"
    hidden: no
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
    --WHEN ${TABLE}.actualizedat is null THEN null
    END;;
  }

  dimension: type {
    label: "Financial Type"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: specified_types {
    label: "Financial Types (RoomRevenue / Other)"
    description: "Financial Types broken out from rom revenue versus all other. Room revenue consists of: Initial, Mod, Discounts, Adj, roomRevenue, roomRevenueDeducted"
    type: string
    sql: CASE WHEN ${TABLE}.type IN ("Initial", "Mod", "Discounts", "Adj", "roomRevenue", "roomRevenueDeducted") THEN "roomRevenue"
          ELSE "Other"
          END;;
  }

  dimension_group: night {
    hidden:  no
    label: "Night"
    view_label: "Date Dimensions"
    group_label: "Stay Night"
    description: "An occupied night at a Kasa"
    type: time
    timeframes: [
      date,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.night ;;
    convert_tz: no
  }

  dimension_group: transaction {
    label: "Transaction"
    view_label: "Date Dimensions"
    group_label: "Transaction Date"
    description: "Date of a given financial transaction"
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
      week,
      month,
      day_of_week
    ]
    sql: cast(${TABLE}.transactiondate as TIMESTAMP);;
    convert_tz: no
  }

  dimension_group: td_stlm {
    label: "Same Time Last Month (STLM)"
    description: "This will provide the date from the same time last MONTH"
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      time,
      day_of_month,
      week,
      month,
      day_of_week
    ]
    sql:
    CASE WHEN EXTRACT(MONTH FROM CURRENT_TIMESTAMP()) IN (1,2,4,6,8,9,11) THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 31 DAY)
    WHEN EXTRACT(MONTH FROM CURRENT_TIMESTAMP()) IN (5,7,10,12) THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 30 DAY)
    ELSE DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 28 DAY)
    END
    ;;
    convert_tz: no
  }

  dimension_group: td_stly {
    label: "Same Time Last Year (STLY)"
    description: "This will provide the date from the same time last YEAR"
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      month,
      day_of_week
    ]
    sql: DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 1 YEAR)
      ;;
    convert_tz: no
  }

  measure: amount {
    view_label: "Metrics"
    label: "Financial Audit Amount"
    description: "Amount per night"
    type: sum_distinct
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [actualizedat_modified: "-Nonactualized (Historic)"]
    drill_fields: [reservations_audit.confirmationcode,reservations_audit.bookingdate_date, reservations_audit.sourcedata_channel, units.propcode, units.internaltitle, reservations_audit.checkindate_date, reservations_audit.checkoutdate_date, reservations_audit.status, transaction_date,type,amount]
  }


   measure: cleaning_amount {
    type: sum_distinct
    label: "Cleaning Amount"
    group_label: "Financial Audit Cleaning"
    description: "Financial Type = cleaning"
    view_label: "Metrics"
    value_format: "$#,##0.00"
    sql: ${amount_revised};;
    filters: [type: "cleaning", actualizedat_modified: "-Nonactualized (Historic)"]
  }

  measure: clean_refund_amount {
    type: sum_distinct
    label: "Cleaning Refund Amount"
    view_label: "Metrics"
    description: "Financial Type = CleanRefund"
    group_label: "Financial Audit Cleaning"
    value_format: "$#,##0.00"
    sql: ${amount_revised};;
    filters: [type: "CleanRefund", actualizedat_modified: "-Nonactualized (Historic)"]
  }


  measure: cleaning_transactions {
    type: count
    label: "# of Cleaning Transactions"
    description: "Financial Type = cleaning"
    view_label: "Metrics"
    group_label: "Financial Audit Cleaning"
    value_format: "0"
    filters: [type: "cleaning", actualizedat_modified: "-Nonactualized (Historic)"]
  }

  measure: cleaning_refund_transactions {
    type: count
    label: "# of Cleaning Refund Transactions"
    description: "Financial Type = CleanRefund"
    view_label: "Metrics"
    group_label: "Financial Audit Cleaning"
    value_format: "0"
    filters: [type: "CleanRefund", actualizedat_modified: "-Nonactualized (Historic)"]
  }

  measure: adr {
    view_label: "Metrics"
    label: "ADR"
    description: "Average daily rate: amount / reservation_night"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_audit.reservation_night}, 0) ;;
  }


}
