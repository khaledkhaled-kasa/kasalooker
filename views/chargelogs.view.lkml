view: chargelogs {
  sql_table_name: `bigquery-analytics-272822.mongo.chargelogs`
    ;;

  dimension: __v {
    type: number
    hidden: yes
    sql: ${TABLE}.__v ;;
  }

  dimension: _id {
    hidden: yes
    primary_key: yes
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

  dimension_group: _sdc_deleted {
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
    sql: ${TABLE}._sdc_deleted_at ;;
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
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }

  dimension: amount_fl {
    type: number
    sql: ${TABLE}.amount__fl ;;
  }

  dimension: charge_id {
    type: string
    sql: ${TABLE}.chargeid ;;
  }

  dimension_group: created_at {
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.metadata.source ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

}
