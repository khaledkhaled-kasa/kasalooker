view: ximble_hourly_schedule {
  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.ximble.ximble_hourly_schedule`
       ;;
    persist_for: "24 hours"
  }

  dimension: job {
    type: string
    sql: ${TABLE}.job ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: shift {
    type: string
    sql: ${TABLE}.shift ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_week,
      hour_of_day,
      year
    ]
    sql: TIMESTAMP_TRUNC(TIMESTAMP_ADD(${TABLE}.start, INTERVAL 30 MINUTE), HOUR);;
  }

  dimension: time_occupied_mins {
    type: number
    sql: ${TABLE}.time_occupied_mins ;;
  }

  measure: time_occupied_hrs {
    type: sum
    value_format: "#.0"
    sql: (${TABLE}.time_occupied_mins)/60 ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
