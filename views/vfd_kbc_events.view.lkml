view: vfd_kbc_events {
  label: "KBC/VFD Events"
  derived_table: {
    sql: SELECT concat(s.session_id,confirmation_code,eventId)as pK, *
      FROM `bigquery-analytics-272822.dbt_bizops.vfd_kbc_sessions` s
      left join
      `bigquery-analytics-272822.dbt_bizops.vfd_kbc_all_events`a
      on
      s.session_id= a.session_id
       ;;
  }



  dimension: p_k {
    type: string
    sql: ${TABLE}.pK ;;
    primary_key: yes
    hidden: yes
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: confirmation_code {
    type: string
    sql: ${TABLE}.confirmation_code ;;
  }

  dimension_group: session_timestamp {
    type: time
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.session_timestamp ;;
    convert_tz: no
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension_group:bookingcheckinDate{
    type: time
    label: "Checkin Date"
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.bookingcheckinDate ;;
    convert_tz: no
  }

  dimension: earlycheckinStatus {
    type: string
    sql: ${TABLE}.earlycheckinStatus ;;
    hidden: yes
  }
  dimension: latecheckoutStatus {
    type: string
    sql: ${TABLE}.latecheckoutStatus ;;
    hidden: yes
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.eventName ;;
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.eventId ;;
    hidden: yes
  }

  dimension: check_in_rating {
    type: number
    sql: ${TABLE}.check_in_rating ;;
    hidden: yes
  }

  dimension: cleaning_rating {
    type: number
    sql: ${TABLE}.cleaning_rating ;;
    hidden: yes
  }

  dimension: login_status {
    type: string
    sql: ${TABLE}.login_status ;;
  }

  dimension_group: login_date {
    label: "Check in Date(VFD)"
    type: time
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.checkinDate ;;
    convert_tz: no
    hidden: yes
  }

  dimension_group: auth_checkedin_date {
    type: time
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.AuthCheckedinDate ;;
    hidden: yes
  }

  dimension: identity_verification_result {
    type: string
    sql: ${TABLE}.identity_verification_result ;;
  }

  dimension_group: login_time {
    type: time
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.loginTime ;;
    convert_tz: no
  }

  dimension_group: time_entred_kbc_flow {
    label: "Time Entred KBC Flow"
    type: time
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.timeEntredKbcFlow ;;
    hidden: yes
  }

  dimension_group: timeauthorization_success {
    type: time
    label: "Time Complete KBC Flow"
    timeframes: [date,month,week,year,day_of_week,time]
    sql: ${TABLE}.timeauthorizationSuccess ;;
    hidden: yes
  }

  dimension_group: time_cii_viewd {
    type: time
    hidden: yes
    sql: ${TABLE}.timeCiiViewd ;;
  }

  dimension_group: time_coi_viewd {
    type: time
    hidden: yes
    sql: ${TABLE}.timeCoiViewd ;;
  }

  dimension: kbccomplete_in_advance_of_checkin {
    type: string
    label: "KBC Complete in Advance of Checkin"
    sql: ${TABLE}.KBCCompleteInAdvanceOfCheckin;;
    hidden: yes
  }

  dimension: kbc_flow_completion_in_sec {
    type: number
    sql: ${TABLE}.kbcFlowCompletionInSec ;;
    hidden: yes
  }
  dimension: checkVFDinadvanceCII {
    type: string
    sql: ${TABLE}.checkVFDinadvanceCII ;;
    hidden: yes
  }
  dimension: checkVFDinadvancCOI {
    type: string
    sql: ${TABLE}.checkVFDinadvancCOI ;;
    hidden: yes
  }
  dimension:idenCheckCompletionInSec {
    type: number
    sql: ${TABLE}.idenCheckCompletionInSec ;;
    hidden: yes
  }
  dimension:kbcCompletedinOneSeesion {
    type: string
    sql: ${TABLE}.kbcCompletedinOneSeesion ;;
    hidden: yes
  }

  measure: num_cii_viwes {
    label: "Num CII Views"
    group_label: "VFD Metrics"
    description: "Total number of Views on Check-in instructions page"
    type: count_distinct
    sql: ${p_k} ;;
    filters: [event_name: "check_in_step_viewed"]
    drill_fields: [detail*]
  }
  measure: num_coi_viwes {
    label: "Num COI Views"
    group_label: "VFD Metrics"
    description: "Total number of Views on Check-out instructions page"
    type: count_distinct
    sql: ${p_k} ;;
    filters: [event_name: "check_out_instructions_viewed"]
    drill_fields: [detail*]
  }
  measure: num_amenity_viwes {
    label: "Num COI Views"
    group_label: "VFD Metrics"
    description: "Total number of Views on amenity page"
    type: count_distinct
    sql: ${p_k} ;;
    filters: [event_name: "amenity_guide_viewed"]
    drill_fields: [detail*]
  }
  measure: lco_requested {
    label: "LCO Requested "
    group_label: "KBC Metrics"
    description: "Total reservations requested LCO"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "lco_requested"]
    drill_fields: [detail*]
  }
  measure: lcoConfirmed{
    label: "LCO Confirmed"
    type: count_distinct
    group_label: "KBC Metrics"
    sql: ${confirmation_code} ;;
    filters: [latecheckoutStatus: "approved"]
    drill_fields: [detail*]
  }
  measure: lco_completion_rate{
    label: "LCO Completion Rate"
    group_label: "KBC Metrics"
    value_format_name: percent_1
    type: number
    sql: ${lcoConfirmed}/${lco_requested}  ;;
    drill_fields: [detail*]
  }
  measure: early_check_in_requested {
    label: "Early Checkin Requested "
    group_label: "KBC Metrics"
    description: "Total reservations requested early checkin"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "early_check_in_requested"]
    drill_fields: [detail*]
  }
  measure:early_check_in_requestedApproved{
    label: "Early Checkin Confirmed"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code} ;;
    filters: [earlycheckinStatus: "approved"]
    drill_fields: [detail*]
  }
  measure: early_completion_rate{
    label: "Early Completion Rate"
    group_label: "KBC Metrics"
    value_format_name: percent_1
    type: number
    sql: ${early_check_in_requestedApproved}/${early_check_in_requested}  ;;
    drill_fields: [detail*]
  }
  measure: extension_startrs {
    label: "Extension Startrs"
    description: "Total Guests who started the extension process"
    group_label: "VFD Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "extension_started"]
    drill_fields: [detail*]
  }
  measure: extension_confirmed{
    label: "Extensions Confirmed"
    description: "Total reservations confirmed for extension"
    group_label: "VFD Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "extension_confirmed"]
    drill_fields: [detail*]
  }
  measure: extension_completion_rate{
    label: "Extensions Completion Rate"
    group_label: "VFD Metrics"
    value_format_name: percent_1
    type: number
    sql: ${extension_confirmed}/${extension_startrs}  ;;
    drill_fields: [detail*]
  }
  measure: extension_payment_successed{
    type: count_distinct
    group_label: "VFD Metrics"
    sql: ${confirmation_code};;
    filters: [event_name: "extension_payment_succeeded"]
    drill_fields: [detail*]
  }
  measure: extension_payment_failed{
    type: count_distinct
    group_label: "VFD Metrics"
    sql: ${confirmation_code};;
    filters: [event_name: "extension_payment_failed"]
    drill_fields: [detail*]
  }
  measure: extension_payment_successed_rate{
    group_label: "VFD Metrics"
    value_format_name: percent_1
    type: number
    sql:${extension_payment_successed}/(${extension_payment_successed}+${extension_payment_failed})  ;;
    drill_fields: [detail*]
  }

  measure: RTF_skiped{
    type: count_distinct
    group_label: "VFD Metrics"
    sql: ${confirmation_code};;
    filters: [event_name: "check_in_feedback_skip"]
    drill_fields: [detail*]
  }
  measure: RTF_Submissions{
    description: "Real Time Feedback (RTF) Submissions"
    type: count_distinct
    group_label: "VFD Metrics"
    sql: ${confirmation_code};;
    filters: [event_name: "check_in_feedback_submitted"]
    drill_fields: [detail*]
  }
  measure: RTF_completion_rate{
    label: "RTF Completion Rate"
    group_label: "VFD Metrics"
    value_format_name: percent_1
    type: number
    sql:${RTF_Submissions}/(${RTF_Submissions}+${RTF_skiped})  ;;
    drill_fields: [detail*]
  }
  measure: kbcCompletioninAdvance{
    label: "KBC Complete in Advance of Checkin"
    description: "Num of Reservations Completed KBC 24hrs in Advance of Checkin"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code} ;;
    filters: [kbccomplete_in_advance_of_checkin: "Yes"]
    drill_fields: [detail*]
  }
  measure: kbc_CompletedinOneSeesion{
    label: "KBC Completed in One Session in One Session"
    description: "Num of Reservations Completed KBC in One Session"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code} ;;
    filters: [kbcCompletedinOneSeesion: "Yes"]
    drill_fields: [detail*]
  }
  measure: strat_Kbc{
    label: "KBC Started"
    description: "Total reservations started KBC flow"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "entered_kbc_flow"]
    drill_fields: [detail*]
  }

  measure: kbc_complete{
    label: "KBC Completed"
    description: "Total reservations completed KBC flow"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "authorization_started"]
    drill_fields: [detail*]
  }
  measure: kbc_Completions_rate{
    label: "KBC Completed"
    group_label: "KBC Metrics"
    value_format_name: percent_1
    type: number
    sql: ${kbc_complete}/${strat_Kbc} ;;
    drill_fields: [detail*]
  }
  measure: identity_check_succeeded{
    label: "Identity Check Succeeded"
    description: "Total Guests being verified successfully"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "identity_check_succeeded"]
    drill_fields: [detail*]
  }
  measure: identity_check_failed{
    label: "Identity Check Faild"
    description: "Total Guests failed to be verified"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "identity_check_failed"]
    drill_fields: [detail*]
  }
  measure:identity_check_started{
    label: "Identity Check started"
    description: "Total Guests who started verification process"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "identity_check_started"]
    drill_fields: [detail*]
  }
  measure: successfully_verification{
    label: "Successfully Verification Rate"
    group_label: "KBC Metrics"
    value_format_name: percent_1
    type: number
    sql:${identity_check_succeeded}/${identity_check_started} ;;
    drill_fields: [detail*]
  }

  measure: terms_agreed{
    label: "Terms agreed"
    description: "Total Guests agreed on House Rules"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "terms_agreed"]
    drill_fields: [detail*]
  }
  measure: optl_info{
    label: "Optional Info entered"
    description: "Total Guests who submitted additional info (reason for stay,Num of guests)"
    group_label: "KBC Metrics"
    type: count_distinct
    sql: ${confirmation_code};;
    filters: [event_name: "who_is_traveling_number_defined,reason_for_stay_submitted"]
    drill_fields: [detail*]
  }
  measure: avg_complete_kbc{
    label: "Avg Time to Complete KBC"
    description: "Avg Time to Complete KBC full funnel(Minutes)"
    type: average
    value_format: "00.00"
    group_label: "KBC Metrics"
    sql: ${kbc_flow_completion_in_sec}/60;;
    drill_fields: [detail*]
  }
  measure: avg_complete_verification{
    label: "Avg Time to Complete Identity Check"
    description: "Avg Time Guest takes to complete Verification (Minutes)"
    type: average
    value_format: "00.00"
    group_label: "KBC Metrics"
    sql: ${idenCheckCompletionInSec}/60;;
    drill_fields: [detail*]
  }
  measure: VFDCompletioninAdvance{
    label: "VFD Uused in Advance of Checkin"
    description: "Num of Guests Used VFD 24hrs in Advance of Checkin"
    group_label: "VFD Metrics"
    type: count_distinct
    sql: ${confirmation_code} ;;
    filters: [checkVFDinadvanceCII: "Yes",checkVFDinadvancCOI: "Yes"]
    drill_fields: [detail*]
  }



  set: detail {
    fields: [
      p_k,
      anonymous_id,
      session_id,
      confirmation_code,
      session_timestamp_time,
      device,
      event_name,
      event_id,
      check_in_rating,
      cleaning_rating,
      login_status,
      login_date_time,
      auth_checkedin_date_time,
      identity_verification_result,
      login_time_time,
      time_entred_kbc_flow_time,
      timeauthorization_success_time,
      time_cii_viewd_time,
      time_coi_viewd_time,
      kbccomplete_in_advance_of_checkin,
      kbc_flow_completion_in_sec
    ]
  }
}
