connection: "bigquery"

# include all the views
include: "/views/**/*.view"
#include: "//kasametrics/views/**/*.view"

datagroup: kustomer_default_datagroup {
  sql_trigger: SELECT MAX(_fivetran_synced) FROM kustomer.conversation;;
  max_cache_age: "1 hours"
}

datagroup: kasametrics_reservations_datagroup {
  sql_trigger: SELECT MAX(createdat) from `bigquery-analytics-272822.dbt.reservations_v3` ;;
  max_cache_age: "1 hours"
}


persist_with: kustomer_default_datagroup
label: "Software"


# This excludes Voice Calls (message channels = 'voice')
explore: customer {
  description: "This explore houses the majority of our Kustomer metrics such as messages sent, unique customers messages, etc."
  label: "Kustomer Metrics"
  fields: [ALL_FIELDS*, -units.unit_count, -units.property_count,
    -airbnb_reviews.reservation_checkin_raw, -airbnb_reviews.reservation_checkin_time, -airbnb_reviews.reservation_checkin_date, -airbnb_reviews.reservation_checkin_week,
    -airbnb_reviews.reservation_checkin_month, -airbnb_reviews.reservation_checkin_year, -airbnb_reviews.reservation_checkin_quarter,
    -airbnb_reviews.reservation_checkout_raw, -airbnb_reviews.reservation_checkout_time, -airbnb_reviews.reservation_checkout_date, -airbnb_reviews.reservation_checkout_week,
    -airbnb_reviews.reservation_checkout_month, -airbnb_reviews.reservation_checkout_year, -airbnb_reviews.reservation_checkout_quarter,
    -airbnb_reviews.cleaning_rating_score, -airbnb_reviews.cleaning_rating_score_weighted, -airbnb_reviews.clean_count_5_star_first90, -airbnb_reviews.clean_count_less_than_4_star_first90,
    -airbnb_reviews.count_clean_first90, -airbnb_reviews.net_quality_score_clean_first90, -airbnb_reviews.percent_5_star_clean_first90, -airbnb_reviews.percent_less_than_4_star_clean_first90,
    -post_checkout_v2.aggregated_comments_all_unclean, -airbnb_reviews.number_of_days, -post_checkout_v2.number_of_days]
  join: conversation {
    type: inner
    sql_on: ${customer.id} = ${conversation.customer_id};;
    relationship: one_to_many
  }
  join: kustomer_notes {
    type: left_outer
    sql_on: ${conversation.id}=${kustomer_notes.conversation_id};;
    relationship: one_to_many
  }


  join: conversation_channel {
    type: left_outer
    sql_on: (${conversation.id} = ${conversation_channel.conversation_id}) AND ${conversation_channel.index} = 1;;
    relationship: one_to_one
  }

  join: kobject_reservation {
    type: left_outer
    sql_on: ${conversation.kobject_id_mapped} = ${kobject_reservation.id} ;;
    relationship: one_to_one
  }

  join: reservations_kustomer {
    view_label: "Reservations"
    type: left_outer
    sql_on: ${reservations_kustomer.confirmationcode} = ${kobject_reservation.custom_confirmation_code_str} ;;
    relationship: one_to_one
  }

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${reservations_kustomer.unit} = ${units._id};;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
    sql_on: ${units.propcode} = ${pom_information.Prop_Code} ;;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units.complex} = ${complexes._id};;
  }

  join: message {
    type: left_outer
    sql_on: ${conversation.id} = ${message.conversation_id};;
    relationship: one_to_many
  }

  join: user {
    type: left_outer
    sql_on: ${user.id} = ${message.created_by};;
    relationship: one_to_one
  }

  join: message_created_by_team {
    type: left_outer
    sql_on: ${message_created_by_team.message_id} = ${message.id};;
    relationship: one_to_one
  }

  join: team {
    type: left_outer
    sql_on: ${team.id} =${message_created_by_team.team_id} ;;
    relationship: one_to_one
  }

  join: message_shortcut {
    type: left_outer
    sql_on: ${message.id} = ${message_shortcut.message_id};;
    relationship: one_to_one
  }

  join: company {
    type: left_outer
    sql_on: ${customer.company_id} = ${company.id};;
    relationship: one_to_one
  }

  join: issue_categories_1 {
    view_label: "Issue Category 1 (Mapped)"
    from: issue_categories
    type: left_outer
    sql_on: ${conversation.custom_issue_category_1_tree} = ${issue_categories_1.kustomer_issue_label} ;;
    relationship: one_to_one
  }

  join: issue_categories_2 {
    view_label: "Issue Category 2 (Mapped)"
    from: issue_categories
    type: left_outer
    sql_on: ${conversation.custom_issue_category_2_tree} = ${issue_categories_2.kustomer_issue_label} ;;
    relationship: one_to_one
  }

  join: issue_categories_3 {
    view_label: "Issue Category 3 (Mapped)"
    from: issue_categories
    type: left_outer
    sql_on: ${conversation.custom_issue_category_3_tree} = ${issue_categories_3.kustomer_issue_label} ;;
    relationship: one_to_one
  }

  join: airbnb_reviews {
    type: left_outer
    relationship:  one_to_one
    sql_on: ${reservations_kustomer.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }

  join: post_checkout_data {
    view_label: "Post Checkout Surveys"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_kustomer.confirmationcode} ;;
  }

  join: post_checkout_v2 {
    view_label: "Post Checkout Surveys V2"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_v2.confirmationcode} = ${reservations_kustomer.confirmationcode} ;;
  }


}


