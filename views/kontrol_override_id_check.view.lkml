view: kontrol_override_id_check {
  label: "Override ID Check"
  derived_table: {
    sql: select
          re.confirmationcode,
          idch.id,
          idch.reservation_id,
          idch.original_timestamp,
          from
          `bigquery-analytics-272822.website_kontrol.override_id_check` idch
          left join
          mongo.reservations re
          on
          idch.reservation_id=re._id

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
