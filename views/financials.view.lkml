view: financials {
  sql_table_name: `bigquery-analytics-272822.mongo.financials`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }


  measure: amount {
    type: sum
    sql: ${TABLE}.amount ;;
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
#     view_label: "Dates"
    group_label: "Stay Night"
    description: "An occupied night at a Kasa"
    type: time
    timeframes: [
      month_name,
      week_of_year,
      day_of_week,
      date,
      week,
      month,
      quarter,
      year,
      raw
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

  measure: count {
    type: count
    drill_fields: []
  }
}
