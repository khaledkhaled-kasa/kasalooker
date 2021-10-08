view: hub_devices {
      derived_table: {
        sql:
        select*
        from
        (
          SELECT *, dense_rank() over (partition by devicetype , unit order by laststatusupdate desc) as lastupdate FROM `bigquery-analytics-272822.mongo.devices`
          where devicetype IN ('Nexia_v1', 'Smartthings_v1') and active=true
        )where lastupdate=1;;
          persist_for: "1 hours"
        }

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
}
