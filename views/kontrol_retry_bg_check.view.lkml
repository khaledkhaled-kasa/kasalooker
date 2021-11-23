view: kontrol_retry_bg_check {
  label: "Retry BG Check"
  derived_table: {
    sql: select
    re.confirmationcode,
    idc.id,
    idc.reservation_id,
    idc.original_timestamp,
    from
    `bigquery-analytics-272822.website_kontrol.retry_bg_check` idc
    left join
    mongo.reservations re
    on
    idc.reservation_id=re._id

       ;;
      persist_for: "1 hour"
  }




  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: reservation_id {
    type: string
    sql: ${TABLE}.reservation_id ;;
    hidden: yes
  }
  dimension:confermationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.original_timestamp ;;
  }
  measure: count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [id, reservation_id , timestamp_time]
  }
}
