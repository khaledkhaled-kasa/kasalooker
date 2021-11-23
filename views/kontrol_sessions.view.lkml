view: kontrol_sessions{
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.website_kontrol_transformed.sessions_struct` LEFT JOIN UNNEST(event_key) as event_key
      ;;
    persist_for: "1 hours"
  }


  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
    hidden: yes
  }

  dimension_group: session{
    type: time
    timeframes: [date, time, week, year,month]
    sql: ${TABLE}.session_timestamp ;;
  }

  dimension: event_key {
    type: string
    hidden: yes
    sql: ${TABLE}.event_key ;;
  }

  dimension: event_id {
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }
  measure: count {
    type: count
    value_format:"[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      session_id,
      anonymous_id,
      session_time,
      event_key,
      event_id,
      event
    ]
  }
}
