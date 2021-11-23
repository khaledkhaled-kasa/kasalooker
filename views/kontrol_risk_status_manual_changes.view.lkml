view: kontrol_risk_status_manual_changes{
  view_label: "Risk Status Manual Changes"
  derived_table: {
    sql: select
          re.confirmationcode,
          ris.id,
          ris.reservation_id,
          ris.original_timestamp,
          ris.changed_from ,
          ris.changed_to
          from
          `bigquery-analytics-272822.website_kontrol.risk_status_manual_changes` ris
          left join
          mongo.reservations re
          on
          ris.reservation_id=re._id

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
  dimension: changed_from {
    type: string
    sql: ${TABLE}.changed_from ;;
  }

  dimension: changed_to {
    type: string
    sql: ${TABLE}.changed_to ;;
  }


  set: detail {
    fields: [id, reservation_id , timestamp_time]
  }
}
