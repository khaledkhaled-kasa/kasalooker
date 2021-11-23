  view: post_checkout_data {
    derived_table: {
      sql:   SELECT *
          FROM `bigquery-analytics-272822.overall_quality_score.Post_Checkout_Data`
       ;;
      persist_for: "24 hours"
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

  dimension: overall_feedback {
    type: string
    sql: ${TABLE}.We_love_feedback__Is_there_anything_else_you_d_like_to_tell_us__  ;;
  }

    dimension: suggestion {
      type: string
      sql: ${TABLE}.What_is_one_suggestion_for_improving_the_Kasa_experience_  ;;
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
      day_of_week,
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

    measure: overall_count_5_star {
      label: "Count 5 Star (Overall)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [overall_quant: "5"]
    }

    measure: cleanliness_5_star {
      label: "Count 5 Star (Cleanliness)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [cleanliness: "5"]
    }


    measure: communication_5_star {
      label: "Count 5 Star (Communication)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [communication: "5"]
    }

    measure: location_5_star {
      label: "Count 5 Star (Location)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [location: "5"]
    }

    measure: checkin_5_star {
      label: "Count 5 Star (Checkin)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [checkin: "5"]
    }

    measure: overall_count_4_star {
      label: "Count 4 Star (Overall)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [overall_quant: "4"]
    }

    measure: cleanliness_4_star {
      label: "Count 4 Star (Cleanliness)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [cleanliness: "4"]
    }


    measure: communication_4_star {
      label: "Count 4 Star (Communication)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [communication: "4"]
    }

    measure: location_4_star {
      label: "Count 4 Star (Location)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [location: "4"]
    }

    measure: checkin_4_star {
      label: "Count 4 Star (Checkin)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [checkin: "4"]
    }


    measure: overall_count_less_than_4_star {
      label: "Count Less Than 4 Star (Overall)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [overall_quant: "<=3"]
    }

    measure: cleanliness_less_than_4_star {
      label: "Count Less Than 4 Star (Cleanliness)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [cleanliness: "<=3"]
    }


    measure: communication_less_than_4_star {
      label: "Count Less Than 4 Star (Communication)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [communication: "<=3"]
    }

    measure: location_less_than_4_star {
      label: "Count Less Than 4 Star (Location)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [location: "<=3"]
    }

    measure: checkin_less_than_4_star {
      label: "Count Less Than 4 Star (Checkin)"
      group_label: "Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${confirmationcode} ;;
      filters: [checkin: "<=3"]
    }


    measure: percent_5_star_overall {
      group_label: "Review Percentages"
      label: "Percent 5 Star (Overall)"
      type: number
      value_format: "0.0%"
      sql: ${overall_count_5_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_5_star_cleanliness {
      group_label: "Review Percentages"
      label: "Percent 5 Star (Cleanliness)"
      type: number
      value_format: "0.0%"
      sql: ${cleanliness_5_star} / nullif(${count_reviews},0) ;;
    }


    measure: percent_5_star_checkin {
      group_label: "Review Percentages"
      label: "Percent 5 Star (Checkin)"
      type: number
      value_format: "0.0%"
      sql: ${checkin_5_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_5_star_communication {
      group_label: "Review Percentages"
      label: "Percent 5 Star (Communication)"
      type: number
      value_format: "0.0%"
      sql: ${communication_5_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_5_star_location {
      group_label: "Review Percentages"
      label: "Percent 5 Star (Location)"
      type: number
      value_format: "0.0%"
      sql: ${location_5_star} / nullif(${count_reviews},0) ;;
    }


    measure: percent_less_than_4_star_overall {
      group_label: "Review Percentages"
      label: "Percent Less Than 4 Star (Overall)"
      type: number
      value_format: "0.0%"
      sql: ${overall_count_less_than_4_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_less_than_4_star_cleanliness {
      group_label: "Review Percentages"
      label: "Percent Less Than 4 Star (Cleanliness)"
      type: number
      value_format: "0.0%"
      sql: ${cleanliness_less_than_4_star} / nullif(${count_reviews},0) ;;
    }



    measure: percent_less_than_4_star_checkin {
      group_label: "Review Percentages"
      label: "Percent Less Than 4 Star (Checkin)"
      type: number
      value_format: "0.0%"
      sql: ${checkin_less_than_4_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_less_than_4_star_communication {
      group_label: "Review Percentages"
      label: "Percent Less Than 4 Star (Communication)"
      type: number
      value_format: "0.0%"
      sql: ${communication_less_than_4_star} / nullif(${count_reviews},0) ;;
    }

    measure: percent_less_than_4_star_location {
      group_label: "Review Percentages"
      label: "Percent Less Than 4 Star (Location)"
      type: number
      value_format: "0.0%"
      sql: ${location_less_than_4_star} / nullif(${count_reviews},0) ;;
    }


    measure: net_quality_score_overall {
      group_label: "NQS Metrics"
      label: "NQS (Overall)"
      type: number
      value_format: "0.0"
      sql: 100*(${percent_5_star_overall} - ${percent_less_than_4_star_overall});;
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





}
