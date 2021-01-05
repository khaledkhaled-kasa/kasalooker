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


  dimension: duration {
    type: number
    sql: ${TABLE}.properties.duration ;;
  }

  measure: avg_duration {
    type: average
    view_label: "Metrics"
    label: "Average Call Time (minutes)"
    value_format: "0.0"
    sql: ${TABLE}.properties.duration/60;;
    filters: {
      field: duration
      value: ">0"
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
    WHEN ${user_name} = "Angela Gazdziak" THEN "Angie Gazdziak"
    WHEN ${user_name} = "Infiniti " THEN "Infiniti"
    WHEN ${user_name} = 'Katherine Chappell' THEN "Kate Chappell"
    WHEN ${user_name} = "Charmagne " THEN "Charmagne Coston"
    WHEN ${user_name} = "Jeffrey Haas" THEN "Jeff Haas"
    WHEN ${user_name} = "Jennifer Knight" THEN "Jen Knight"
    WHEN ${user_name} = "Sheila Marie Cruz" THEN "Sheila Cruz"
    WHEN ${user_name} = "Mel  Doroteo" THEN "Mel Doroteo"
    WHEN ${user_name} = 'Nikki Cardno' THEN 'Nicole Cardno'
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

  dimension_group: started_at_UTC {
    type: time
    view_label: "Date Dimensions"
    group_label: "Started Date (UTC)"
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: TIMESTAMP_SECONDS(${TABLE}.properties.started_at) ;;
  }


  dimension_group: started_at_PST {
    type: time
    view_label: "Date Dimensions"
    group_label: "Started Date (PST)"
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      day_of_week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: CAST(datetime(TIMESTAMP_SECONDS(${TABLE}.properties.started_at),'America/Los_Angeles') as TIMESTAMP) ;;
  }


  # dimension_group: answered_at_UTC {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     week_of_year,
  #     month,
  #     month_name,
  #     quarter,
  #     year
  #   ]
  #   sql: TIMESTAMP_SECONDS(${TABLE}.properties.answered_at);;
  # }


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
      value: "call_hungup"
    }
    drill_fields: []
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
      value: "call_hungup"
    }
    # filters: {
    #   field: duration__total_
    #   value: ">0"
    # }
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
      value: "call_hungup"
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
      field: duration
      value: ">0"
    }
    filters: {
      field: event
      value: "call_hungup"
    }
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
      value: "call_hungup"
    }
  }

  measure: missed_calls_percentage {
    view_label: "Metrics"
    label: "% Missed Calls"
    description: "% Missed Calls (User Didn't Answer + No Avail User)"
    type: number
    value_format: "0.0%"
    sql: ${num_of_missed_calls} / ${count_inbound};;
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
