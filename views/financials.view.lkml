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
    sql:  ${night_day_of_week} in ('Saturday', 'Sunday') ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
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
