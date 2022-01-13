# The name of this view in Looker is "Tasks"
view: tasks {

  sql_table_name: `bigquery-analytics-272822.mongo.tasks`
    ;;


  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
    hidden: yes
  }


  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }


  dimension_group: _sdc_batched {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: assignees {
    hidden: no
    sql: ${TABLE}.assignees ;;
  }

  dimension: auditlog {
    hidden: yes
    sql: ${TABLE}.auditlog ;;
  }

  dimension: breezewaydescription {
    type: string
    sql: ${TABLE}.breezewaydescription ;;
  }

  dimension: breezewayid {
    type: string
    sql: ${TABLE}.breezewayid ;;
  }

  dimension: breezewaystatus {
    type: string
    sql: ${TABLE}.breezewaystatus ;;
  }

  dimension: breezewaytitle {
    type: string
    sql: ${TABLE}.breezewaytitle ;;
  }

  dimension_group: createdat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdat ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: kustomerid {
    type: string
    sql: ${TABLE}.kustomerid ;;
  }

  dimension: kustomertaskurl {
    type: string
    sql: ${TABLE}.kustomertaskurl ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: scheduleddate {
    type: string
    sql: ${TABLE}.scheduleddate ;;
  }

  dimension: scheduledtime {
    type: string
    sql: ${TABLE}.scheduledtime ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension_group: updatedat {
    hidden: no
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedat ;;
  }

}
