view: airbnb_reviews {
  sql_table_name: `bigquery-analytics-272822.airbnb_review_master.Airbnb_Reviews`
    ;;

  dimension: first_45 {
    hidden: no
    type: string
    sql: CASE WHEN ${airbnb_reviews.review_date} >= ${units.availability_startdate}
          AND
          ${airbnb_reviews.review_date} <= ${units.availability_startdate_45day_mark}
          THEN "First 45 Days"
          ELSE "Other Properties"
          END;;
  }

  dimension: accuracy_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Accuracy_Comments ;;
  }

   measure: accuracy_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: checkin_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Checkin_Comments ;;
  }

   measure: checkin_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Checkin_Rating ;;
  }


  dimension: cleanliness_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Cleanliness_Comments ;;
  }

  measure: cleanliness_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: communication_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Communication_Comments ;;
  }

  measure: communication_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension_group: ds_checkin {
    type: time
    group_label: "Airbnb Check-in Date"
    view_label: "Date Dimensions"
    label: "Airbnb Checkin"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ds_checkin ;;
  }

  dimension_group: ds_checkout {
    type: time
    group_label: "Airbnb Check-out Date"
    view_label: "Date Dimensions"
    label: "Airbnb Checkout"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ds_checkout ;;
  }

  dimension: host_id {
    type: number
    sql: ${TABLE}.Host_ID ;;
  }

  dimension: listing_id {
    type: number
    sql: ${TABLE}.Listing_ID ;;
  }

  dimension: location_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Location_Comments ;;
  }

  measure: location_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Location_Rating ;;
  }

  dimension: overall_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Overall_Comments ;;
  }

  measure: overall_rating_avg {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    label: "Overall Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: overall_rating {
    group_label: "Ratings (Non-Aggregated)"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: accuracy_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Accuracy Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: value_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Value Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Value_Rating ;;
  }

  dimension: location_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Locatin Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Location_Rating ;;
  }

  dimension: cleanliness_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Cleanliness Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: checkin_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Checkin Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Checkin_Rating ;;
  }

  dimension: communication_rating_dim {
    group_label: "Ratings (Non-Aggregated)"
    label: "Communication Rating"
    type: number
    hidden: no
    value_format: "0.00"
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension: reservation_code {
    type: string
    hidden: yes
    sql: ${TABLE}.Reservation_Code ;;
    primary_key: yes
  }

  dimension_group: review {
    group_label: "Airbnb Review Date"
    view_label: "Date Dimensions"
    label: "Airbnb Review"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Review_Date ;;
  }


  dimension: value_comments {
    group_label: "Airbnb Comments"
    type: string
    sql: ${TABLE}.Value_Comments ;;
  }

  measure: value_rating {
    view_label: "Metrics"
    group_label: "Airbnb Rating Metrics"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Value_Rating ;;
  }

  measure: overall_quality_score {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    label: "Airbnb OQS"
    type: number
    value_format: "0%"
    sql: (${overall_rating_avg} - 4.535)/(4.825 - 4.535) ;;
  }

  measure: overall_quality_score_accuracy {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${accuracy_rating} - 4.761)/(4.901 - 4.761) ;;
  }

  measure: overall_quality_score_cleanliness {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${cleanliness_rating} - 4.66)/(4.855 - 4.66) ;;
  }

  measure: overall_quality_score_communication {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${communication_rating} - 4.681)/(4.848 - 4.681) ;;
  }

  measure: overall_quality_score_checkin_rating {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${checkin_rating} - 4.482)/(4.729 - 4.482) ;;
  }

  measure: overall_quality_score_value {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${value_rating} - 4.614)/(4.783 - 4.614) ;;
  }

  measure: overall_quality_score_location {
    view_label: "Metrics"
    group_label: "Airbnb OQS Metrics"
    type: number
    value_format: "0%"
    sql: (${location_rating} - 4.799)/(4.871 - 4.799) ;;
  }

  measure: count_5_star {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "5"
    ]
  }


  measure: count_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    hidden: no
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "4"
    ]
  }

  measure: count_3_star {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    hidden: no
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "3"
    ]
  }

  measure: count_2_star {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    hidden: no
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "2"
    ]
  }

  measure: count_1_star {
    view_label: "Metrics"
    type: count_distinct
    group_label: "Airbnb Metrics"
    hidden: no
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "1"
    ]
  }

  measure: count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Overall "
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
    overall_rating: "<=3"
  ]
}

  measure: count_perfect_stay {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [overall_rating: "5", cleanliness_rating_dim: "5", accuracy_rating_dim: "5", checkin_rating_dim: "5", communication_rating_dim: "5", location_rating_dim: "5", value_rating_dim: "5"]
  }

  measure: percent_5_star {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: number
    value_format: "0.0%"
    sql: ${count_5_star} / nullif(${count},0) ;;
  }

  measure: percent_perfect_stay {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: number
    value_format: "0.0%"
    sql: ${count_perfect_stay} / nullif(${count},0);;
  }

  measure: percent_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Percent Less Than 4 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_less_than_4_star} / nullif(${count},0);;
  }

  measure: percent_3_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${count_3_star} / ${count};;
  }

  measure: percent_2_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${count_2_star} / ${count};;
  }

  measure: percent_1_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${count_1_star} / ${count};;
  }

  measure: count {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    label: "Airbnb Review Count"
    type: count_distinct
    sql: ${TABLE}.Reservation_Code ;;
  }


  measure: clean_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Clean"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      cleanliness_rating_dim: "<=3"
    ]
  }

  measure: accuracy_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Accuracy"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      accuracy_rating_dim: "<=3"
    ]
  }

  measure: value_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Value"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      value_rating_dim: "<=3"
    ]
  }

  measure: location_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Location"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      location_rating_dim: "<=3"
    ]
  }

  measure: communication_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Communication"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      communication_rating_dim: "<=3"
    ]
  }

  measure: checkin_count_less_than_4_star {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    label: "Count Less Than 4 Star Checkin"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      checkin_rating_dim: "<=3"
    ]
  }

  measure: count_clean {
    view_label: "Metrics"
    group_label: "Airbnb Metrics"
    type: count_distinct
    label: "Count Reviews (6 Ratings besides Overall)"
    sql: ${TABLE}.Reservation_Code ;;
    filters: [
      cleanliness_rating_dim: "1,2,3,4,5"
    ]
  }


  measure: percent_less_than_4_star_clean {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${clean_count_less_than_4_star} / ${count_clean};;
  }

  measure: percent_less_than_4_star_accuracy {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_count_less_than_4_star} / ${count_clean};;
  }

  measure: percent_less_than_4_star_location {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${location_count_less_than_4_star} / ${count_clean};;
  }

  measure: percent_less_than_4_star_value {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${value_count_less_than_4_star} / ${count_clean};;
  }

  measure: percent_less_than_4_star_communication {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${communication_count_less_than_4_star} / ${count_clean};;
  }

  measure: percent_less_than_4_star_checkin {
    view_label: "Metrics"
    group_label: "Airbnb Bad Stay Metrics"
    type: number
    value_format: "0.0%"
    sql: ${checkin_count_less_than_4_star} / ${count_clean};;
  }

}
