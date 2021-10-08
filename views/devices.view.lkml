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
    WHEN ${TABLE}.rssi >= -74 AND ${TABLE}.rssi <= -68 THEN "Ok"
    WHEN ${TABLE}.rssi >= -67 THEN "Good"
    ELSE "Check rssi"
    END;;
  }

  dimension_group: install {
    label: "Minut device Installition Date"
    type: time
    timeframes: [date, week, month, year]
    sql: CAST(LEFT(${TABLE}.metadata.first_seen_at,10) as TIMESTAMP) ;;
    convert_tz: no
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: connectionstatus {
    type: string
    sql: ${TABLE}.connectionstatus ;;
  }

  dimension_group: laststatusupdate {
    type: time
    timeframes: [time, date, month, year, quarter, week]
    sql: ${TABLE}.laststatusupdate ;;
  }

  dimension: mount_status {
    type:  string
    sql:  ${TABLE}.metadata.mount_status ;;
  }

  dimension: smoke_requires_new_sensor {
    type:  string
    sql:  ${TABLE}.smoke.requiresnewsensors ;;
  }

  dimension: noise_sound_level_high {
    type:  string
    sql:  ${TABLE}.noise.sound_level_high ;;
  }

  dimension: noise_sound_level_high_quiet_hours {
    type:  string
    sql:  ${TABLE}.noise.sound_level_high_quiet_hours ;;
  }

  measure: avg_minut_health {
    type: average
    sql: ${rssi} ;;
    value_format_name: decimal_2
  }

  measure: count {
    type: count
    drill_fields: [deviceid]
  }


  measure: all_devices {
    label: "# of Devices"
    description: "Returns a count of all devices"
    type: count_distinct
    sql: ${deviceid} ;;
    filters: [connectionstatus: "-null"]
  }

  measure: online_devices {
    label: "# of Online Devices"
    description: "Returns a count of all devices that are 'online"
    type: count_distinct
    sql: ${deviceid} ;;
    filters: [connectionstatus: "online"]
  }

  measure: pct_online_devices {
    label: "% of Online Devices"
    description: "Returns % of all devices that are 'online"
    type: number
    value_format: "0%"
    sql: ${online_devices} / nullif(${all_devices},0) ;;
    drill_fields: [units_buildings_information.internaltitle, connectionstatus]
  }

  measure: total_smartthings_devices {
    label: "Total SmartThings Devices"
    description: "Returns a count of all ACTIVE SmartThings devices."
    type: count_distinct
    sql: ${deviceid} ;;
    filters: [devicetype: "Smartthings_v1",active: "yes, Yes"]
  }

  measure: total_minut_devices {
    label: "Total Minut Devices"
    description: "Returns a count of all ACTIVE Minut devices."
    type: count_distinct
    sql: ${deviceid} ;;
    filters: [devicetype: "%Minut%", active: "yes, Yes"]
  }

  measure: total_freshAir_devices {
    label: "Total FreshAir Devices"
    description: "Returns a count of all ACTIVE FreshAir devices."
    type: count_distinct
    sql: ${deviceid} ;;
    filters: [devicetype: "FreshAir_v1",  connectionstatus: "online"]
  }

  measure: running_total_minut_devices {
    label: "Running Total Minut Devices"
    type: running_total
    sql: CASE WHEN ${devicetype} LIKE '%Minut%' THEN ${deviceid} ELSE NULL END ;;
    # filters: [devicetype: "%Minut%"]
  }
  measure: running_total_snartthings_devices {
    label: "Running Total SmartThings Devices"
    type: running_total
    sql: CASE WHEN ${devicetype} LIKE "Schlage Door Lock" THEN ${deviceid} ELSE NULL END ;;

  }
  measure: running_total_frishaire_devices {
    label: "Running Total FreshAir Devices"
    type: running_total
    sql: CASE WHEN ${devicetype} LIKE "FreshAir_v1" THEN ${deviceid} ELSE NULL END ;;

  }

  measure: fresh_air_score {
    type: number
    view_label: "POM Scorecard"
    hidden: no
    sql:  CASE WHEN ${pct_online_devices} >= 0.93 THEN 1
          ELSE ${pct_online_devices} / NULLIF(0.93,0)
          END;;
    value_format: "0.0"
  }

  measure: fresh_air_score_weighted {
    label: "Fresh Air Score (Weighted)"
    view_label: "POM Scorecard"
    type: number
    sql: ${fresh_air_score} * ${pom_information.FreshAir_Weighting} ;;
    value_format: "0.00"
  }



}
