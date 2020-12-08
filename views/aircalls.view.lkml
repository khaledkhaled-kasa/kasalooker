view: aircalls {
  sql_table_name: `bigquery-analytics-272822.aircall.call_hungup`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: _id {
    type: number
    hidden: yes
    sql: ${TABLE}._id ;;
  }

  dimension: answered {
    type: yesno
    sql: ${TABLE}.answered_at is not null ;;
  }

  dimension_group: answered_at_UTC {
    type: time
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
    sql: TIMESTAMP_SECONDS(${TABLE}.answered_at);;
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
      field: duration
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



  # dimension: archived {
  #   type: yesno
  #   hidden: yes
  #   sql: ${TABLE}.archived ;;
  # }

  # dimension: asset {
  #   type: string
  #   hidden: yes
  #   sql: ${TABLE}.asset ;;
  # }

  # dimension: assigned_by_availability_status {
  #   type: string
  #   sql: ${TABLE}.assigned_by_availability_status ;;
  # }

  # dimension: assigned_by_available {
  #   type: yesno
  #   sql: ${TABLE}.assigned_by_available ;;
  # }

  # dimension: assigned_by_direct_link {
  #   type: string
  #   sql: ${TABLE}.assigned_by_direct_link ;;
  # }

  # dimension: assigned_by_email {
  #   type: string
  #   sql: ${TABLE}.assigned_by_email ;;
  # }

  # dimension: assigned_by_id {
  #   type: number
  #   sql: ${TABLE}.assigned_by_id ;;
  # }

  # dimension: assigned_by_name {
  #   type: string
  #   sql: ${TABLE}.assigned_by_name ;;
  # }

  # dimension: assigned_to_availability_status {
  #   type: string
  #   sql: ${TABLE}.assigned_to_availability_status ;;
  # }

  # dimension: assigned_to_available {
  #   type: yesno
  #   sql: ${TABLE}.assigned_to_available ;;
  # }

  # dimension: assigned_to_direct_link {
  #   type: string
  #   sql: ${TABLE}.assigned_to_direct_link ;;
  # }

  # dimension: assigned_to_email {
  #   type: string
  #   sql: ${TABLE}.assigned_to_email ;;
  # }

  # dimension: assigned_to_id {
  #   type: number
  #   sql: ${TABLE}.assigned_to_id ;;
  # }

  # dimension: assigned_to_name {
  #   type: string
  #   sql: ${TABLE}.assigned_to_name ;;
  # }

  # dimension: comments {
  #   type: string
  #   sql: ${TABLE}.comments ;;
  # }

  # dimension: contact_company_name {
  #   type: string
  #   sql: ${TABLE}.contact_company_name ;;
  # }

  # dimension: contact_created_at {
  #   type: number
  #   sql: ${TABLE}.contact_created_at ;;
  # }

  # dimension: contact_direct_link {
  #   type: string
  #   sql: ${TABLE}.contact_direct_link ;;
  # }

  # dimension: contact_emails {
  #   type: string
  #   sql: ${TABLE}.contact_emails ;;
  # }

  # dimension: contact_first_name {
  #   type: string
  #   sql: ${TABLE}.contact_first_name ;;
  # }

  # dimension: contact_id {
  #   type: number
  #   sql: ${TABLE}.contact_id ;;
  # }

  # dimension: contact_information {
  #   type: string
  #   sql: ${TABLE}.contact_information ;;
  # }

  # dimension: contact_is_shared {
  #   type: yesno
  #   sql: ${TABLE}.contact_is_shared ;;
  # }

  # dimension: contact_last_name {
  #   type: string
  #   sql: ${TABLE}.contact_last_name ;;
  # }

  # dimension: contact_phone_numbers {
  #   type: string
  #   sql: ${TABLE}.contact_phone_numbers ;;
  # }

  # dimension: contact_updated_at {
  #   type: number
  #   sql: ${TABLE}.contact_updated_at ;;
  # }

  # dimension: context_library_name {
  #   type: string
  #   sql: ${TABLE}.context_library_name ;;
  # }

  # dimension: context_library_version {
  #   type: string
  #   sql: ${TABLE}.context_library_version ;;
  # }

  # dimension: direct_link {
  #   type: string
  #   sql: ${TABLE}.direct_link ;;
  # }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }


  dimension_group: ended_at_UTC {
    type: time
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
    sql: TIMESTAMP_SECONDS(${TABLE}.ended_at);;
  }


  # dimension: ended_at {
  #   type: number
  #   sql: ${TABLE}.ended_at ;;
  # }

  # dimension: event {
  #   type: string
  #   sql: ${TABLE}.event ;;
  # }

  # dimension: event_text {
  #   type: string
  #   sql: ${TABLE}.event_text ;;
  # }

  # dimension: hangup_cause {
  #   type: string
  #   sql: ${TABLE}.hangup_cause ;;
  # }

  # dimension_group: loaded {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.loaded_at ;;
  # }

  dimension: missed_call_reason {
    type: string
    sql: ${TABLE}.missed_call_reason ;;
  }

  # dimension: number_availability_status {
  #   type: string
  #   sql: ${TABLE}.number_availability_status ;;
  # }

  # dimension: number_country {
  #   type: string
  #   sql: ${TABLE}.number_country ;;
  # }

  # dimension: number_digits {
  #   type: string
  #   sql: ${TABLE}.number_digits ;;
  # }

  # dimension: number_direct_link {
  #   type: string
  #   sql: ${TABLE}.number_direct_link ;;
  # }

  # dimension: number_id {
  #   type: number
  #   sql: ${TABLE}.number_id ;;
  # }

  # dimension: number_is_ivr {
  #   type: yesno
  #   sql: ${TABLE}.number_is_ivr ;;
  # }

  # dimension: number_live_recording_activated {
  #   type: yesno
  #   sql: ${TABLE}.number_live_recording_activated ;;
  # }

  # dimension: number_messages_callback_later {
  #   type: string
  #   sql: ${TABLE}.number_messages_callback_later ;;
  # }

  # dimension: number_messages_closed {
  #   type: string
  #   sql: ${TABLE}.number_messages_closed ;;
  # }

  # dimension: number_messages_ivr {
  #   type: string
  #   sql: ${TABLE}.number_messages_ivr ;;
  # }

  # dimension: number_messages_voicemail {
  #   type: string
  #   sql: ${TABLE}.number_messages_voicemail ;;
  # }

  # dimension: number_messages_waiting {
  #   type: string
  #   sql: ${TABLE}.number_messages_waiting ;;
  # }

  # dimension: number_messages_welcome {
  #   type: string
  #   sql: ${TABLE}.number_messages_welcome ;;
  # }

  dimension: line {
    type: string
    sql: ${TABLE}.number_name ;;
  }

  # dimension: number_open {
  #   type: yesno
  #   sql: ${TABLE}.number_open ;;
  # }

  # dimension: number_time_zone {
  #   type: string
  #   sql: ${TABLE}.number_time_zone ;;
  # }

  # dimension: original_timestamp {
  #   type: string
  #   sql: ${TABLE}.original_timestamp ;;
  # }

  # dimension: raw_digits {
  #   type: string
  #   sql: ${TABLE}.raw_digits ;;
  # }

  # dimension_group: received {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.received_at ;;
  # }

  # dimension: recording {
  #   type: string
  #   sql: ${TABLE}.recording ;;
  # }

  # dimension_group: sent {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.sent_at ;;
  # }


  dimension_group: started_at_UTC {
    type: time
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
    sql: TIMESTAMP_SECONDS(${TABLE}.started_at) ;;
  }


  dimension_group: started_at_PST {
    type: time
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
    sql: CAST(datetime(TIMESTAMP_SECONDS(${TABLE}.started_at),'America/Los_Angeles') as TIMESTAMP) ;;
  }


  # dimension: status {
  #   type: string
  #   sql: ${TABLE}.status ;;
  # }

  # dimension: tags {
  #   type: string
  #   sql: ${TABLE}.tags ;;
  # }

  # dimension: teams {
  #   type: string
  #   sql: ${TABLE}.teams ;;
  # }

  # dimension_group: timestamp {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.timestamp ;;
  # }

  # dimension: transferred_to_availability_status {
  #   type: string
  #   sql: ${TABLE}.transferred_to_availability_status ;;
  # }

  dimension: transferred_to_available {
    type: yesno
    sql: ${TABLE}.transferred_to_available ;;
  }

  # dimension: transferred_to_direct_link {
  #   type: string
  #   sql: ${TABLE}.transferred_to_direct_link ;;
  # }

  # dimension: transferred_to_email {
  #   type: string
  #   sql: ${TABLE}.transferred_to_email ;;
  # }

  # dimension: transferred_to_id {
  #   type: number
  #   sql: ${TABLE}.transferred_to_id ;;
  # }

  # dimension: transferred_to_language {
  #   type: string
  #   sql: ${TABLE}.transferred_to_language ;;
  # }

  dimension: transferred_to_name {
    type: string
    sql: ${TABLE}.transferred_to_name ;;
  }

  # dimension: user_availability_status {
  #   type: string
  #   sql: ${TABLE}.user_availability_status ;;
  # }

  # dimension: user_available {
  #   type: yesno
  #   sql: ${TABLE}.user_available ;;
  # }

  # dimension: user_direct_link {
  #   type: string
  #   sql: ${TABLE}.user_direct_link ;;
  # }

  # dimension: user_email {
  #   type: string
  #   sql: ${TABLE}.user_email ;;
  # }

  # dimension: user_id {
  #   type: string
  #   sql: ${TABLE}.user_id ;;
  # }

  # dimension: user_language {
  #   type: string
  #   sql: ${TABLE}.user_language ;;
  # }

  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }

  # dimension_group: uuid_ts {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.uuid_ts ;;
  # }

  # measure: count {
  #   type: count
  #   drill_fields: [detail*]
  # }

  # # ----- Sets of fields for drilling ------
  # set: detail {
  #   fields: [
  #     id,
  #     contact_first_name,
  #     context_library_name,
  #     number_name,
  #     assigned_to_name,
  #     assigned_by_name,
  #     user_name,
  #     contact_company_name,
  #     contact_last_name,
  #     transferred_to_name
  #   ]
  # }
}
