view: devices {
  sql_table_name: `bigquery-analytics-272822.mongo.devices`
    ;;
  drill_fields: [deviceid]

  dimension: deviceid {
    primary_key: yes
    type: string
    sql: ${TABLE}.deviceid ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: battery {
    type: number
    sql: ${TABLE}.battery ;;
  }

  dimension: devicetype {
    type: string
    sql: ${TABLE}.devicetype ;;
  }

  dimension: rssi {
    type: number
    sql: ${TABLE}.rssi ;;
  }

  dimension: wifi_health {
    type: string
    sql: CASE WHEN ${TABLE}.rssi <= -75 THEN "Poor"
    WHEN ${TABLE}.rssi > -74 AND ${TABLE}.rssi <= -68 THEN "Ok"
    WHEN ${TABLE}.rssi >= -67 THEN "Good"
    ELSE "Check rssi"
    END;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: connectionstatus {
    type: string
    sql: ${TABLE}.connectionstatus ;;
  }

  dimension: laststatusupdate {
    type: date_time
    sql: ${TABLE}.laststatusupdate ;;
  }

  dimension: mount_status {
    type:  string
    sql:  ${TABLE}.metadata.mount_status ;;
  }

  measure: count {
    type: count
    drill_fields: [deviceid]
  }
}
