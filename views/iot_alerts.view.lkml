view: iot_alerts {
  label: "IOT Alerts"
  derived_table: {
    sql: SELECT se.raw.event.id as eventid,se.sensortype
      , se.deviceid,
      se.createdat,
      DATE(se.createdat) as eventCreateDate,
      DATE(re.checkindate) as checkindate,
      DATE(re.checkoutdate) as checkoutdate,
      re.confirmationcode ,
      se.type,
      se._id AS home_id,
      d.devicetype,
      d.noise.mount_status,
      d.noise.sound_level_high,
      d.noise.sound_level_high_quiet_hours,
      d._id,
      d.unit,
      d.smoke,
      d.connectionstatus
      FROM sensorevents se JOIN devices d ON se.deviceid = d.deviceid
      JOIN dbt.reservations_v3 re ON d.unit=re.unit AND date(se.createdat) between date(re.checkindate) and date(re.checkoutdate)
      WHERE  re.confirmationcode is not null
 ;;
  }


  dimension: eventid {
    type: string
    primary_key: yes
    sql: ${TABLE}.eventid ;;
  }

  dimension: sensortype {
    type: string
    sql: ${TABLE}.sensortype ;;
  }

  dimension: deviceid {
    type: string
    sql: ${TABLE}.deviceid ;;
  }

  dimension_group: event_create_date {
    label: "Alert Time"
    type: time
    timeframes: [date,week,month,year]
    sql: ${TABLE}.createdat ;;
  }

  dimension: checkindate {
    type: date
    hidden: yes
    datatype: date
    sql: ${TABLE}.checkindate ;;
  }

  dimension: checkoutdate {
    type: date
    hidden: yes
    datatype: date
    sql: ${TABLE}.checkoutdate ;;
  }

  dimension: confirmationcode {
    type: string
    hidden: yes
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: type {
    label: "Alert Type"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: home_id {
    hidden: yes
    type: string
    sql: ${TABLE}.home_id ;;
  }

  dimension: devicetype {
    label: "Device Type"
    type: string
    sql: ${TABLE}.devicetype ;;
  }

  dimension: mount_status {
    type: string
    sql: ${TABLE}.mount_status ;;
  }

  dimension: sound_level_high {
    type: number
    sql: ${TABLE}.sound_level_high ;;
  }

  dimension: sound_level_high_quiet_hours {
    type: number
    sql: ${TABLE}.sound_level_high_quiet_hours ;;
  }

  dimension: _id {
    hidden: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: unit {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: smoke {
    type: string
    hidden: yes
    sql: ${TABLE}.smoke ;;
  }

  dimension: connectionstatus {
    hidden: yes
    type: string
    sql: ${TABLE}.connectionstatus ;;
  }

  measure: total_noise_alerts {
    label: "Total Noise Alerts"
    type: count_distinct
    drill_fields: [confirmationcode,event_create_date_date]
    sql: ${eventid};;
    filters: [type: "alarm_heard"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      eventid,
      sensortype,
      deviceid,
      event_create_date_date,
      checkindate,
      checkoutdate,
      confirmationcode,
      type,
      home_id,
      devicetype,
      mount_status,
      sound_level_high,
      sound_level_high_quiet_hours,
      _id,
      unit,
      smoke,
      connectionstatus
    ]
  }
}
