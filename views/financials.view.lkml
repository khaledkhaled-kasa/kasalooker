view: financials {
  sql_table_name: `bigquery-analytics-272822.mongo.financials`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }


  measure: amount {
    label: "Amount"
    description: "Total financial amount"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.amount__fl ;;
  }

  measure: adr {
    label: "ADR"
    description: "Average daily rate: amount / reservation_night"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / ${reservations.reservation_night} ;;
  }

  measure: revpar {
    label: "RevPar"
    description: "Revenue per available room: amount / capacity"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / ${capacities_rolled.capacity_measure} ;;
  }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: casheventual {
    type: yesno
    sql: ${TABLE}.casheventual ;;
  }

  dimension_group: createdat {
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
    sql: ${TABLE}.createdat ;;
  }

  dimension_group: night {
    group_label: "Stay Night"
    description: "An occupied night at a Kasa"
    type: time
    timeframes: [
      month_name,
      week_of_year,
      day_of_week,
      date,
      week,
      month
    ]
    sql: ${TABLE}.night ;;
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

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }


}
