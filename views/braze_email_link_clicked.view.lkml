view: braze_email_link_clicked {
  derived_table: {
    sql: SELECT
      id,
      canvas_step_name,
      canvas_name,
      link_url,
      case when
      right(link_url,1) in ("1","2","3","4","5","0") then right(link_url,1) else Null end as rating,
      split(regexp_extract(link_url, '&userid=([^/;]+)'),'&')[OFFSET(0)] as userid,
      split(regexp_extract(link_url, 'confirmationcode=([^/;]+)'),'&')[OFFSET(0)] as confirmationcode,
      timestamp
      from `bigquery-analytics-272822.braze_currents_live.email_link_clicked`
       ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }
  dimension: canvas_step_name {
    type: string
    sql: ${TABLE}.canvas_step_name ;;
  }

  dimension: canvas_name {
    type: string
    sql: ${TABLE}.canvas_name ;;
  }

  dimension: link_url {
    type: string
    sql: ${TABLE}.link_url ;;
  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [week,month,day_of_week,time,date]

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      canvas_step_name,
      canvas_name,
      link_url,
      rating,
      userid,
      confirmationcode,
      timestamp_time
    ]
  }
}