# This is the same as Kustomer Metrics; however, including Voice Calls (message channels = 'voice')
explore: gx_cost_allocation {
  from: customer
  label: "GX Cost Allocation"
  hidden: yes
  fields: [ALL_FIELDS*,-conversation.total_tech_related_issues, -conversation.total_kfc_related_issues,-conversation.total_kontrol_related_issues,-conversation.total_iot_related_issues,-conversation.total_affected_reservation_kontrol,-conversation.total_affected_reservation_tech,-conversation.total_affected_reservation_kfc,-conversation.total_affected_reservation_iot]
  join: conversation {

    type: inner
    sql_on: ${gx_cost_allocation.id} = ${conversation.customer_id};;
    relationship: one_to_many
  }

  join: conversation_channel {
    type: left_outer
    sql_on: (${conversation.id} = ${conversation_channel.conversation_id}) AND ${conversation_channel.index} = 1;;
    relationship: one_to_one
  }

  join: kobject_reservation {
    type: left_outer ## Check this type
    sql_on: ${conversation.kobject_id_mapped} = ${kobject_reservation.id} ;;
    relationship: one_to_one
  }

  join: reservations_kustomer {
    view_label: "Reservations"
    type: left_outer ## Check this type
    sql_on: ${reservations_kustomer.confirmationcode} = ${kobject_reservation.custom_confirmation_code_str} ;;
    relationship: one_to_one
  }

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${reservations_kustomer.unit} = ${units._id};;
  }


  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units.complex} = ${complexes._id};;
  }

  join: message {
    type: left_outer
    sql_on: ${conversation.id} = ${message.conversation_id};;
    relationship: one_to_many
  }

  join: user {
    type: left_outer
    sql_on: ${user.id} = ${message.created_by};;
    relationship: one_to_one
  }

  join: message_created_by_team {
    type: left_outer
    sql_on: ${message_created_by_team.message_id} = ${message.id};;
    relationship: one_to_one
  }

  join: conversation_assigned_team {
    type: left_outer
    sql_on: ${conversation_assigned_team.conversation_id} = ${conversation.id};;
    relationship: one_to_one
  }

  join: team {
    type: left_outer
    sql_on:
    ${team.id} =
    (CASE WHEN ${message.channel} = 'voice' THEN ${conversation_assigned_team.team_id}
    ELSE ${message_created_by_team.team_id}
    END);;
    relationship: one_to_one
  }

  join: message_shortcut {
    type: left_outer
    sql_on: ${message.id} = ${message_shortcut.message_id};;
    relationship: one_to_one
  }

  join: company {
    type: left_outer
    sql_on: ${gx_cost_allocation.company_id} = ${company.id};;
    relationship: one_to_one
  }

}

