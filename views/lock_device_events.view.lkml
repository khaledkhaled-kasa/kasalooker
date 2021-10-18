view: lock_device_events {
  view_label: "Devices Events (Locks)"
  sql_table_name: `bigquery-analytics-272822.mongo.events` ;;


  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: buildingid {
    type: string
    hidden: yes
    sql: ${TABLE}.buildingid ;;
  }

  dimension: eventname {
    type: string
    sql: ${TABLE}.eventname ;;
    hidden: yes
  }

  dimension_group: event {
    type: time
    timeframes: [day_of_week,date,time,week,month,year]
    sql: safe_cast(${TABLE}.eventtimestamp as timestamp) ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.originalpayload.codedetails.code ;;
  }

  dimension: codetype {
    type: string
    sql: ${TABLE}.originalpayload.codedetails.codetype ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.originalpayload.codedetails.confirmationcode ;;
  }

  dimension: deviceid {
    type: string
    hidden: yes
    sql: ${TABLE}.deviceid ;;
  }

  dimension: reservationid {
    type: string
    hidden: yes
    sql: ${TABLE}.reservationid ;;
  }
  dimension: eventValue {
    type: string
    label: "Event Name"
    sql: ${TABLE}.events.originalpayload.eventvaluedetails.eventname ;;
  }

  dimension: unitid {
    hidden: no
    type: string
    sql: ${TABLE}.unitid ;;
  }

  measure: count {
    type: count_distinct
    sql: ${_id} ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      _id,
      buildingid,
      eventname,
      event_time,
      code,
      codetype,
      confirmationcode,
      deviceid,
      reservationid,
      unitid
    ]
  }
}
