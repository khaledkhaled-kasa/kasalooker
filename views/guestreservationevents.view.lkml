view: guestreservationevents {
  derived_table: {
    sql: select* FROM `bigquery-analytics-272822.mongo.guestreservationevents`
      ;;
  }


  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
    hidden: no
  }

  dimension: createdby {
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }


  dimension_group: createdat {
    type: time
    sql: ${TABLE}.createdat ;;
    hidden: yes
  }


  dimension: _id {
    type: string
    primary_key: yes
    sql: ${TABLE}._id ;;
    hidden: yes
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
    hidden: yes
  }

  dimension: guest {
    type: string
    sql: ${TABLE}.guest ;;
    hidden: yes
  }

  dimension: eventdetails {
    type: string
    sql: ${TABLE}.eventdetails ;;
    hidden: yes
  }


  dimension_group: eventdate {
    type: time
    sql: ${TABLE}.eventdate ;;
    hidden: yes
  }

  measure:  total_tampering_events {
    type: count_distinct
    sql: CASE WHEN ${TABLE}.event like "%minuttamper.alert%" then ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }



  set: detail {
    fields: [
      reservation,
      createdby,
      event,
      _id,
      unit,
      guest,
      eventdetails
    ]
  }
}