explore: customer_csat {
  description: "This explore pulls Kustomer data and is designed specifically to pull CSAT metrics."
  from: customer
  always_join: [team_member,conversation_assigned_user, user]
  label: "Kustomer CSAT"

  join: conversation_csat {
    type: inner
    sql_on: ${customer_csat.id} = ${conversation_csat.customer_id};;
    relationship: one_to_many
  }

  join: conversation_assigned_team {
    type: left_outer
    sql_on: ${conversation_assigned_team.conversation_id} = ${conversation_csat.id};;
    relationship: one_to_one
  }

  join: team {
    type: left_outer
    sql_on: ${team.id} = ${conversation_assigned_team.team_id};;
    relationship: one_to_one
  }

  join: team_member {
    type: left_outer
    sql_on: ${team.id} = ${team_member.team_id};;
    relationship: one_to_one
  }

  join: conversation_assigned_user {
    type: left_outer
    sql_on: ${conversation_assigned_user.conversation_id} = ${conversation_csat.id};;
    relationship: one_to_one
  }

  join: user {
    type: left_outer
    sql_on: (${user.id} = ${conversation_assigned_user.user_id}) and (${team_member.user_id} = ${user.id});;
    relationship: one_to_one
  }

}

explore: customer_ps {
  from: customer
  label: "Kustomer PS"
  description: "This explore is designed to pull Kustomer metrics powering PS dashboards."
  join: conversation_ps {
    type: inner
    sql_on: ${customer_ps.id} = ${conversation_ps.customer_id};;
    relationship: one_to_many
  }


  join: conversation_tag {
    type: left_outer
    sql_on: ${conversation_ps.id} = ${conversation_tag.conversation_id} ;;
    relationship: one_to_many
  }

  join: tag {
    type: left_outer
    sql_on: ${conversation_tag.tag_id} = ${tag.id} ;;
    # I believe you can have multiple tags per conversation
    relationship: one_to_many
  }


  join: conversation_assigned_user {
    type: left_outer
    sql_on: ${conversation_ps.id} = ${conversation_assigned_user.conversation_id} ;;
    relationship: one_to_one
  }

  join: user {
    type: left_outer
    sql_on: ${conversation_assigned_user.user_id} = ${user.id};;
    relationship: many_to_one
  }

  join: conversation_assigned_team {
    type: left_outer
    sql_on: ${conversation_assigned_team.conversation_id} = ${conversation_ps.id} ;;
    relationship: many_to_one
  }

  join: team {
    type: left_outer
    sql_on: ${conversation_assigned_team.team_id} = ${team.id} ;;
    relationship: many_to_one
  }
}

explore: gx_scorecard {
  label: "GX Scorecard"
  hidden: no
}

explore: refund_notes {
  fields: [refund_notes*, financials_audit.amount, financials_audit.type, financials_audit.actualizedat_modified]
  label: "Refund Notes"
  hidden: no

  join: reservations_clean {
    type: left_outer
    sql_on: ${reservations_clean.confirmationcode} = ${refund_notes.third_bracket} ;;
    relationship: one_to_one
  }

  join: financials_audit {
    type: left_outer
    sql_on: ${reservations_clean._id} = ${financials_audit.reservation} ;;
    relationship: one_to_many
  }

  join: units {
    type: left_outer
    sql_on: ${reservations_clean.unit} = ${units._id} ;;
    relationship: one_to_one
  }
}
