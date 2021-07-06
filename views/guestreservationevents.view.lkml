view: guestreservationevents{
  derived_table: {
    sql: SELECT
    sn.*,
    re.confirmationcode ,
    sn.eventdetails.eventlocaltime  as eventlocaltime ,
    sn.eventdetails.eventtimezone as eventtimezone,
    FROM `bigquery-analytics-272822.mongo.guestreservationevents` sn
    JOIN dbt.reservations_v3 re on  sn.reservation= re._id
       ;;
  }

  dimension: _id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}._id ;;
  }

  dimension: reservation {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }


  dimension_group: createdat {
    type: time
    hidden: yes
    sql: ${TABLE}.createdat ;;
  }


  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
  }

  dimension: guest {
    type: string
    hidden: yes
    sql: ${TABLE}.guest ;;
  }

  dimension: eventdetails {
    type: string
    hidden: yes
    sql: ${TABLE}.eventdetails ;;
  }


  dimension_group: eventlocaltime {
    type: time
    label: "Alert local time"
    timeframes: [date,time, week, month]
    sql:   datetime(safe_cast(${TABLE}.eventlocaltime as timestamp),${TABLE}.eventtimezone);;
    convert_tz: no

  }


  dimension: eventtimezone {
    type: string
    sql: ${TABLE}.eventtimezone ;;
    hidden: yes
  }


  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  measure:  tota_tampering_events {
    label: "Total Tampering alerts"
    description: "Minut alert triggered & Minut alert ended"
    type: count_distinct
    sql: CASE WHEN ${TABLE}.event like "%minuttamper.alert.start%" or ${TABLE}.event like "%minuttamper.alert.end%"  then ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }
  measure:  tota_noise_events {
    label: "Total Noise alerts"
    description: "Noise alert triggered & Noise alert ended"
    type: count_distinct
    sql: CASE WHEN ${TABLE}.event like "%noise.alert.start%" or ${TABLE}.event like "%noise.alert.end%"  then ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }
  measure:  tota_smoke_events {
    label: "Total Smoke alerts"
    description: "Smoke alert triggered & Noise alert ended"
    type: count_distinct
    sql: CASE WHEN ${TABLE}.event like "%smoke.alert.start%" or ${TABLE}.event like "%nsmoke.alert.end%"   then ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }
  # measure:  total_reservation {
  #   label: "Total reservation"
  #   type: count_distinct
  #   sql: ${confirmationcode};;
  #   drill_fields: [detail*]
  # }


  set: detail {
    fields: [
      reservation,
      createdby,
      event,
      createdat_time,
      _id,
      unit,
      guest,
      eventdetails,
      confirmationcode
    ]
  }
}
