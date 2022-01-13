view: braze_webhook_sent {
sql_table_name: `bigquery-analytics-272822.braze_currents_live.webhook_sent`;;



  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: canvas_name {
    type: string
    sql: ${TABLE}.canvas_name ;;
  }

  dimension: canvas_step_name {
    type: string
    sql: ${TABLE}.canvas_step_name ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [date,week,month,time,day_of_week]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [id, canvas_name, canvas_step_name, timestamp_time, user_id]
  }
}
