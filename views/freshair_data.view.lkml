view: freshair_data {
  sql_table_name: `bigquery-analytics-272822.Gsheets.freshair_data`
    ;;

  dimension: disconnection_timestamp {
    type: string
    sql: ${TABLE}.DisconnectionTimestamp ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: uid {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.UID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
