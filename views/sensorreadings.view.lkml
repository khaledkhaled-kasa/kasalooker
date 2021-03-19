# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: sensorreadings {
  hidden: yes

  join: sensorreadings__readings {
    view_label: "Sensorreadings: Readings"
    sql: LEFT JOIN UNNEST(${sensorreadings.readings}) as sensorreadings__readings ;;
    relationship: one_to_many
  }
}

view: sensorreadings {
  sql_table_name: `bigquery-analytics-272822.mongo.sensorreadings`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension_group: _sdc_batched {
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
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension_group: endtime {
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
    sql: ${TABLE}.endtime ;;
  }

  dimension: readings {
    hidden: yes
    sql: ${TABLE}.readings ;;
  }

  dimension: sensor {
    type: string
    sql: ${TABLE}.sensor ;;
  }

  dimension_group: starttime {
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
    sql: ${TABLE}.starttime ;;
  }

  dimension: totalreadings {
    type: number
    sql: ${TABLE}.totalreadings ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: sensorreadings__readings {
  dimension: value__co2 {
    type: number
    sql: ${TABLE}.value.co2 ;;
    group_label: "Value"
    group_item_label: "Co2"
  }

  dimension: value__humidity {
    type: number
    sql: ${TABLE}.value.humidity ;;
    group_label: "Value"
    group_item_label: "Humidity"
  }

  dimension: value__noise {
    type: number
    sql: ${TABLE}.value.noise ;;
    group_label: "Value"
    group_item_label: "Noise"
  }

  dimension: value__temperature {
    type: number
    sql: ${TABLE}.value.temperature ;;
    group_label: "Value"
    group_item_label: "Temperature"
  }

  dimension: value__temperature__it {
    type: number
    sql: ${TABLE}.value.temperature__it ;;
    group_label: "Value Temperature"
    group_item_label: "It"
  }

  dimension_group: value__timestamp {
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
    sql: ${TABLE}.value.timestamp ;;
    group_label: "Value"
    group_item_label: "Timestamp"
  }
}
