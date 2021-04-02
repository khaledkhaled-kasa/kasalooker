view: nexia_data {
  sql_table_name: `bigquery-analytics-272822.Gsheets.nexia_data`
    ;;

  dimension: uid {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.UID ;;
  }

  dimension: battery_level {
    type: number
    sql: CASE WHEN LENGTH(${TABLE}.BatteryLevel) = 4 THEN CAST(LEFT(${TABLE}.BatteryLevel,3) as FLOAT64)/100.0
              WHEN LENGTH(${TABLE}.BatteryLevel) = 3 THEN CAST(LEFT(${TABLE}.BatteryLevel,2) as FLOAT64)/100.0
              WHEN ${TABLE}.BatteryLevel = 'Unknown' THEN NULL
          END;;
    value_format_name: percent_0
  }

  dimension: code_op_error {
    type: string
    sql: ${TABLE}.CodeOpError ;;
  }

  dimension: connection_status {
    type: string
    sql: ${TABLE}.ConnectionStatus ;;
  }

  dimension: downtime_hours {
    type: string
    sql: ${TABLE}.DowntimeHours ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
