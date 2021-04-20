view: post_checkout_v2 {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.post_checkout_v2`
      ;;

    persist_for: "6 hours"
  }

  dimension: overall__how_would_you_rate_your_kasa_stay_ {
    label: "Overall Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay_ ;;
  }

  dimension: _cleanliness___how_clean_was_the_kasa_when_you_arrived_ {
    label: "Cleanliness Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_ ;;
  }

  dimension: how_did_we_miss_the_mark_on_cleanliness_ {
    group_label: "Comments"
    label: "Cleanliness Comments"
    type: string
    sql: ${TABLE}.How_did_we_miss_the_mark_on_cleanliness_ ;;
  }

  dimension: _accuracy___how_did_the_kasa_compare_to_what_you_expected_ {
    label: "Accuracy Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Accuracy___How_did_the_Kasa_compare_to_what_you_expected_ ;;
  }

  dimension: what_aspects_were_different_from_you_expected_ {
    group_label: "Comments"
    label: "Accuracy Comments"
    type: string
    sql: ${TABLE}.What_aspects_were_different_from_you_expected_ ;;
  }

  dimension: _communications___how_were_your_interactions_with_the_kasa_team_ {
    label: "Communication Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Communications___How_were_your_interactions_with_the_Kasa_team_ ;;
  }

  dimension: what_aspects_of_communications_fell_short_ {
    group_label: "Comments"
    label: "Communication Comments"
    type: string
    sql: ${TABLE}.What_aspects_of_communications_fell_short_ ;;
  }

  dimension: _location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_ {
    label: "Location Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Location___How_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_ ;;
  }

  dimension: how_did_the_property_location_fall_short_ {
    group_label: "Comments"
    label: "Location Comments"
    type: string
    sql: ${TABLE}.How_did_the_property_location_fall_short_ ;;
  }

  dimension: _check_in___how_smooth_was_your_check_in_and_arrival_process_ {
    label: "Checkin Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Check_in___How_smooth_was_your_check_in_and_arrival_process_ ;;
  }

  dimension: how_did_the_the_check_in_experience_miss_the_mark_ {
    group_label: "Comments"
    label: "Checkin Comments"
    type: string
    sql: ${TABLE}.How_did_the_the_check_in_experience_miss_the_mark_ ;;
  }

  dimension: _value___was_your_stay_a_good_value_for_the_price_ {
    label: "Value Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Value___Was_your_stay_a_good_value_for_the_price_ ;;
  }

  dimension: what_would_have_made_your_stay_feel_like_a_better_value_ {
    group_label: "Comments"
    label: "Value Comments"
    type: string
    sql: ${TABLE}.What_would_have_made_your_stay_feel_like_a_better_value_ ;;
  }

  dimension: how_likely_are_you_to_recommend_kasa_to_someone_else_ {
    label: "NPS Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}.How_likely_are_you_to_recommend_Kasa_to_someone_else_ ;;
  }

  dimension: how_would_you_feel_if_you_could_no_longer_stay_at_any_kasa_locations_ {
    group_label: "Questions"
    type: string
    sql: ${TABLE}.How_would_you_feel_if_you_could_no_longer_stay_at_any_Kasa_locations_ ;;
  }

  dimension: thanks_for_giving_us_your_feedback___your_insights_will_directly_improve_the_kasa_experience__coming_up_next_are_a_few_more_questions_about_your_trip_ {
    group_label: "Questions"
    hidden: yes
    type: string
    sql: ${TABLE}.Thanks_for_giving_us_your_feedback___your_insights_will_directly_improve_the_Kasa_experience__Coming_up_next_are_a_few_more_questions_about_your_trip_ ;;
  }

  dimension: what_was_the_primary_purpose_of_your_trip_ {
    label: "Trip Purpose"
    type: string
    sql: ${TABLE}.What_was_the_primary_purpose_of_your_trip_ ;;
  }

  dimension: what_best_describes_your_travel_party_ {
    label: "Travel Party"
    type: string
    sql: ${TABLE}.What_best_describes_your_travel_party_ ;;
  }

  dimension: how_often_do_you_plan_to_return_to_this_destination_ {
    group_label: "Questions"
    type: string
    sql: ${TABLE}.How_often_do_you_plan_to_return_to_this_destination_ ;;
  }

  dimension: why_did_you_choose_to_stay_at_this_particular_property_ {
    group_label: "Questions"
    type: string
    sql: ${TABLE}.Why_did_you_choose_to_stay_at_this_particular_property_ ;;
  }

  dimension: what_was_your_favorite_aspect_of_the_kasa_experience_ {
    group_label: "Questions"
    type: string
    sql: ${TABLE}.What_was_your_favorite_aspect_of_the_Kasa_experience_ ;;
  }

  dimension: what_else_could_kasa_have_done_to_improve_your_stay_ {
    group_label: "Questions"
    type: string
    sql: ${TABLE}.What_else_could_Kasa_have_done_to_improve_your_stay_ ;;
  }

  dimension: email {
    hidden: yes
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: confirmationcode {
    hidden: no
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: unitinternaltitle {
    hidden: yes
    type: string
    sql: ${TABLE}.unitinternaltitle ;;
  }

  dimension: complex {
    hidden: yes
    type: string
    sql: ${TABLE}.complex ;;
  }

  dimension: staycount {
    hidden: yes
    type: number
    sql: ${TABLE}.staycount ;;
  }

  dimension: _thanks_for_your_stay_and_feedback____don_t_forget_to_leave_a_review_on_the_platform_where_you_originally_booked_and__on_google__http___s_kasa_com_google__too_ {
    group_label: "Questions"
    hidden: yes
    type: string
    sql: ${TABLE}._Thanks_for_your_stay_and_feedback____Don_t_forget_to_leave_a_review_on_the_platform_where_you_originally_booked_and__on_Google__http___s_kasa_com_google__too_ ;;
  }

  dimension: thanks_for_your_feedback____we_are_sorry_the_experience_did_not_deliver_on_every_dimension___we_hope_you_ll_give_us_another_shot_in_the_future___please_use_discount_code__secondchance__for_10__off_your_next_stay_with_kasa_ {
    group_label: "Questions"
    hidden: yes
    type: string
    sql: ${TABLE}.Thanks_for_your_feedback____we_are_sorry_the_experience_did_not_deliver_on_every_dimension___We_hope_you_ll_give_us_another_shot_in_the_future___Please_use_discount_code__SECONDCHANCE__for_10__off_your_next_stay_with_Kasa_ ;;
  }

  dimension: score {
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: winning_outcome_id {
    hidden: yes
    type: string
    sql: ${TABLE}.winning_outcome_id ;;
  }

  dimension: ending_displayed_id {
    hidden: yes
    type: string
    sql: ${TABLE}.ending_displayed_id ;;
  }

  dimension_group: submitted_at {
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
    sql: ${TABLE}.Submitted_At ;;
    convert_tz: no
  }

  dimension: token {
    type: string
    hidden: yes
    sql: ${TABLE}.Token ;;
  }

  measure: count {
    label: "PSS Review Count"
    type: count_distinct
    sql: ${confirmationcode} ;;

  }

  set: detail {
    fields: [

    ]
  }
}
