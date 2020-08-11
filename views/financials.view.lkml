view: financials {
  sql_table_name: `bigquery-analytics-272822.mongo.financials`
    ;;

  measure: amount {
    view_label: "Metrics"
    label: "Amount"
    description: "Total financial amount"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.amount__fl ;;
  }

  measure: cleaning_amount {
   type: number
   value_format: "$#,##0.00"
   sql: sum(if(${TABLE}.type = "cleaning",${TABLE}.amount__fl,0)) ;;
  }

  measure: clean_refund_amount {
   type: number
   value_format: "$#,##0.00"
   sql: sum(if(${TABLE}.type = "CleanRefund",${TABLE}.amount__fl,0)) ;;
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
    sql: ${amount} / NULLIF(${reservations.reservation_night}, 0) ;;
  }

  measure: revpar {
    view_label: "Metrics"
    label: "RevPar"
    description: "Revenue per available room: amount / capacity"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${capacities_rolled.capacity_measure}, 0) ;;
  }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: casheventual {
    type: yesno
    sql: ${TABLE}.casheventual ;;
  }

  dimension_group: night {
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

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

}
