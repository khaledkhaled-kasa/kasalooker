view: guestreservationevents{
  derived_table: {
    sql: SELECT
    sn.*,
    re.confirmationcode ,
    sn.eventdetails.eventtimezone as eventtimezone ,
    sn.eventdetails.eventlocaltime  as eventlocaltime,
    sn.eventdetails,
    sn.eventdetails.source as eventdetailsSource
    FROM `bigquery-analytics-272822.mongo.guestreservationevents` sn
    JOIN dbt.reservations_v3 re on  sn.reservation= re._id
       ;; # sn.eventdetails.eventlocaltime  as eventlocaltime ,
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

  dimension: eventdetailsSource {
    type: string
    hidden: yes
    sql: ${TABLE}.eventdetailsSource ;;
  }
  dimension: eventdetails {
    type: string
    hidden: yes
    sql: ${TABLE}.eventdetails ;;
  }


  dimension:noise_incidents{
    type: yesno
    sql:  CASE WHEN ${TABLE}.eventdetailsSource like "%noiseFinalWarning%" then True
    else False
    end
    ;;
  }


  dimension_group: eventlocaltime {
    type: time
    label: "Alert local time"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql:   TIMESTAMP(datetime(safe_cast(${TABLE}.eventlocaltime as timestamp),${TABLE}.eventtimezone));;
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
    hidden: yes
  }

  measure:  tota_tampering_events {
    label: "Total Tampering Alerts"
    type: count_distinct
    sql: ${_id};;
    filters: [eventdetailsSource: "kasa-automessages-production-minutTamperReplacedAlert"]
    drill_fields: [detail*]
  }
  measure:  tota_noise_events {
    label: "Total Noise Alerts"
    type: count_distinct
    sql: ${_id} ;;
    filters: [event: "noise.alert.warning"]
    drill_fields: [detail*]
  }
  measure:  tota_smoke_events {
    label: "Total Smoke Alerts(Incidents)"
    type: count_distinct
    sql: CASE WHEN  ${TABLE}.event like "%smoke.alert.start%"  and ${TABLE}.eventdetailsSource="kasa-automessages-production-smokeAlert"  then ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }
  measure:  total_reservation_tamper {
    label: "Total reservations (MinutTamper)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [eventdetailsSource: "kasa-automessages-production-minutTamperReplacedAlert"]
    drill_fields: [detail*]
  }
  measure:  total_reservation_noise {
    label: "Total reservations (Noise)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [event: "noise.alert.warning"]
    drill_fields: [detail*]
  }
  measure:  total_reservation_smoke {
    label: "Total reservations (Smoke)"
    type: count_distinct
    sql: CASE WHEN ${TABLE}.event like "%smoke.alert.start%"  and ${TABLE}.eventdetailsSource="kasa-automessages-production-smokeAlert" then ${confirmationcode}  ELSE NULL END ;;
    drill_fields: [detail*]
  }

  measure:  total_first_alert {
    label: "First Noise Alerts"
    type: count_distinct
    sql: ${_id} ;;
    filters: [eventdetailsSource: "%noiseFirstWarning%"]
    drill_fields: [detail*]
  }
  measure:  total_second_alert {
    label: "Second Noise Alerts"
    type: count_distinct
    sql: ${_id} ;;
    filters: [eventdetailsSource: "%noiseSecondWarning%"]
    drill_fields: [detail*]
  }
  measure:  total_Fina_alert {
    label: "Final Noise Alerts(Incidents)"
    type: count_distinct
    sql: ${_id} ;;
    filters: [eventdetailsSource: "%noiseFinalWarning%"]
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      reservation,
      createdby,
      event,
      createdat_time,
      _id,
      unit,
      guest,
      eventdetailsSource,
      confirmationcode
    ]
  }
}
