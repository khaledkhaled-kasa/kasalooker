view: braze_canvas_converted {
 sql_table_name:`bigquery-analytics-272822.braze_currents_live.canvas_converted` ;;


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
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

  }

  set: detail {
    fields: [id, app_id, canvas_name, canvas_step_name, timestamp_time]
  }
}
