view: post_checkout_v2 {
  sql_table_name: `bigquery-analytics-272822.dbt.postcheckout_SMS_EmailClick` ;;
#   derived_table: {
#     sql:select *
# from
# (
# Select
#     *, dense_rank() over(partition by confirmationcode order by submitted_at desc ) as latest_submission
# from
# `bigquery-analytics-272822.Gsheets.post_checkout_v2`
# where confirmationcode not like '%test%' and  confirmationcode not like '%xxxxx%' and confirmationcode is not null

# union all
# SELECT
# *,dense_rank() over(partition by confirmationcode order by submitted_at desc ) as latest_submission
# FROM `bigquery-analytics-272822.Gsheets.post_checkout_v2_FIVE_STAR_VARIANT`
# where  confirmationcode not like '%test%' and confirmationcode not like '%xxxxx%'
# )
# where latest_submission=1 ;;

  #   persist_for: "4 hours"
  # }

  # Over Communication Analysis
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

  # Over Communication Analysis
  dimension: contains_buzzword {
    view_label: "Review Force"
    label: "Contains Buzz Word (Communication)"
    description: "This field has been created to display all aggregated comments from different review channels (airbnb, Postcheckout, Postcheckout V2) which contain one of the defined buzzwords pertinent to overcommunication such as communication, text, email, etc."
    type: yesno
    sql: lower(${aggregated_comments}) LIKE "%communicat%" OR lower(${aggregated_comments}) LIKE "%automat%" OR lower(${aggregated_comments}) LIKE "%email%"
          OR lower(${aggregated_comments}) LIKE "%text%" OR lower(${aggregated_comments}) LIKE "%e-mail%" OR lower(${aggregated_comments}) LIKE "%phone%"
          OR lower(${aggregated_comments}) LIKE "%talk%" ;;
  }

  dimension: aggregated_comments_all_unclean {
    label: "Aggregated Comments (All) - UNCLEAN"
    view_label: "Review Force"
    description: "This will aggregate all review comments from different review channels (airbnb, Postcheckout, Postcheckout V2) into one block."
    type: string
    hidden: yes
    sql: CONCAT("Overall Comments: ", COALESCE(${airbnb_reviews.overall_comments},"N/A"),"~", COALESCE(${airbnb_reviews.private_feedback},"N/A"),"~", COALESCE(${post_checkout_data.overall_feedback},"N/A"),"---",
        "Accuracy Comments: ", COALESCE(${airbnb_reviews.accuracy_comments},"N/A"),"~",COALESCE(${what_aspects_were_different_from_you_expected_},"N/A"),"---",
        "Checkin Comments: ", COALESCE(${airbnb_reviews.checkin_comments},"N/A"),"~", COALESCE(${how_did_the_the_check_in_experience_miss_the_mark_},"N/A"),"~",COALESCE(${reviews.checkin_text},"N/A"),"---",
        "Cleaning Comments: ", COALESCE(${airbnb_reviews.cleanliness_comments},"N/A"),"~",COALESCE(${how_did_we_miss_the_mark_on_cleanliness_},"N/A"),"~",COALESCE(${reviews.cleaning_text},"N/A"),"---",
        "Communication Comments: ",COALESCE(${airbnb_reviews.communication_comments},"N/A"),"~",COALESCE(${what_aspects_of_communications_fell_short_},"N/A"),"---",
        "Location Comments: ", COALESCE(${airbnb_reviews.location_comments},"N/A"),"~", COALESCE(${how_did_the_property_location_fall_short_},"N/A"),"---",
        "Value Comments: ", COALESCE(${airbnb_reviews.value_comments},"N/A"),"~",COALESCE(${what_would_have_made_your_stay_feel_like_a_better_value_},"N/A"),"---",
        "Favorite: ", COALESCE(${what_was_your_favorite_aspect_of_the_kasa_experience_},"N/A"),"---",
        "Suggestions: ", COALESCE(${what_else_could_kasa_have_done_to_improve_your_stay_},"N/A"),"~",COALESCE(${post_checkout_data.suggestion},"N/A"),"---",
        "Kustomer CSAT Comments: ", COALESCE(${csat_review.csat_review},"N/A"));;
  }


  dimension: aggregated_comments_all_clean {
    label: "Aggregated Comments (All)"
    view_label: "Review Force"
    hidden: no
    description: "This will aggregate all review comments from different review channels (airbnb, Postcheckout, Postcheckout V2) into one block."
    type: string
    sql: LTRIM(regexp_replace(regexp_replace(RTRIM(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(
          regexp_replace(regexp_replace(regexp_replace(regexp_replace(${aggregated_comments_all_unclean},"Overall Comments: N/A~N/A~N/A---",""),"Checkin Comments: N/A~N/A~N/A---",""),"Cleaning Comments: N/A~N/A~N/A---",""),"Communication Comments: N/A~N/A---",""),"Accuracy Comments: N/A~N/A---",""),"Value Comments: N/A~N/A---",""),"Location Comments: N/A~N/A---",""),"Favorite: N/A---",""),"Suggestions: N/A~N/A---",""),"Kustomer CSAT Comments: N/A",""),"~N/A",""),"---"),"N/A~",""),"~","|"),"---")
              ;;
  }

  dimension: overall__how_would_you_rate_your_kasa_stay_ {
    label: "Overall Rating"
    group_label: "Ratings"
    type: number
    sql:
    CASE
    WHEN (${TABLE}.TypoFormsubmission is NOT NULL and ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay_ is NULL) THEN  ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay__V2_
    WHEN (${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is not null) THEN ${TABLE}.overAllRatingSMS
    WHEN (${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is  NULL and ${TABLE}.EmailClick is not null) THEN cast(${TABLE}.overAllRatingEmailClick as int)
    ELSE ${TABLE}.Overall__how_would_you_rate_your_Kasa_stay_
    END;;
  }

  dimension: _cleanliness___how_clean_was_the_kasa_when_you_arrived_ {
    label: "Cleanliness Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_  ;;
    #sql:CASE when  ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_ is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null ) and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else  ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_ end ;;
  }


  dimension: how_did_we_miss_the_mark_on_cleanliness_ {
    group_label: "Comments"
    label: "Cleanliness Comments"
    type: string
    sql: ${TABLE}.How_did_we_miss_the_mark_on_cleanliness_  ;;
      }

  dimension: _accuracy___how_did_the_kasa_compare_to_what_you_expected_ {
    label: "Accuracy Rating"
    group_label: "Ratings"
    type: number
    sql: ${TABLE}._Accuracy___How_did_the_Kasa_compare_to_what_you_expected_ ;;
    #sql:CASE when ${TABLE}._Accuracy___How_did_the_Kasa_compare_to_what_you_expected_  is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null ) and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else  ${TABLE}._Accuracy___How_did_the_Kasa_compare_to_what_you_expected_  end ;;
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
    sql:${TABLE}._Communications___How_were_your_interactions_with_the_Kasa_team_  ;;
    #sql:CASE when ${TABLE}._Communications___How_were_your_interactions_with_the_Kasa_team_ is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null ) and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else ${TABLE}._Communications___How_were_your_interactions_with_the_Kasa_team_  end ;;
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
    #sql:CASE when ${TABLE}._Location___How_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_ is null AND
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null )
   #and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else ${TABLE}._Location___How_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_ end ;;

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
    #sql:CASE when ${TABLE}._Check_in___How_smooth_was_your_check_in_and_arrival_process_ is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null )and
     #${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else ${TABLE}._Check_in___How_smooth_was_your_check_in_and_arrival_process_ end ;;
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
   #sql:CASE when ${TABLE}._Value___Was_your_stay_a_good_value_for_the_price_ is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null )
    #and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else  ${TABLE}._Value___Was_your_stay_a_good_value_for_the_price_ end ;;
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
    #sql:CASE when ${TABLE}.How_likely_are_you_to_recommend_Kasa_to_someone_else_ is null and
    #(${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null )
    #and ${overall__how_would_you_rate_your_kasa_stay_}=5 then 5 else
    #${TABLE}.How_likely_are_you_to_recommend_Kasa_to_someone_else_ end ;;
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
  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.userid ;;
  }
  dimension: source {
    hidden: yes
    type: string
    sql: ${TABLE}.source ;;
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
    sql:CASE
WHEN ${TABLE}.TypoFormsubmission is not null then ${TABLE}.confirmationcode
WHEN ${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is not null THEN ${TABLE}.confirmationcodeSMS
WHEN ${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is Null and ${TABLE}.EmailClick is not null THEN  ${TABLE}.confirmationcodeEmailClick
END;;
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
  dimension: review_Source {
    description: "Review Source (Typeform,SMS, Email Click)"
    type: string
    sql: CASE WHEN ${TABLE}.TypoFormsubmission is not null THEN "Typeform"
              WHEN ${TABLE}.SMSRelpy is not null THEN "SMS"
              WHEN ${TABLE}.EmailClick is not null THEN "Email Click"
              END;;
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
      day_of_week,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql:CASE
WHEN ${TABLE}.TypoFormsubmission is not null then ${TABLE}.Submitted_At
WHEN ${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is not null THEN ${TABLE}.timestampSMS
WHEN ${TABLE}.TypoFormsubmission is NULL and ${TABLE}.SMSRelpy is Null and ${TABLE}.EmailClick is not null THEN ${TABLE}.timestampEmailClick
END;;
    convert_tz: no
  }

  dimension: token {
    type: string
    hidden: yes
    sql: ${TABLE}.Token ;;
  }

  dimension: number_of_days {
    description: "Number of days it took to complete real-time checkin survey post check-in"
    hidden: yes
    type:  number
    sql:  date_diff(${submitted_at_date}, ${reservations_clean.checkoutdate_date}, DAY) ;;
  }
  dimension:isAutopopulated{
    label: "Is Auto-populated(Yes/No)"
    description: "Yes if subcatigory Auto-populated with 5s"

    type:string
    sql: CASE when  ${TABLE}._Cleanliness___How_clean_was_the_Kasa_when_you_arrived_ is null and
      (${TABLE}.TypoFormsubmission is NOT NULL or ${TABLE}.SMSRelpy is Not null ) and ${overall__how_would_you_rate_your_kasa_stay_}=5 then "Yes" else "No" end ;;
  }

  measure: number_of_days_median {
    description: "Median number of days it took to complete Post-checkout Survey."
    label: "Median # of Days to Complete Post-checkout Survey"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${number_of_days};;
  }

  measure: count {
    label: "Review Count"
    type: count_distinct
    sql: ${confirmationcode} ;;
  }

  measure: count_clean {
    type: count_distinct
    label: "Review Count (Subcategories)"
    sql: ${confirmationcode} ;;
    filters: [
      _cleanliness___how_clean_was_the_kasa_when_you_arrived_: "1,2,3,4,5"
    ]
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
    sql: ${_cleanliness___how_clean_was_the_kasa_when_you_arrived_} ;;
    drill_fields: [submitted_at_date, reservations_clean.checkindate_date, reservations_clean.checkoutdate_date , units.internaltitle, _cleanliness___how_clean_was_the_kasa_when_you_arrived_, how_did_we_miss_the_mark_on_cleanliness_, what_would_have_made_your_stay_feel_like_a_better_value_]
  }

  measure: accuracy_measure {
    label: "Average Accuracy Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${_accuracy___how_did_the_kasa_compare_to_what_you_expected_} ;;
  }

  measure: communication_measure {
    label: "Average Communication Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${_communications___how_were_your_interactions_with_the_kasa_team_} ;;
  }

  measure: location_measure {
    label: "Average Location Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_} ;;
  }

  measure: checkin_measure {
    label: "Average Checkin Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${_check_in___how_smooth_was_your_check_in_and_arrival_process_} ;;
  }

  measure: value_measure {
    label: "Average Value Rating"
    group_label: "Ratings (Aggregated)"
    type: average
    value_format: "0.00"
    sql: ${_value___was_your_stay_a_good_value_for_the_price_} ;;
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
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "5"]
  }

  measure: overall_count_3_star {
    label: "Count 3 Star (Overall)"
    hidden: yes
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "3"]
  }

  measure: overall_count_2_star {
    label: "Count 2 Star (Overall)"
    hidden: yes
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "2"]
  }

  measure: overall_count_1_star {
    label: "Count 1 Star (Overall)"
    hidden: yes
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "1"]
  }

  measure: cleanliness_5_star {
    label: "Count 5 Star (Cleanliness)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_cleanliness___how_clean_was_the_kasa_when_you_arrived_: "5"]
  }

  measure: accuracy_5_star {
    label: "Count 5 Star (Accuracy)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_accuracy___how_did_the_kasa_compare_to_what_you_expected_: "5"]
  }

  measure: communication_5_star {
    label: "Count 5 Star (Communication)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_communications___how_were_your_interactions_with_the_kasa_team_: "5"]
  }

  measure: location_5_star {
    label: "Count 5 Star (Location)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_: "5"]
  }

  measure: checkin_5_star {
    label: "Count 5 Star (Checkin)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_check_in___how_smooth_was_your_check_in_and_arrival_process_: "5"]
  }

  measure: value_5_star {
    label: "Count 5 Star (Value)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_value___was_your_stay_a_good_value_for_the_price_: "5"]
  }

  measure: overall_combined_count_5_star {
    label: "Count 5 Star (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_5_star} + ${airbnb_reviews.count_5_star};;
  }

  measure: overall_combined_count_4_star {
    label: "Count 4 Star (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_4_star} + ${airbnb_reviews.count_4_star} ;;
  }

  measure: overall_combined_count_3_star_less {
    label: "Count 3 Star or Less (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_less_than_4_star} + ${airbnb_reviews.count_less_than_4_star} ;;
  }

  measure: overall_combined_count_3_star {
    label: "Count 3 Star (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_3_star} + ${airbnb_reviews.count_3_star} ;;
  }

  measure: overall_combined_count_2_star {
    label: "Count 2 Star (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_2_star} + ${airbnb_reviews.count_2_star} ;;
  }

  measure: overall_combined_count_1_star {
    label: "Count 1 Star (Overall)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${overall_count_1_star} + ${airbnb_reviews.count_1_star} ;;
  }

  measure: combined_percent_5_star_overall {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Overall)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${overall_combined_count_5_star} / nullif(${combined_count_overall},0) ;;
  }

  measure: combined_percent_4_star_overall {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Overall)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${overall_combined_count_4_star} / nullif(${combined_count_overall},0) ;;
  }

  measure: combined_percent_3_star_less_overall {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Overall)"
    type: number
    value_format: "0.0%"
    sql: ${overall_combined_count_3_star_less} / nullif(${combined_count_overall},0) ;;
  }

  measure: accuracy_combined_count_5_star {
    label: "Count 5 Star (Accuracy)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${accuracy_5_star} + ${airbnb_reviews.accuracy_count_5_star};;
  }

  measure: accuracy_combined_count_4_star {
    label: "Count 4 Star (Accuracy)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${accuracy_4_star} + ${airbnb_reviews.accuracy_count_4_star} ;;
  }

  measure: accuracy_combined_count_3_star_less {
    label: "Count 3 Star or Less (Accuracy)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${accuracy_less_than_4_star} + ${airbnb_reviews.accuracy_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_accuracy {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Accuracy)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_accuracy {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Accuracy)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_accuracy {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: checkin_combined_count_5_star {
    label: "Count 5 Star (Checkin)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${checkin_5_star} + ${airbnb_reviews.checkin_count_5_star};;
  }

  measure: checkin_combined_count_4_star {
    label: "Count 4 Star (Checkin)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${checkin_4_star} + ${airbnb_reviews.count_4_star_checkin} ;;
  }

  measure: checkin_combined_count_3_star_less {
    label: "Count 3 Star or Less (Checkin)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${checkin_less_than_4_star} + ${airbnb_reviews.checkin_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_checkin {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Checkin)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${checkin_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_checkin {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Checkin)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${checkin_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_checkin {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Checkin)"
    type: number
    value_format: "0.0%"
    sql: ${checkin_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: clean_combined_count_5_star {
    label: "Count 5 Star (Clean)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${cleanliness_5_star} + ${airbnb_reviews.clean_count_5_star};;
  }

  measure: clean_combined_count_4_star {
    label: "Count 4 Star (Clean)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${cleanliness_4_star} + ${airbnb_reviews.count_4_star_clean} ;;
  }

  measure: clean_combined_count_3_star_less {
    label: "Count 3 Star or Less (Clean)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${cleanliness_less_than_4_star} + ${airbnb_reviews.clean_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_clean {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Clean)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${clean_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_clean {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Clean)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${clean_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_clean {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Clean)"
    type: number
    value_format: "0.0%"
    sql: ${clean_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: communication_combined_count_5_star {
    label: "Count 5 Star (Communication)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${communication_5_star} + ${airbnb_reviews.communication_count_5_star};;
  }

  measure: communication_combined_count_4_star {
    label: "Count 4 Star (Communication)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${communication_4_star} + ${airbnb_reviews.count_4_star_communication} ;;
  }

  measure: communication_combined_count_3_star_less {
    label: "Count 3 Star or Less (Communication)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${communication_less_than_4_star} + ${airbnb_reviews.communication_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_communication {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Communication)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${communication_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_communication {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Communication)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${communication_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_communication {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Communication)"
    type: number
    value_format: "0.0%"
    sql: ${communication_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: location_combined_count_5_star {
    label: "Count 5 Star (Location)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${location_5_star} + ${airbnb_reviews.location_count_5_star};;
  }

  measure: location_combined_count_4_star {
    label: "Count 4 Star (Location)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${location_4_star} + ${airbnb_reviews.count_4_star_location} ;;
  }

  measure: location_combined_count_3_star_less {
    label: "Count 3 Star or Less (Location)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${location_less_than_4_star} + ${airbnb_reviews.location_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_location {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Location)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${location_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_location {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Location)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${location_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_location {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Location)"
    type: number
    value_format: "0.0%"
    sql: ${location_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: value_combined_count_5_star {
    label: "Count 5 Star (Value)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${value_5_star} + ${airbnb_reviews.value_count_5_star};;
  }

  measure: value_combined_count_4_star {
    label: "Count 4 Star (Value)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${value_4_star} + ${airbnb_reviews.count_4_star_value} ;;
  }

  measure: value_combined_count_3_star_less {
    label: "Count 3 Star or Less (Value)"
    group_label: "Combined Review Count Metrics"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: ${value_less_than_4_star} + ${airbnb_reviews.value_count_less_than_4_star} ;;
  }

  measure: combined_percent_5_star_value {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Good Stays (Value)"
    description: "% of 5 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${value_combined_count_5_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_4_star_value {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    label: "Percent Neutral Stays (Value)"
    description: "% of 4 star reviews"
    type: number
    value_format: "0.0%"
    sql: ${value_combined_count_4_star} / nullif(${combined_count_clean},0) ;;
  }

  measure: combined_percent_3_star_less_value {
    group_label: "% Good / Neutral / Bad Stays"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    description: "% of 3 star reviews or less"
    label: "Percent Bad Stays (Value)"
    type: number
    value_format: "0.0%"
    sql: ${value_combined_count_3_star_less} / nullif(${combined_count_clean},0) ;;
  }

  measure: overall_count_4_star {
    label: "Count 4 Star (Overall)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "4"]
  }

  measure: cleanliness_4_star {
    label: "Count 4 Star (Cleanliness)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_cleanliness___how_clean_was_the_kasa_when_you_arrived_: "4"]
  }

  measure: accuracy_4_star {
    label: "Count 4 Star (Accuracy)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_accuracy___how_did_the_kasa_compare_to_what_you_expected_: "4"]
  }

  measure: communication_4_star {
    label: "Count 4 Star (Communication)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_communications___how_were_your_interactions_with_the_kasa_team_: "4"]
  }

  measure: location_4_star {
    label: "Count 4 Star (Location)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_: "4"]
  }

  measure: checkin_4_star {
    label: "Count 4 Star (Checkin)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_check_in___how_smooth_was_your_check_in_and_arrival_process_: "4"]
  }

  measure: value_4_star {
    label: "Count 4 Star (Value)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_value___was_your_stay_a_good_value_for_the_price_: "4"]
  }



  measure: overall_count_less_than_4_star {
    label: "Count Less Than 4 Star (Overall)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [overall__how_would_you_rate_your_kasa_stay_: "<=3"]
  }

  measure: cleanliness_less_than_4_star {
    label: "Count Less Than 4 Star (Cleanliness)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_cleanliness___how_clean_was_the_kasa_when_you_arrived_: "<=3"]
  }

  measure: accuracy_less_than_4_star {
    label: "Count Less Than 4 Star (Accuracy)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_accuracy___how_did_the_kasa_compare_to_what_you_expected_: "<=3"]
  }

  measure: communication_less_than_4_star {
    label: "Count Less Than 4 Star (Communication)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_communications___how_were_your_interactions_with_the_kasa_team_: "<=3"]
  }

  measure: location_less_than_4_star {
    label: "Count Less Than 4 Star (Location)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_location___how_would_you_rate_the_surrounding_neighborhood_and_nearby_offerings_: "<=3"]
  }

  measure: checkin_less_than_4_star {
    label: "Count Less Than 4 Star (Checkin)"
    group_label: "Other Review Counts"
    type: count_distinct
    value_format: "0"
    sql: ${confirmationcode} ;;
    filters: [_check_in___how_smooth_was_your_check_in_and_arrival_process_: "<=3"]
  }

  measure: value_less_than_4_star {
    label: "Count Less Than 4 Star (Value)"
    group_label: "Other Review Counts"
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
    sql: ${cleanliness_5_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_5_star_accuracy {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_5_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_5_star_checkin {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Checkin)"
    type: number
    value_format: "0.0%"
    sql: ${checkin_5_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_5_star_communication {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Communication)"
    type: number
    value_format: "0.0%"
    sql: ${communication_5_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_5_star_location {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Location)"
    type: number
    value_format: "0.0%"
    sql: ${location_5_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_5_star_value {
    group_label: "Review Percentages"
    label: "Percent 5 Star (Value)"
    type: number
    value_format: "0.0%"
    sql: ${value_5_star} / nullif(${count_clean},0) ;;
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
    sql: ${cleanliness_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_less_than_4_star_accuracy {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Accuracy)"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_less_than_4_star_checkin {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Checkin)"
    type: number
    value_format: "0.0%"
    sql: ${checkin_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_less_than_4_star_communication {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Communication)"
    type: number
    value_format: "0.0%"
    sql: ${communication_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_less_than_4_star_location {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Location)"
    type: number
    value_format: "0.0%"
    sql: ${location_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: percent_less_than_4_star_value {
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star (Value)"
    type: number
    value_format: "0.0%"
    sql: ${value_less_than_4_star} / nullif(${count_clean},0) ;;
  }

  measure: net_quality_score_overall {
    group_label: "NQS Metrics"
    label: "NQS (Overall)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_overall} - ${percent_less_than_4_star_overall});;
  }

  measure: combined_nqs_overall {
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    group_label: "Combined NQS Metrics"
    label: "Combined NQS (Overall)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_overall}*${count},0))+(COALESCE(${airbnb_reviews.net_quality_score}*${airbnb_reviews.count},0)))/nullif((${count}+${airbnb_reviews.count}),0) ;;
  }

  measure: combined_nqs_clean {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Clean)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_cleanliness}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_clean}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }

  measure: combined_nqs_accuracy {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Accuracy)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_accuracy}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_accuracy}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }

  measure: combined_nqs_checkin {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Checkin)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_checkin}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_checkin}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }

  measure: combined_nqs_communication {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Communication)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_communication}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_communication}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }

  measure: combined_nqs_location {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Location)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_location}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_location}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }

  measure: combined_nqs_value {
    group_label: "Combined NQS Metrics"
    description: "This measure will include the combined weighted NQS from Airbnb and Postcheckout"
    label: "Combined NQS (Value)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0.0"
    sql: ((COALESCE(${net_quality_score_value}*${count_clean},0))+(COALESCE(${airbnb_reviews.net_quality_score_value}*${airbnb_reviews.count_clean},0)))/nullif((${count_clean}+${airbnb_reviews.count_clean}),0) ;;
  }


  measure: combined_count_overall {
    group_label: "Combined Review Count Metrics"
    label: "Combined Review Count (Overall)"
    description: "This measure calculates the sum of the airbnb and postcheckout reviews"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: COALESCE(${count}+${airbnb_reviews.count},0) ;;
  }

  measure: combined_count_clean {
    group_label: "Combined Review Count Metrics"
    label: "Combined Review Count (Subcategories)"
    view_label: "Combined Scores (Airbnb & Postcheckout)"
    type: number
    value_format: "0"
    sql: COALESCE(${count_clean}+${airbnb_reviews.count_clean},0) ;;
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

  measure: disappointed_percentage {
    label: "Disappointed Score"
    type: number
    value_format: "0.0"
    sql: 100*(sum(if(${how_would_you_feel_if_you_could_no_longer_stay_at_any_kasa_locations_} = "Very disappointed",1,0)) /
      NULLIF(count(${how_would_you_feel_if_you_could_no_longer_stay_at_any_kasa_locations_}),0));;
  }


  set: detail {
    fields: [

    ]
  }
}
