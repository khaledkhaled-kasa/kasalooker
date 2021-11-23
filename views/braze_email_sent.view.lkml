view: braze_email_sent {
  sql_table_name:`bigquery-analytics-272822.braze_currents_live.email_sent` ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden:yes
  }

  dimension: canvas_step_name {
    type: string
    sql: ${TABLE}.canvas_step_name ;;
  }

  dimension: canvas_name {
    type: string
    sql: ${TABLE}.canvas_name ;;
  }

  dimension: context_traits_email {
    type: string
    sql: ${TABLE}.context_traits_email ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_Id ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [week,month,day_of_week,time,date]

  }

  set: detail {
    fields: [
      id,
      canvas_step_name,
      canvas_name,
      context_traits_email,
      user_id,
      timestamp_time
    ]
  }
}
