view: aircalls_september26 {
  sql_table_name: `bigquery-analytics-272822.aircall.Aircalls_September26`
    ;;

  dimension: answered {
    type: yesno
    sql: ${TABLE}.answered ;;
  }

  dimension: call_quality {
    type: string
    hidden: yes
    sql: ${TABLE}.call_quality ;;
  }

  dimension: comments {
    type: string
    hidden: yes
    sql: ${TABLE}.comments ;;
  }

  dimension_group: date__tz_offset_incl__ {
    type: time
    label: ""
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date__TZ_offset_incl__ ;;
  }

  dimension: datetime__utc_ {
    type: string
    hidden: yes
    sql: ${TABLE}.datetime__UTC_ ;;
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
  }

  dimension: duration__in_call_ {
    type: number
    sql: ${TABLE}.duration__in_call_ ;;
  }

  dimension: duration__total_ {
    type: number
    sql: ${TABLE}.duration__total_ ;;
  }

  dimension: from {
    type: string
    hidden: yes
    sql: ${TABLE}.`from` ;;
  }

  dimension: line {
    type: string
    sql: ${TABLE}.line ;;
  }

  dimension: missed_call_reason {
    type: string
    sql: ${TABLE}.missed_call_reason ;;
  }

  dimension: number_timezone {
    type: string
    hidden: yes
    sql: ${TABLE}.number_timezone ;;
  }

  dimension: recording {
    type: string
    hidden: yes
    sql: ${TABLE}.recording ;;
  }

  dimension: tags {
    type: string
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: teams {
    type: string
    sql: ${TABLE}.teams ;;
  }

  dimension_group: time__tz_offset_incl__ {
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
    sql: ${TABLE}.time__TZ_offset_incl__ ;;
  }

  dimension: to {
    type: number
    hidden: yes
    sql: ${TABLE}.`to` ;;
  }

  dimension: user {
    type: string
    sql: ${TABLE}.user ;;
  }

  dimension: via {
    type: string
    sql: ${TABLE}.via ;;
  }

  dimension: voicemail {
    type: string
    hidden: yes
    sql: ${TABLE}.voicemail ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
