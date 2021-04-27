view: aircall_segment {
  sql_table_name: `bigquery-analytics-272822.aircallsegment.track`
    ;;


  dimension: answered {
    type: yesno
    sql: ${TABLE}.properties.answered_at is not null ;;
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.properties.direction ;;
  }

  dimension: missed_call_reason {
    type: string
    sql: ${TABLE}.properties.missed_call_reason ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.properties.id ;;
  }

  dimension: composite_primary_key {
    primary_key: yes
    sql: concat(${TABLE}.properties.id,${TABLE}.event) ;;
  }


  dimension: total_duration {
    type: number
    sql: ${TABLE}.properties.duration ;;
  }

  dimension: incall_duration {
    type: duration_second
    datatype: epoch
    hidden: yes
    sql_start: ${TABLE}.properties.answered_at;;
    sql_end: ${TABLE}.properties.ended_at;;
  }

  dimension: hold_duration {
    type: duration_second
    datatype: epoch
    hidden: yes
    sql_start: ${TABLE}.properties.started_at;;
    sql_end: CASE WHEN ${TABLE}.properties.answered_at is NULL THEN ${TABLE}.properties.ended_at
    ELSE ${TABLE}.properties.answered_at
    END;;
  }

  measure: incall_duration_total {
    type: sum_distinct
    view_label: "Metrics"
    label: "In Call Duration (Seconds)"
    sql: ${incall_duration} ;;
    sql_distinct_key: concat(${id},${event}) ;;
    filters: {
      field: event
      value: "call.hungup"
    }
  }

  measure: hold_duration_total {
    type: sum_distinct
    view_label: "Metrics"
    label: "Hold Duration (Seconds)"
    sql: ${hold_duration} ;;
    sql_distinct_key: concat(${id},${event}) ;;
    filters: {
      field: event
      value: "call.hungup"
    }
  }

  measure: avg_incall_duration {
    type: average_distinct
    view_label: "Metrics"
    label: "Average Call Time (minutes)"
    value_format: "0.0"
    sql: ${incall_duration}/60;;
    sql_distinct_key: concat(${id},${event}) ;;
    filters: {
      field: event
      value: "call.hungup"
    }
  }

  measure: avg_hold_duration {
    type: average_distinct
    view_label: "Metrics"
    label: "Average Hold Time (minutes)"
    value_format: "0.0"
    sql: ${hold_duration}/60;;
    sql_distinct_key: concat(${id},${event}) ;;
    filters: {
      field: event
      value: "call.hungup"
    }
  }

  dimension: user_name {
    type: string
    hidden: yes
    sql: ${TABLE}.properties.user.name ;;
  }

  dimension: user_name_adjusted {
    type: string
    label: "Username"
    description: "These names have been adjusted to match what's shown on Kustomer"
    sql:
    CASE
    WHEN ${user_name} = 'Vida Charra Relato' THEN 'Vida Relato'
    WHEN ${user_name} = 'Alfred James' THEN 'Alfred Sadueste'
    WHEN ${user_name} = 'Roan ' THEN 'Roan Litz'
    WHEN ${user_name} = "Sofie " THEN "Sofia Cruz"
    WHEN ${user_name} = "Charmagne " THEN "Charmagne Coston"
    WHEN ${user_name} = "Veronica " THEN "Veronica Hawkins"
    WHEN ${user_name} = 'Hallie Muscente' THEN "Hallie Knudsen"
    WHEN ${user_name} = "Mel  Doroteo" THEN "Mel Doroteo"
    WHEN ${user_name} = "Mel Baker" THEN "Melissa Baker"
    WHEN ${user_name} = 'Nikki Cardno' THEN 'Nicole Cardno'
    WHEN ${user_name} = 'Suzanne Hill' THEN 'Suzie Hill'
    WHEN ${user_name} = "Infiniti " THEN "Infiniti"
    WHEN ${user_name} = 'Katherine Chappell' THEN "Kate Chappell"
    ELSE ${user_name}
    END
    ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: line {
    type: string
    sql: ${TABLE}.properties.number.name ;;
  }

  dimension_group: started_at {
    type: time
    label: ""
    view_label: "Date Dimensions"
    group_label: "Aircall Started Date"
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      week_of_year,
      day_of_week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: TIMESTAMP_SECONDS(${TABLE}.properties.started_at) ;;
  }



  measure: count_all {
    view_label: "Metrics"
    description: "All Calls"
    type: count_distinct
    sql: concat(${id},${event}) ;;
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
    filters: {
      field: event
      value: "call.hungup"
    }
    drill_fields: [aircall_details*]

  }

  measure: count_inbound {
    view_label: "Metrics"
    description: "Inbound Calls"
    type: count_distinct
    sql: concat(${id},${event}) ;;
    filters: {
      field: direction
      value: "inbound"
    }
    filters: {
      field: event
      value: "call.hungup"
    }
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
    drill_fields: [aircall_details*]

  }

  measure: count_outbound {
    view_label: "Metrics"
    description: "Outbound Calls"
    type: count_distinct
    sql: concat(${id},${event}) ;;
    filters: {
      field: direction
      value: "outbound"
    }
    filters: {
      field: event
      value: "call.hungup"
    }
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
    drill_fields: [aircall_details*]

  }


  measure: num_of_missed_calls {
    view_label: "Metrics"
    description: "Number of Missed Calls (User Didn't Answer + No Avail User)"
    hidden: no
    type: count_distinct
    sql: concat(${id},${event}) ;;
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
      field: total_duration
      value: ">0"
    }
    filters: {
      field: event
      value: "call.hungup"
    }
    drill_fields: [aircall_details*]

  }

  measure: num_of_accepted_calls {
    view_label: "Metrics"
    description: "Number of Accepted Calls"
    hidden: no
    type: count_distinct
    sql: concat(${id},${event}) ;;
    label: "Number of Accepted Calls"
    filters: {field: answered
      value: "yes"
    }
    filters: {field: direction
      value: "inbound"
    }
    filters: {
      field: event
      value: "call.hungup"
    }
    drill_fields: [aircall_details*]

  }

  measure: missed_calls_percentage {
    view_label: "Metrics"
    label: "% Missed Calls"
    description: "% Missed Calls (User Didn't Answer + No Avail User)"
    type: number
    value_format: "0.0%"
    sql: ${num_of_missed_calls} / nullif(${count_inbound},0);;
    drill_fields: [aircall_details*]
  }


  measure: accepted_calls_percentage {
    view_label: "Metrics"
    label: "% Accepted Calls"
    description: "% Calls Accepted (not missed or declined)"
    type: number
    value_format: "0.0%"
    sql: ${num_of_accepted_calls} / nullif(${count_inbound},0);;
    drill_fields: [aircall_details*]

  }

  set: aircall_details {
    fields: [id, total_duration, user_name, missed_call_reason, event, direction, answered, started_at_time, hold_duration, incall_duration]
    }

}
