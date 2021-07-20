view: post_checkout_v2 {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.post_checkout_v2`
      ;;

    persist_for: "1 hours"
  }

  dimension: aggregated_comments {
    label: "Aggregated Communication Comments"
    view_label: "Review Force"
    description: "This will aggregate all communication related comments from different review channels (airbnb, Postcheckout, Postcheckout V2) into one block which was utilized for the Over-Communication Analysis."
    type: string
    sql: CONCAT(COALESCE(${airbnb_reviews.private_feedback},"PC: Null")," | ",COALESCE(${airbnb_reviews.communication_comments},"CC: Null")," | ",
          COALESCE(${airbnb_reviews.overall_comments},"OC: Null")," | ",
          COALESCE(${post_checkout_data.overall_feedback},"O-PSS: Null")," | ",COALESCE(${post_checkout_data.suggestion},"S-PSS: Null")," | ",
          COALESCE(${what_else_could_kasa_have_done_to_improve_your_stay_},"O-PSS2: Null")," | ",COALESCE(${what_aspects_of_communications_fell_short_},"C-PSS2: Null")) ;;
  }


  dimension: contains_buzzword {
    view_label: "Review Force"
    label: "Contains Buzz Word (Communication)"
    description: "This field has been created to display all aggregated comments from different review channels (airbnb, Postcheckout, Postcheckout V2) which contain one of the defined buzzwords pertinent to overcommunication such as communication, text, email, etc."
    type: yesno
    sql: lower(${aggregated_comments}) LIKE "%communicat%" OR lower(${aggregated_comments}) LIKE "%automat%" OR lower(${aggregated_comments}) LIKE "%email%"
          OR lower(${aggregated_comments}) LIKE "%text%" OR lower(${aggregated_comments}) LIKE "%e-mail%" OR lower(${aggregated_comments}) LIKE "%phone%"
          OR lower(${aggregated_comments}) LIKE "%talk%" ;;
  }

  dimension: aggregated_comments_all {
    label: "Aggregated Comments (All)"
    view_label: "Review Force"
    description: "This will aggregate all review comments from different review channels (airbnb, Postcheckout, Postcheckout V2) into one block."
    type: string
    hidden: yes
    sql: CONCAT("Overall Comments: ", COALESCE(${airbnb_reviews.overall_comments},"N/A"),"~",COALESCE(${what_else_could_kasa_have_done_to_improve_your_stay_},"N/A"),"~",COALESCE(${post_checkout_data.overall_feedback},"N/A"),"~",
          COALESCE(${post_checkout_data.suggestion},"N/A"),"~",COALESCE(${airbnb_reviews.private_feedback},"N/A"),"~",
          COALESCE(${why_did_you_choose_to_stay_at_this_particular_property_},"N/A"), "~",COALESCE(${what_was_your_favorite_aspect_of_the_kasa_experience_},"N/A"),"---",
        "Cleaning Comments: ", COALESCE(${airbnb_reviews.cleanliness_comments},"N/A"),"~",COALESCE(${how_did_we_miss_the_mark_on_cleanliness_},"N/A"),"---",
        "Communication Comments: ",COALESCE(${airbnb_reviews.communication_comments},"N/A"),"~",COALESCE(${what_aspects_of_communications_fell_short_},"N/A"),"---",
        "Accuracy Comments: ", COALESCE(${airbnb_reviews.accuracy_comments},"N/A"),"~",COALESCE(${what_aspects_were_different_from_you_expected_},"N/A"),"---",
        "Value Comments: ", COALESCE(${airbnb_reviews.value_comments},"N/A"),"~",COALESCE(${what_would_have_made_your_stay_feel_like_a_better_value_},"N/A"),"---",
        "Location Comments: ", COALESCE(${airbnb_reviews.location_comments},"N/A"),"~", COALESCE(${how_did_the_property_location_fall_short_},"N/A"),"---",
        "Checkin Comments: ", COALESCE(${airbnb_reviews.checkin_comments},"N/A"),"~", COALESCE(${how_did_the_the_check_in_experience_miss_the_mark_},"N/A"),"---",
        "Real-time Review Comments: ", COALESCE(${reviews.aggregated_comments},"N/A"))
        ;;
  }


  dimension: aggregated_comments_all_clean {
    label: "Aggregated Comments (All)"
    view_label: "Review Force"
    description: "This will aggregate all review comments from different review channels (airbnb, Postcheckout, Postcheckout V2) into one block."
    type: string
    sql: LTRIM(regexp_replace(regexp_replace(
        RTRIM(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(
          regexp_replace(regexp_replace(${aggregated_comments_all},"Overall Comments: N/A~N/A~N/A~N/A~N/A~N/A~N/A",""),"Checkin Comments: N/A~N/A",""),"Cleaning Comments: N/A~N/A",""),"Communication Comments: N/A~N/A",""),"Accuracy Comments: N/A~N/A",""),"Value Comments: N/A~N/A",""),"Location Comments: N/A~N/A",""),"Real-time Review Comments: ~N/A",""),"~N/A",""),"-"),"~","|"),"N/A|",""),"-")
              ;;
  }




  dimension: overall__how_would_you_rate_your_kasa_stay_ {
    label: "Overall Rating"
    group_label: "Ratings"
    type: number
    sql:
    CASE
    WHEN ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay_ is NULL THEN  ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay__V2_
    ELSE ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay_
    END;;
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
    hidden: no
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: nps {
    hidden: no
    label: "NPS"
    type: string
    sql: CASE WHEN ${how_likely_are_you_to_recommend_kasa_to_someone_else_} > 8 THEN "Promoter"
    WHEN ${how_likely_are_you_to_recommend_kasa_to_someone_else_} > 6 THEN "Neutral"
    WHEN ${how_likely_are_you_to_recommend_kasa_to_someone_else_} is null THEN null
    ELSE "Detractor"
    END ;;
  }

  dimension: confirmationcode {
    label: "PSS_v2 Confirmation Code"
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
    label: "Post Checkout Survey Review Count"
    type: count_distinct
    sql: ${confirmationcode} ;;
  }

  measure: overall_measure {
    label: "Average Overall Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${overall__how_would_you_rate_your_kasa_stay_} ;;
  }

  measure: cleanliness_measure {
    label: "Average Cleanliness Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_ ;;
  }

  measure: accuracy_measure {
    label: "Average Accuracy Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Accuracy___How_did_the_Kasa_compare_to_what_you_expected_ ;;
  }

  measure: communication_measure {
    label: "Average Communication Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Communications___How_were_your_interactions_with_the_Kasa_team_ ;;
  }

  measure: location_measure {
    label: "Average Location Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Location___How_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_ ;;
  }

  measure: checkin_measure {
    label: "Average Checkin Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Check_in___How_smooth_was_your_check_in_and_arrival_process_ ;;
  }

  measure: value_measure {
    label: "Average Value Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${TABLE}._Value___Was_your_stay_a_good_value_for_the_price_ ;;
  }


  measure: promotor_count {
    type: count
    value_format: "0"
    filters: [
      nps: "Promoter"
    ]
  }

  measure: detractor_count {
    type: count
    value_format: "0"
    filters: [
      nps: "Detractor"
    ]
  }

  measure: nps_measure {
    label: "NPS Rating"
    type: number
    value_format: "0.0"
    sql: 100*((${promotor_count}-${detractor_count})/ NULLIF(count(${nps}),0));;
  }

  measure: overall_count_5_star {
    label: "Count 5 Star (Overall)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "5"]
  }

  measure: cleanliness_5_star {
    label: "Count 5 Star (Cleanliness)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_cleanliness___how_clean_was_the_kasa_when_you_arrived_: "5"]
  }

  measure: accuracy_5_star {
    label: "Count 5 Star (Accuracy)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_accuracy___how_did_the_kasa_compare_to_what_you_expected_: "5"]
  }

  measure: communication_5_star {
    label: "Count 5 Star (Communication)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_communications___how_were_your_interactions_with_the_kasa_team_: "5"]
  }

  measure: location_5_star {
    label: "Count 5 Star (Location)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_: "5"]
  }

  measure: checkin_5_star {
    label: "Count 5 Star (Checkin)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_check_in___how_smooth_was_your_check_in_and_arrival_process_: "5"]
  }

  measure: value_5_star {
    label: "Count 5 Star (Value)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_value___was_your_stay_a_good_value_for_the_price_: "5"]
  }

  measure: overall_count_less_than_4_star {
    label: "Count Less Than 4 Star (Overall)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "<=3"]
  }

  measure: cleanliness_less_than_4_star {
    label: "Count Less Than 4 Star (Cleanliness)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_cleanliness___how_clean_was_the_kasa_when_you_arrived_: "<=3"]
  }

  measure: accuracy_less_than_4_star {
    label: "Count Less Than 4 Star (Accuracy)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_accuracy___how_did_the_kasa_compare_to_what_you_expected_: "<=3"]
  }

  measure: communication_less_than_4_star {
    label: "Count Less Than 4 Star (Communication)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_communications___how_were_your_interactions_with_the_kasa_team_: "<=3"]
  }

  measure: location_less_than_4_star {
    label: "Count Less Than 4 Star (Location)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_: "<=3"]
  }

  measure: checkin_less_than_4_star {
    label: "Count Less Than 4 Star (Checkin)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_check_in___how_smooth_was_your_check_in_and_arrival_process_: "<=3"]
  }

  measure: value_less_than_4_star {
    label: "Count Less Than 4 Star (Value)"
    group_label: "Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_value___was_your_stay_a_good_value_for_the_price_: "<=3"]
  }

  measure: percent_5_star_overall {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Overall)"
    type: number
    value_format: "0.0%"
    sql: ${overall_count_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_cleanliness {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Cleanliness)"
    type: number
    value_format: "0.0%"
    sql: ${cleanliness_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_accuracy {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_checkin {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Checkin)"
    type: number
    value_format: "0.0%"
    sql: ${checkin_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_communication {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Communication)"
    type: number
    value_format: "0.0%"
    sql: ${communication_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_location {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Location)"
    type: number
    value_format: "0.0%"
    sql: ${location_5_star} / nullif(${count},0) ;;
  }

  measure: percent_5_star_value {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Value)"
    type: number
    value_format: "0.0%"
    sql: ${value_5_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_overall {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Overall)"
    type: number
    value_format: "0.0%"
    sql: ${overall_count_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_cleanliness {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Cleanliness)"
    type: number
    value_format: "0.0%"
    sql: ${cleanliness_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_accuracy {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_checkin {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Checkin)"
    type: number
    value_format: "0.0%"
    sql: ${checkin_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_communication {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Communication)"
    type: number
    value_format: "0.0%"
    sql: ${communication_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_location {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Location)"
    type: number
    value_format: "0.0%"
    sql: ${location_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: percent_less_than_4_star_value {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Value)"
    type: number
    value_format: "0.0%"
    sql: ${value_less_than_4_star} / nullif(${count},0) ;;
  }

  measure: net_quality_score_overall {
    group_label: "NQS Metrics"
    label: "NQS (Overall)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_overall} - ${percent_less_than_4_star_overall});;
  }

  measure: net_quality_score_accuracy {
    group_label: "NQS Metrics"
    label: "NQS (Accuracy)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_accuracy} - ${percent_less_than_4_star_accuracy});;
  }

  measure: net_quality_score_checkin {
    group_label: "NQS Metrics"
    label: "NQS (Checkin)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_checkin} - ${percent_less_than_4_star_checkin});;
  }

  measure: net_quality_score_cleanliness {
    group_label: "NQS Metrics"
    label: "NQS (Cleanliness)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_cleanliness} - ${percent_less_than_4_star_cleanliness});;
  }

  measure: net_quality_score_communication {
    group_label: "NQS Metrics"
    label: "NQS (Communication)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_communication} - ${percent_less_than_4_star_communication});;
  }

  measure: net_quality_score_location {
    group_label: "NQS Metrics"
    label: "NQS (Location)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_location} - ${percent_less_than_4_star_location});;
  }

  measure: net_quality_score_value {
    group_label: "NQS Metrics"
    label: "NQS (Value)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_value} - ${percent_less_than_4_star_value});;
  }

  measure: percent_4_star_overall {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Overall)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_overall} + ${percent_less_than_4_star_overall});;
  }

  measure: percent_4_star_cleanliness {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Cleanliness)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_cleanliness} + ${percent_less_than_4_star_cleanliness});;
  }

  measure: percent_4_star_checkin {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Checkin)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_checkin} + ${percent_less_than_4_star_checkin});;
  }

  measure: percent_4_star_communication {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Communication)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_communication} + ${percent_less_than_4_star_communication});;
  }

  measure: percent_4_star_location {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Location)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_location} + ${percent_less_than_4_star_location});;
  }

  measure: percent_4_star_value {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Value)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_value} + ${percent_less_than_4_star_value});;
  }

  measure: percent_4_star_accuracy {
    group_label: "Review Percentages"
    label: "Percent 4 Star (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_accuracy} + ${percent_less_than_4_star_accuracy});;
  }


  set: detail {
    fields: [

    ]
  }
}
