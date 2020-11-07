view: hk_names {
  sql_table_name: `bigquery-analytics-272822.Breezeway_Data.hk_names`
    ;;

  dimension: breezeway_name {
    type: string
    sql: ${TABLE}.Breezeway_name ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: scorecard_name {
    type: string
    sql: ${TABLE}.Scorecard_name ;;
  }

  measure: count {
    type: count
    drill_fields: [scorecard_name, breezeway_name]
  }
}
