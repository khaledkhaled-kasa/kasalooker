view: unit_submission_data {
  sql_table_name: `bigquery-analytics-272822.Gsheets.unit_submission_data`
    ;;

  dimension: building {
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: visit_time {
    type: string
    sql: ${TABLE}.VisitTime ;;
  }

  dimension: visit_type {
    type: string
    sql: ${TABLE}.VisitType ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
