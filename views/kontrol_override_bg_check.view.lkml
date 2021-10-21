
view:  kontrol_override_bg_check {
  label:"Override BG Check"
  derived_table: {
    sql: select
          re.confirmationcode,
          bgch.id,
          bgch.reservation_id,
          bgch.original_timestamp,
          from
          `bigquery-analytics-272822.website_kontrol.override_bg_check` bgch
          left join
          mongo.reservations re
          on
          bgch.reservation_id=re._id

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
