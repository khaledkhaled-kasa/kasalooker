view: financials_audit {
  derived_table: {
    sql: SELECT financials.*
        FROM financials
          WHERE isvalid is null or isvalid = true
      ;;
  }

  # Amount with old financials table
  measure: amount_revised_base_measure {
    view_label: "Metrics"
    label: "Amount Revised"
    description: "Amount per night"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [isvalid: "yes"]
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

  measure: amount {
    view_label: "Metrics"
    label: "Amount"
    description: "Amount per night"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
  }

  dimension: types_filtered{
    description: "This will filter out Channel Fees / ToTs"
    type: yesno
    sql: ${TABLE}.type is null or ${TABLE}.type not IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability");;
  }

  measure: cleaning_amount {
    type: number
    value_format: "$#,##0.00"
    sql: sum(if(${TABLE}.type = "cleaning",${amount_revised},0)) ;;
  }

  measure: clean_refund_amount {
    type: number
    value_format: "$#,##0.00"
    sql: sum(if(${TABLE}.type = "CleanRefund",${amount_revised},0)) ;;
  }

  measure: cleaning_transactions {
    type: count
    value_format: "0"
    filters: [
      type: "cleaning"
    ]
  }

  measure: cleaning_refund_transactions {
    type: count
    value_format: "0"
    filters: [
      type: "CleanRefund"
    ]
  }

  measure: adr {
    view_label: "Metrics"
    label: "ADR"
    description: "Average daily rate: amount / reservation_night"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_audit.reservation_night}, 0) ;;
  }


  # measure: revpar {
  #   view_label: "Metrics"
  #   label: "RevPar"
  #   description: "Revenue per available room: amount / capacity"
  #   type: number
  #   value_format: "$#,##0.00"
  #   sql: ${amount} / NULLIF(${capacities_rolled_audit.capacity_measure}, 0) ;;
  # }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: isvalid {
    type: yesno
    sql: ${TABLE}.isvalid is null OR ${TABLE}.isvalid = true;;
  }

  dimension: casheventual {
    type: yesno
    sql: ${TABLE}.casheventual ;;
  }

  dimension_group: night {
    hidden:  no
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
  }


  dimension: weekend {
    view_label: "Date Dimensions"
    type:  yesno
    sql:  ${night_day_of_week} in ('Friday', 'Saturday') ;;
  }

  dimension: reservation {
    type: string
    primary_key: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension_group: transaction {
    view_label: "Date Dimensions"
    group_label: "Transaction Date"
    description: "Date of a given financial transaction"
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
    sql: ${TABLE}.transactiondate ;;
  }

  dimension: actualizedat {
    type: string
    sql: ${TABLE}.actualizedat ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }



}
