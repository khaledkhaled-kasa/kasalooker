view: sensorevents {
  sql_table_name: `bigquery-analytics-272822.mongo.sensorevents`
    ;;

  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
  }

  dimension: _id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension_group: _sdc_batched {
    hidden: yes
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
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
    hidden: yes
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
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
    hidden: yes
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
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension_group: createdat {
    label: "Created"
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

  dimension: deviceid {
    type: string
    sql: ${TABLE}.deviceid ;;
  }

  dimension: raw__event__created_at {
    type: string
    sql: ${TABLE}.raw.event.created_at ;;
    group_label: "Raw Event"
    group_item_label: "Created At"
  }

  dimension: raw__event__device_id {
    type: string
    sql: ${TABLE}.raw.event.device_id ;;
    group_label: "Raw Event"
    group_item_label: "Device ID"
  }

  dimension: raw__event__event_id {
    type: string
    sql: ${TABLE}.raw.event.event_id ;;
    group_label: "Raw Event"
    group_item_label: "Event ID"
  }

  dimension: raw__event__home_id {
    type: string
    sql: ${TABLE}.raw.event.home_id ;;
    group_label: "Raw Event"
    group_item_label: "Home ID"
  }

  dimension: raw__event__id {
    type: string
    sql: ${TABLE}.raw.event.id ;;
    group_label: "Raw Event"
    group_item_label: "ID"
  }

  dimension: raw__event__type {
    type: string
    sql: ${TABLE}.raw.event.type ;;
    group_label: "Raw Event"
    group_item_label: "Type"
  }

  dimension: raw__event__user_id {
    type: string
    sql: ${TABLE}.raw.event.user_id ;;
    group_label: "Raw Event"
    group_item_label: "User ID"
  }

  dimension: raw__hook_digest {
    type: string
    sql: ${TABLE}.raw.hook_digest ;;
    group_label: "Raw"
    group_item_label: "Hook Digest"
  }

  dimension: raw__hook_id {
    type: string
    sql: ${TABLE}.raw.hook_id ;;
    group_label: "Raw"
    group_item_label: "Hook ID"
  }

  dimension: raw__secret {
    type: string
    sql: ${TABLE}.raw.secret ;;
    group_label: "Raw"
    group_item_label: "Secret"
  }

  dimension: sensortype {
    type: string
    sql: ${TABLE}.sensortype ;;
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

  measure: total_tampering_events {
    type: count_distinct
    sql: ${_id} ;;
    filters: [type: "tamper"]
  }

}
