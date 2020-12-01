view: aircall {
  sql_table_name: `bigquery-analytics-272822.aircall.Aircall`
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
    hidden: yes
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

  # dimension: datetime__utc_ {
  #   type: string
  #   hidden: yes
  #   sql: ${TABLE}.datetime__UTC_ ;;
  # }

  dimension_group: datetime__utc_ {
    type: time
    label: ""
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      hour_of_day
    ]
    sql: ${TABLE}.datetime__utc_ ;;
  }

  dimension_group: datetime__pst_ {
    type: time
    label: " (PST)"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      hour_of_day
    ]
    sql: CAST(datetime(CAST(${TABLE}.datetime__utc_ as TIMESTAMP),'America/Los_Angeles') as TIMESTAMP);;
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

  measure: count_all {
    view_label: "Metrics"
    description: "All Calls"
    type: count
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
    drill_fields: []
  }

  measure: count_inbound {
    view_label: "Metrics"
    description: "Inbound Calls"
    type: count
    filters: {
    field: direction
    value: "inbound"
    }
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
  }

  measure: count_outbound {
    view_label: "Metrics"
    description: "Outbound Calls"
    type: count
    filters: {
      field: direction
      value: "outbound"
    }
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
  }

  measure: num_of_missed_calls {
    view_label: "Metrics"
    description: "Number of Missed Calls (User Didn't Answer + No Avail User)"
    hidden: no
    type: count
    label: "Number of Missed Calls"
    filters: {field: answered
      value: "no"
    }
    filters: {field: missed_call_reason
      value: "agents_did_not_answer, no_available_agent"
    }
    filters: {field: direction
      value: "inbound"
    }
    filters: {
      field: duration__total_
      value: ">0"
    }
  }

  measure: num_of_accepted_calls {
    view_label: "Metrics"
    description: "Number of Accepted Calls (User Didn't Answer + No Avail User)"
    hidden: no
    type: count
    label: "Number of Accepted Calls"
    filters: {field: answered
      value: "yes"
    }
    filters: {field: direction
      value: "inbound"
    }
  }

  measure: missed_calls_percentage {
    view_label: "Metrics"
    label: "% Missed Calls"
    description: "% Missed Calls (User Didn't Answer + No Avail User)"
    type: number
    value_format: "0.0%"
    sql: ${num_of_missed_calls} / NULLIF(${count_inbound},0);;
  }


    measure: accepted_calls_percentage {
      view_label: "Metrics"
      label: "% Accepted Calls"
      description: "% Calls Accepted (not missed or declined)"
      type: number
      value_format: "0.0%"
      sql: ${num_of_accepted_calls} / ${count_inbound};;
    }

}
