  view: post_checkout_data {
    derived_table: {
      sql:   SELECT *
          FROM `bigquery-analytics-272822.overall_quality_score.Post_Checkout_Data`
       ;;
      persist_for: "6 hours"
    }


  dimension: confirmationcode {
    label: "Confirmation Code"
    type: string
    sql: ${TABLE}.confirmationcode ;;
    primary_key: yes
  }

  dimension: building_quality___location {
    label: "Building Location Quality"
    type: string
    sql: ${TABLE}.Building_quality___location ;;
  }

    dimension: location {
      group_label: "Ratings (Quantitative)"
      type: number
      sql: CASE
      WHEN ${TABLE}.Building_quality___location = 'Did not meet expectations' THEN 1
      WHEN ${TABLE}.Building_quality___location = 'Met some expectations' THEN 2
      WHEN ${TABLE}.Building_quality___location = 'Met expectations' THEN 3
      WHEN ${TABLE}.Building_quality___location = 'Greatly exceeded expectations' THEN 5
      WHEN ${TABLE}.Building_quality___location = 'Exceeded expectations' THEN 4
      ELSE NULL
      END
      ;;

    }

    dimension: checkin {
      group_label: "Ratings (Quantitative)"
      type: number
      sql: CASE
              WHEN ${TABLE}.check_in_experience = 'Did not meet expectations' THEN 1
              WHEN ${TABLE}.check_in_experience = 'Met some expectations' THEN 2
              WHEN ${TABLE}.check_in_experience = 'Met expectations' THEN 3
              WHEN ${TABLE}.check_in_experience = 'Greatly exceeded expectations' THEN 5
              WHEN ${TABLE}.check_in_experience = 'Exceeded expectations' THEN 4
              ELSE NULL
              END
              ;;

      }

    dimension: communication {
      group_label: "Ratings (Quantitative)"
      type: number
      sql: CASE
              WHEN ${TABLE}.Guest_communications = 'Did not meet expectations' THEN 1
              WHEN ${TABLE}.Guest_communications = 'Met some expectations' THEN 2
              WHEN ${TABLE}.Guest_communications = 'Met expectations' THEN 3
              WHEN ${TABLE}.Guest_communications = 'Greatly exceeded expectations' THEN 5
              WHEN ${TABLE}.Guest_communications = 'Exceeded expectations' THEN 4
              ELSE NULL
              END
              ;;

      }

    dimension: overall_quant {
      group_label: "Ratings (Quantitative)"
      label: "Overall"
      type: number
      sql: CASE
              WHEN ${TABLE}.Overall = 'Did not meet expectations' THEN 1
              WHEN ${TABLE}.Overall = 'Met some expectations' THEN 2
              WHEN ${TABLE}.Overall = 'Met expectations' THEN 3
              WHEN ${TABLE}.Overall = 'Greatly exceeded expectations' THEN 5
              WHEN ${TABLE}.Overall = 'Exceeded expectations' THEN 4
              ELSE NULL
              END
              ;;

      }

    dimension: cleanliness {
      group_label: "Ratings (Quantitative)"
      type: number
      sql: CASE
              WHEN ${TABLE}.Room_quality___cleanliness = 'Did not meet expectations' THEN 1
              WHEN ${TABLE}.Room_quality___cleanliness = 'Met some expectations' THEN 2
              WHEN ${TABLE}.Room_quality___cleanliness = 'Met expectations' THEN 3
              WHEN ${TABLE}.Room_quality___cleanliness = 'Greatly exceeded expectations' THEN 5
              WHEN ${TABLE}.Room_quality___cleanliness = 'Exceeded expectations' THEN 4
              ELSE NULL
              END
              ;;

      }

  dimension: check_in_experience {
    type: string
    sql: ${TABLE}.Check_in_Experience ;;
  }

  dimension: complex {
    type: string
    sql: ${TABLE}.complex ;;
  }

  dimension: covid {
    type: string
    sql: ${TABLE}.COVID ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: guest_communications {
    label: "Guest Communications Experience"
    type: string
    sql: ${TABLE}.Guest_communications ;;
  }

  dimension: how_did_you_book_your_recent_kasa_stay_ {
    type: string
    sql: ${TABLE}.How_did_you_book_your_recent_Kasa_stay_ ;;
  }

  dimension: how_likely_are_you_to_recommend_kasa_to_someone_else_ {
    label: "Likely To Recommend"
    type: number
    sql: ${TABLE}.How_likely_are_you_to_recommend_Kasa_to_someone_else_ ;;
  }

  dimension: how_often_do_you_plan_to_return_to_this_location_ {
    label: "Plan to Return"
    type: string
    sql: ${TABLE}.How_often_do_you_plan_to_return_to_this_location_ ;;
  }

  dimension: NPS {
    type: string
    sql: ${TABLE}.NPS ;;
  }

  dimension: overall {
    type: string
    hidden: yes
    sql: ${TABLE}.Overall ;;
  }

  dimension: overall_numerical {
    label: "Overall Score"
    type: number
    sql: ${TABLE}.Overall_Numerical ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: platform_clean {
    label: "Platform"
    type: string
    sql: ${TABLE}.Platform_Clean ;;
  }

  dimension: prop_code {
    label: "Property Code"
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: room_quality___cleanliness {
    label: "Room Quality/Cleanliness"
    type: string
    sql: ${TABLE}.Room_quality___cleanliness ;;
  }

  dimension_group: review {
    label: "Review"
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
    hidden: yes
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

  dimension: unit_internal_title {
    type: string
    sql: ${TABLE}.unitinternaltitle ;;
  }

  dimension: week_num {
    type: number
    hidden: yes
    sql: ${TABLE}.WeekNum ;;
  }

  measure: disappointed_percentage {
    label: "Disappointed Score"
    type: number
    value_format: "0.0"
    sql: 100*(sum(if(${TABLE}.How_would_you_feel_if_you_could_no_longer_stay_at_any_Kasa_locations_ = "Very disappointed",1,0)) /
    NULLIF(count(${TABLE}.How_would_you_feel_if_you_could_no_longer_stay_at_any_Kasa_locations_),0));;
  }

  measure: promotor_count {
    type: count
    value_format: "0"
    filters: [
      NPS: "Promoter"
    ]
  }

  measure: detractor_count {
    type: count
    value_format: "0"
    filters: [
      NPS: "Detractor"
    ]
  }

  measure: calc_nps {
    label: "NPS"
    type: number
    value_format: "0.0"
    sql: 100*((${promotor_count}-${detractor_count})/NULLIF(count(${TABLE}.NPS),0));;
  }

  measure: avg_overall_numerical {
    group_label: "Ratings (Aggregate)"
    label: "Average Overall Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical ;;
  }

  measure: avg_direct {
    group_label: "Ratings (Aggregate)"
    label: "Average Direct Booking Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Direct"
    ]
  }

  measure: avg_booking {
    group_label: "Ratings (Aggregate)"
    label: "Average Booking.com Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Booking.com"
    ]
  }

  measure: expedia_avg {
    group_label: "Ratings (Aggregate)"
    label: "Average Expedia Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Numerical;;
    filters: [
      platform_clean: "Expedia"
    ]
  }

  measure: direct_oqs {
    group_label: "OQS Metrics"
    label: "Direct OQS"
    type: number
    value_format: "0%"
    sql: (${avg_direct} - 3.115)/(4.365-3.115);;
  }

  measure: expedia_oqs {
    group_label: "OQS Metrics"
    label: "Expedia OQS"
    type: number
    value_format: "0%"
    sql: (${expedia_avg} - 3.29)/(3.89-3.29);;
  }

  measure: booking_oqs {
    group_label: "OQS Metrics"
    label: "Booking OQS"
    type: number
    value_format: "0%"
    sql: (${avg_booking} - 3.07)/(3.97-3.07);;
  }

  measure: count_direct_reviews {
    group_label: "Review Counts"
    label: "Direct Booking Review Count"
    type: count
    value_format: "0"
    filters: [
      platform_clean: "Direct"
    ]
  }

  measure: count_booking_reviews {
    group_label: "Review Counts"
    label: "Booking.com Review Count"
    type: count
    value_format: "0"
    filters: [
      platform_clean: "Booking.com"
    ]
  }

  measure: count_expedia_reviews {
    group_label: "Review Counts"
    label: "Expedia Review Count"
    type: count
    value_format: "0"
    filters: [
      platform_clean: "Expedia"
    ]
  }

    measure: count_reviews {
      group_label: "Review Counts"
      type: count_distinct
      sql: ${confirmationcode} ;;
      value_format: "0"
    }


    measure: overall_measure {
      label: "Average Overall Rating"
      group_label: "Ratings (Aggregated)"
      type: average
      value_format: "0.00"
      sql: ${overall_quant} ;;
    }

    measure: cleanliness_measure {
      label: "Average Cleanliness Rating"
      group_label: "Ratings (Aggregated)"
      type: average
      value_format: "0.00"
      sql: ${cleanliness} ;;
    }


    measure: communication_measure {
      label: "Average Communication Rating"
      group_label: "Ratings (Aggregated)"
      type: average
      value_format: "0.00"
      sql: ${communication} ;;
    }

    measure: location_measure {
      label: "Average Location Rating"
      group_label: "Ratings (Aggregated)"
      type: average
      value_format: "0.00"
      sql: ${location} ;;
    }

    measure: checkin_measure {
      label: "Average Checkin Rating"
      group_label: "Ratings (Aggregated)"
      type: average
      value_format: "0.00"
      sql: ${checkin} ;;
    }



}
