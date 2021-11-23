
view: kontrol_open_door_remotely {
  label: "Open Door Remotely"
  derived_table: {
    sql: select
          re.confirmationcode,
          dr.id,
          dr.reservation_id,
          dr.original_timestamp,
          from
          `bigquery-analytics-272822.website_kontrol.open_door_remotely` dr
          left join
          mongo.reservations re
          on
          dr.reservation_id=re._id

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
