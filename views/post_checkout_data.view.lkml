view: post_checkout_data {
  sql_table_name: `bigquery-analytics-272822.overall_quality_score.Post_Checkout_Data`
    ;;

  dimension: building_quality___location {
    type: string
    sql: ${TABLE}.Building_quality___location ;;
  }

  dimension: check_in_experience {
    type: string
    sql: ${TABLE}.Check_in_Experience ;;
  }

  dimension: complex {
    type: string
    sql: ${TABLE}.complex ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
    primary_key: yes
  }

  dimension: covid {
    type: string
    sql: ${TABLE}.COVID ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

 # dimension: guest_communications {
 #   type: string
  #  sql: ${TABLE}.Guest_communications ;;
  #}

  #dimension: how_did_you_book_your_recent_kasa_stay_ {
  #  type: string
  #  sql: ${TABLE}.How_did_you_book_your_recent_Kasa_stay_ ;;
  #}

  #dimension: how_likely_are_you_to_recommend_kasa_to_someone_else_ {
  #  type: number
  #  sql: ${TABLE}.How_likely_are_you_to_recommend_Kasa_to_someone_else_ ;;
  #}

  #dimension: how_often_do_you_plan_to_return_to_this_location_ {
  #  type: string
  #  sql: ${TABLE}.How_often_do_you_plan_to_return_to_this_location_ ;;
  #}

  measure: disapointed_percentage {
    type: number
    value_format: "00%"
    sql: sum(if(${TABLE}.How_would_you_feel_if_you_could_no_longer_stay_at_any_Kasa_locations_ = "Very disappointed",1,0)) /
    NULLIF(count(${TABLE}.How_would_you_feel_if_you_could_no_longer_stay_at_any_Kasa_locations_),0);;
  }

  #dimension_group: month {
  #  type: time
  #  timeframes: [
  #    raw,
  #    date,
  #    week,
  #    month,
  #    quarter,
  #    year
  #  ]
  #  convert_tz: no
  #  datatype: date
  #  sql: ${TABLE}.Month ;;
  #}

  dimension: nps {
    type: string
    sql: ${TABLE}.NPS ;;
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

  measure: calc_nps {
    type: number
    value_format: "0%"
    sql: (${promotor_count}-${detractor_count})/NULLIF(count(${TABLE}.NPS),0);;
  }

  dimension: overall {
    type: string
    sql: ${TABLE}.Overall ;;
  }

  dimension: overall_numerical {
    type: number
    sql: ${TABLE}.Overall_Numerical ;;
  }

  measure: overall_numerical_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical ;;
  }

  measure: direct_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Direct"
    ]
  }

  measure: booking_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Booking.com"
    ]
  }

  measure: expedia_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Expedia"
    ]
  }

  measure: direct_oqs {
    type: number
    value_format: "0%"
    sql: (${direct_avg} - 3.115)/(4.365-3.115);;
  }

  measure: expedia_oqs {
    type: number
    value_format: "0%"
    sql: (${expedia_avg} - 3.29)/(3.89-3.29);;
  }

  measure: booking_oqs {
    type: number
    value_format: "0%"
    sql: (${booking_avg} - 3.07)/(3.97-3.07);;
  }

  measure: direct_reviews {
    type: count
    value_format: "0.00"
    filters: [
      platform_clean: "Direct"
    ]
  }

  measure: booking_reviews {
    type: count
    value_format: "0.00"
    filters: [
      platform_clean: "Booking.com"
    ]
  }

  measure: expedia_reviews {
    type: count
    value_format: "0.00"
    filters: [
      platform_clean: "Expedia"
    ]
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: platform_clean {
    type: string
    sql: ${TABLE}.Platform_Clean ;;
  }

  dimension: prop_code {
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  #dimension: property {
  #  type: string
  #  sql: ${TABLE}.property ;;
  #}

  #dimension: reservationid {
  #  type: string
  #  sql: ${TABLE}.reservationid ;;
  #}

  dimension: room_quality___cleanliness {
    type: string
    sql: ${TABLE}.Room_quality___cleanliness ;;
  }

  dimension_group: review {
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
  }

  dimension: token {
    type: string
    sql: ${TABLE}.Token ;;
  }

  dimension: trip_type {
    type: string
    sql: ${TABLE}.Trip_Type ;;
  }

  #dimension: unitid {
  #  type: string
  #  sql: ${TABLE}.unitid ;;
  #}

  dimension: unitinternaltitle {
    type: string
    sql: ${TABLE}.unitinternaltitle ;;
  }

  #dimension: unitname {
  #  type: string
  #  sql: ${TABLE}.unitname ;;
  #}

  #dimension: we_love_feedback__is_there_anything_else_you_d_like_to_tell_us__ {
  #  type: string
  #  sql: ${TABLE}.We_love_feedback__Is_there_anything_else_you_d_like_to_tell_us__ ;;
  #}

  dimension: week_num {
    type: number
    sql: ${TABLE}.WeekNum ;;
  }

  #dimension: what_best_describes_the_nature_of_your_trip_ {
  #  type: string
  #  sql: ${TABLE}.What_best_describes_the_nature_of_your_trip_ ;;
  #}

  #dimension: what_best_describes_your_travel_party_ {
  #  type: string
  #  sql: ${TABLE}.What_best_describes_your_travel_party_ ;;
  #}

  #dimension: what_is_one_suggestion_for_improving_the_kasa_experience_ {
  #  type: string
  #  sql: ${TABLE}.What_is_one_suggestion_for_improving_the_Kasa_experience_ ;;
  #}

  #dimension: what_is_one_thing_you_loved_about_the_kasa_experience_ {
  #  type: string
  #  sql: ${TABLE}.What_is_one_thing_you_loved_about_the_Kasa_experience_ ;;
  #}

  #dimension: where_else_would_you_like_to_see_kasa_open_up_units__ {
  #  type: string
  #  sql: ${TABLE}.Where_else_would_you_like_to_see_Kasa_open_up_units__ ;;
  #}

  #dimension: where_else_would_you_like_to_see_kasa_open_up_units__v2 {
  #  type: string
  #  sql: ${TABLE}.Where_else_would_you_like_to_see_Kasa_open_up_units__v2 ;;
  #}

  #dimension: why_did_you_choose_to_stay_at_this_particular_property_ {
  #  type: string
  #  sql: ${TABLE}.Why_did_you_choose_to_stay_at_this_particular_property_ ;;
  #}

  measure: count {
    type: count
    drill_fields: []
  }
}
