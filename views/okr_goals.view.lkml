view: okr_goals {
  sql_table_name: `bigquery-analytics-272822.mongo.okr_goals`
    ;;

  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: key_result {
    type: string
    sql: ${TABLE}.Key_Result ;;
  }

  dimension: objective {
    type: string
    sql: ${TABLE}.Objective ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.Owner ;;
  }

  dimension: target {
    type: number
    sql: ${TABLE}.Target ;;
  }

  dimension_group: time_period {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Time_Period ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
