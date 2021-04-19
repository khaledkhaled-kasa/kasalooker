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
    sql: ${TABLE}.amount/100.00 ;;
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

  dimension: risk_level {
    type: string
    sql: ${TABLE}.risk.level ;;
  }

  dimension: risk_score {
    type: number
    sql: ${TABLE}.risk.score ;;
  }

  dimension: risk_score_tier {
    type: tier
    tiers: [9,20,30,40,50,60,70,80,90,100]
    sql: ${risk_score} ;;
    style: integer
  }

  measure: count_security_deposit {
    type: count
  }

}
