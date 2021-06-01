view: conversation_ps {
  view_label: "Conversation"
  sql_table_name: `kustomer.conversation`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: no
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension_group: created {
    type: time
    view_label: "Date Dimensions"
    group_label: "Conversation Created Date"
    label: ""
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: custom_air_bnb_thread_id_num {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.custom_air_bnb_thread_id_num ;;
  }

  dimension: custom_airbnb_link_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_airbnb_link_str ;;
  }

  dimension: custom_airbnb_thread_id_str {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.custom_airbnb_thread_id_str ;;
  }

  dimension: custom_airbnb_user_id_str {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.custom_airbnb_user_id_str ;;
  }

  dimension: custom_background_check_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_background_check_str ;;
  }

  dimension: custom_background_check_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_background_check_tree ;;
  }

  dimension: custom_billing_new_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_billing_new_str ;;
  }

  dimension: custom_billing_new_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_billing_new_tree ;;
  }

  dimension: custom_billing_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_billing_tree ;;
  }

  dimension: custom_booking_channel_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_booking_channel_str ;;
  }

  dimension: custom_booking_date_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_booking_date_str ;;
  }

  dimension: custom_ci_review_rating_num {
    type: number
    hidden: yes
    sql: ${TABLE}.custom_ci_review_rating_num ;;
  }

  dimension: custom_dates_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_dates_str ;;
  }

  dimension: custom_escalate_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_escalate_bool ;;
  }

  dimension: custom_escalation_tree {
    type: string
    sql: ${TABLE}.custom_escalation_tree ;;
  }

  dimension: custom_finance_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_finance_tree ;;
  }

  dimension: custom_guesty_link_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_guesty_link_str ;;
  }

  dimension: custom_handover_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_handover_bool ;;
  }

  dimension: custom_hk_operations_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_hk_operations_bool ;;
  }

  dimension: custom_housekeeping_new_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_housekeeping_new_tree ;;
  }

  dimension: custom_is_verified_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_is_verified_bool ;;
  }

  dimension: custom_issue_category_tree {
    type: string
    sql: custom_issue_category_tree ;;
  }

# To be fixed
  dimension: issue_category_revised {
    type: string
    label: "Issue Category"
    sql:
    CASE
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.amenity_misuse_ls" THEN "PS Guest Issues > Amenity misuse (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.check_in_issues_ls" THEN "PS Guest Issues > Check-in issues (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.conflict_altercation_ls" THEN "PS Guest Issues > Conflict/altercation (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.covid_related" THEN "PS Guest Issues > COVID-related (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.crime_ls" THEN "PS Guest Issues > Crime (LS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.crime_serious_disturbance" THEN "PS Guest Issues > Crime/Serious disturbance (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.noise_complaint_ps" THEN "PS Guest Issues > Noise Complaint about Neighbor (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.noise_non_party_ls" THEN "PS Guest Issues > Noise-non-party (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.other_ls" THEN "PS Guest Issues > Other - Guest (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.parking_ls" THEN "PS Guest Issues > Parking issues (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.party_ls" THEN "PS Guest Issues > Party (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.pets_ls" THEN "PS Guest Issues > Pets (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.smoking_ls" THEN "PS Guest Issues > Smoking Complaint about Neighbor (PS)"
    WHEN ${custom_issue_category_tree} =  "ls_guest_issues.trash_issue_ls" THEN "PS Guest Issues > Trash issue (PS)"
    -- WHEN ${custom_issue_category_tree} LIKE "ls_guest_issues%" THEN "PS Guest Issues > Unknown (PS)"

    WHEN ${custom_issue_category_tree} = "ls_operations.access_items_ls" THEN "PS Operations > Access (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.call_request_ls" THEN "PS Operations > Call request (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.billing_finance_qs" THEN "PS Operations > Billing/Finance Q's (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.covid_related1" THEN "PS Operations > COVID-related (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.expansion_ls" THEN "PS Operations > Expansions (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.hk_issues_ls" THEN "PS Operations > HK issues (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.information_request_ls" THEN "PS Operations > Information/call request (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.introductions_onboarding_ls" THEN "PS Operations > Introductions/Onboarding (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.landlord_booking_ls" THEN "PS Operations > Property partner booking (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.maintenance_repairs_ls" THEN "PS Operations > Maintenance/repairs (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.neighbor_love_ls" THEN "PS Operations > Neighbor Love (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.other_ls1" THEN "PS Operations > Other - Ops (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.packages_mail_ls" THEN "PS Operations > Packages/Mail (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.pom_ls" THEN "PS Operations > POM/HK/OSR (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.renewals_ls" THEN "PS Operations > Administrative (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.sharing_performance_data_ps" THEN "PS Operations > Sharing performance data (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.vendors_ps" THEN "PS Operations > Vendors (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.repairs_service_requests" THEN "PS Operations > Repairs/Service requests (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.preventative_maintenance" THEN "PS Operations > Preventative maintenance (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.pest_control" THEN "PS Operations > Pest Control (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.building_access" THEN "PS Operations > Building Access (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.property_partner_vip_booking" THEN "PS Operations > Property partner/VIP booking (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.administrative" THEN "PS Operations > Administrative (PS)"
    WHEN ${custom_issue_category_tree} = "ls_operations.billing_payment_qs" THEN "PS Operations > Billing/Payment Q's (PS)"
    -- WHEN ${custom_issue_category_tree} LIKE "ls_operations%" THEN "PS Operations > Unknown (PS)"

    WHEN ${custom_issue_category_tree} = "ps_t_s.crime_grave_incident_ps" THEN "PS Trust & Safety > Crime/Grave incident (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.party_community_disturbance_ps" THEN "PS Trust & Safety > Party/Community disturbance (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.conflict_alteration_ps" THEN "PS Trust & Safety > Conflict/altercation (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.noise_complaint_about_kasa_ps" THEN "PS Trust & Safety > Noise complaint about Kasa (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.smoking_complaint_about_kasa_ps" THEN "PS Trust & Safety > Smoking complaint about Kasa (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.covid_related_ps" THEN "PS Trust & Safety > COVID-related (PS)"
    WHEN ${custom_issue_category_tree} = "ps_t_s.other_t_s_ps" THEN "PS Trust & Safety > Other-T&S (PS)"
    ELSE
    ${custom_issue_category_tree}
    END
    ;;
  }

  dimension: custom_kasa_kandidate_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_kasa_kandidate_bool ;;
  }

  dimension: custom_landlord_success_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_landlord_success_bool ;;
  }

  dimension: custom_last_call_recovery_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_last_call_recovery_bool ;;
  }

  dimension: custom_long_term_stay_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_long_term_stay_bool ;;
  }

  dimension: custom_manager_follow_up_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_manager_follow_up_bool ;;
  }

  dimension: custom_missing_access_item_tree {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_missing_access_item_tree ;;
  }

  dimension: custom_my_custom_rating_thing_num {
    type: number
    hidden: yes
    sql: ${TABLE}.custom_my_custom_rating_thing_num ;;
  }

  dimension: custom_my_custom_str {
    type: number
    hidden: yes
    sql: ${TABLE}.custom_my_custom_str ;;
  }

  dimension: custom_origin_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_origin_tree ;;
  }

  dimension: custom_prop_unit_str {
    type: string
    sql: ${TABLE}.custom_prop_unit_str ;;
  }

  dimension: custom_property_issue_old_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_property_issue_old_bool ;;
  }


  dimension: custom_property_issue_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_property_issue_str ;;
  }

  dimension: custom_property_issue_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_property_issue_tree ;;
  }

  dimension: custom_reservations_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_reservations_tree ;;
  }

  dimension: custom_return_to_inbox_in_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_return_to_inbox_in_str ;;
  }

  dimension: custom_rules_ran_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_rules_ran_bool ;;
  }

  dimension: custom_send_as_text_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_send_as_text_bool ;;
  }

  dimension_group: custom_set_reminder {
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
    sql: ${TABLE}.custom_set_reminder_at ;;
  }

  dimension: custom_ticket_category_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_ticket_category_str ;;
  }

  dimension: custom_urgent_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_urgent_bool ;;
  }

  dimension: custom_zendesk_ticket_url {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_zendesk_ticket_url ;;
  }

  dimension_group: custom_zendesk_updated {
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
    sql: ${TABLE}.custom_zendesk_updated_at ;;
  }

  dimension: customer_id {
    type: string
    hidden: no
    sql: ${TABLE}.customer_id ;;
  }

  dimension: default_lang {
    type: string
    hidden: yes
    sql: ${TABLE}.default_lang ;;
  }

  dimension: deleted {
    type: yesno
    hidden: yes
    sql: ${TABLE}.deleted ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: deleted_by {
    type: string
    hidden: yes
    sql: ${TABLE}.deleted_by ;;
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
  }

  dimension: ended {
    type: yesno
    hidden: yes
    sql: ${TABLE}.ended ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension: first_company_id {
    type: string
    hidden: yes
    sql: ${TABLE}.first_company_id ;;
  }

  dimension: first_company_name {
    type: string
    hidden: yes
    sql: ${TABLE}.first_company_name ;;
  }

  dimension_group: first_message_in_created {
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
    sql: ${TABLE}.first_message_in_created_at ;;
  }

  dimension: first_message_in_id {
    type: string
    hidden: yes
    sql: ${TABLE}.first_message_in_id ;;
  }

  dimension_group: first_message_in_sent {
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
    sql: ${TABLE}.first_message_in_sent_at ;;
  }

  dimension_group: first_response_created {
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
    sql: ${TABLE}.first_response_created_at ;;
  }

  dimension: first_response_id {
    type: string
    hidden: yes
    sql: ${TABLE}.first_response_id ;;
  }

  dimension: first_response_response_time {
    type: number
    hidden: yes
    sql: ${TABLE}.first_response_response_time ;;
  }

  dimension_group: first_response_sent {
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
    sql: ${TABLE}.first_response_sent_at ;;
  }

  dimension: first_response_time {
    type: number
    hidden: yes
    sql: ${TABLE}.first_response_time ;;
  }

  dimension_group: last_activity {
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
    sql: ${TABLE}.last_activity_at ;;
  }

  dimension_group: last_message {
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
    sql: ${TABLE}.last_message_at ;;
  }

  dimension: last_message_direction {
    type: string
    hidden: yes
    sql: ${TABLE}.last_message_direction ;;
  }

  dimension_group: last_message_out_created {
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
    sql: ${TABLE}.last_message_out_created_at ;;
  }

  dimension: last_message_out_message_id {
    type: string
    hidden: yes
    sql: ${TABLE}.last_message_out_message_id ;;
  }

  dimension_group: last_message_out_sent {
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
    sql: ${TABLE}.last_message_out_sent_at ;;
  }

  dimension: message_count {
    type: number
    hidden: yes
    sql: ${TABLE}.message_count ;;
  }

  dimension_group: modified {
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
    sql: ${TABLE}.modified_at ;;
  }

  dimension: modified_by {
    type: string
    hidden: yes
    sql: ${TABLE}.modified_by ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: note_count {
    type: number
    hidden: yes
    sql: ${TABLE}.note_count ;;
  }

  dimension: org_id {
    type: string
    hidden: yes
    sql: ${TABLE}.org_id ;;
  }

  dimension: outbound_message_count {
    type: number
    hidden: yes
    sql: ${TABLE}.outbound_message_count ;;
  }

  dimension: priority {
    type: number
    hidden: yes
    sql: ${TABLE}.priority ;;
  }

  dimension: reopen_count {
    type: number
    hidden: yes
    sql: ${TABLE}.reopen_count ;;
  }

  dimension: satisfaction {
    type: number
    hidden: yes
    sql: ${TABLE}.satisfaction ;;
  }

  dimension: satisfaction_level_channel {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_channel ;;
  }

  dimension_group: satisfaction_level_created {
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
    sql: ${TABLE}.satisfaction_level_created_at ;;
  }

  dimension: satisfaction_level_form {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_form ;;
  }

  dimension: satisfaction_level_form_response {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_form_response ;;
  }

  dimension: satisfaction_level_rating {
    type: number
    hidden: yes
    sql: ${TABLE}.satisfaction_level_rating ;;
  }

  dimension_group: satisfaction_level_scheduled_for {
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
    sql: ${TABLE}.satisfaction_level_scheduled_for ;;
  }

  dimension: satisfaction_level_score {
    type: number
    hidden: yes
    sql: ${TABLE}.satisfaction_level_score ;;
  }

  dimension_group: satisfaction_level_sent {
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
    sql: ${TABLE}.satisfaction_level_sent_at ;;
  }

  dimension: satisfaction_level_sent_by {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_sent_by ;;
  }

  dimension: satisfaction_level_sent_by_teams {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_sent_by_teams ;;
  }

  dimension: satisfaction_level_status {
    type: string
    hidden: yes
    sql: ${TABLE}.satisfaction_level_status ;;
  }

  dimension_group: satisfaction_level_updated {
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
    sql: ${TABLE}.satisfaction_level_updated_at ;;
  }

  dimension: sentiment_confidence {
    type: number
    hidden: yes
    sql: ${TABLE}.sentiment_confidence ;;
  }

  dimension: sentiment_polarity {
    type: number
    hidden: yes
    sql: ${TABLE}.sentiment_polarity ;;
  }

  dimension: snooze_count {
    type: number
    hidden: yes
    sql: ${TABLE}.snooze_count ;;
  }

  dimension: snooze_status {
    type: string
    hidden: yes
    sql: ${TABLE}.snooze_status ;;
  }

  dimension_group: snooze_status {
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
    sql: ${TABLE}.snooze_status_at ;;
  }

  dimension_group: snooze {
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
    sql: ${TABLE}.snooze_time ;;
  }

  dimension: status {
    type: string
    hidden: yes
    sql: ${TABLE}.status ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_company_name,
      name,
      customer.id,
      customer.first_name,
      customer.last_name,
      customer.display_name,
      customer.name,
      conversation_assigned_team.count,
      conversation_tag.count,
      conversation_assigned_user.count,
      conversation_channel.count,
      message.count
    ]
  }


}
