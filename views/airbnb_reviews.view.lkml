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
    type: string
    sql: ${TABLE}.Accuracy_Comments ;;
  }

   measure: accuracy_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: checkin_comments {
    type: string
    sql: ${TABLE}.Checkin_Comments ;;
  }

   measure: checkin_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Checkin_Rating ;;
  }


  dimension: cleanliness_comments {
    type: string
    sql: ${TABLE}.Cleanliness_Comments ;;
  }

  measure: cleanliness_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: communication_comments {
    type: string
    sql: ${TABLE}.Communication_Comments ;;
  }

  measure: communication_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension_group: ds_checkin {
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
    sql: ${TABLE}.ds_checkin ;;
  }

  dimension_group: ds_checkout {
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
    type: string
    sql: ${TABLE}.Location_Comments ;;
  }

  measure: location_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Location_Rating ;;
  }

  dimension: overall_comments {
    type: string
    sql: ${TABLE}.Overall_Comments ;;
  }

  measure: overall_rating_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: overall_rating {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: cleanliness_rating_dim {
    type: number
    hidden: yes
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: reservation_code {
    type: string
    sql: ${TABLE}.Reservation_Code ;;
    primary_key: yes
  }

  dimension_group: review {
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
    type: string
    sql: ${TABLE}.Value_Comments ;;
  }

  measure: value_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Value_Rating ;;
  }

  measure: overall_quality_score {
    type: number
    value_format: "0%"
    sql: (${overall_rating_avg} - 4.535)/(4.825 - 4.535) ;;
  }

  measure: overall_quality_score_accuracy {
    type: number
    value_format: "0%"
    sql: (${accuracy_rating} - 4.761)/(4.901 - 4.761) ;;
  }

  measure: overall_quality_score_cleanliness {
    type: number
    value_format: "0%"
    sql: (${cleanliness_rating} - 4.66)/(4.855 - 4.66) ;;
  }

  measure: overall_quality_score_communication {
    type: number
    value_format: "0%"
    sql: (${communication_rating} - 4.681)/(4.848 - 4.681) ;;
  }

  measure: overall_quality_score_checkin_rating {
    type: number
    value_format: "0%"
    sql: (${checkin_rating} - 4.482)/(4.729 - 4.482) ;;
  }

  measure: overall_quality_score_value {
    type: number
    value_format: "0%"
    sql: (${value_rating} - 4.614)/(4.783 - 4.614) ;;
  }

  measure: overall_quality_score_location {
    type: number
    value_format: "0%"
    sql: (${location_rating} - 4.799)/(4.871 - 4.799) ;;
  }

  measure: count_5_star {
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "5"
    ]
  }

  measure: count_less_than_4_star {
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
    overall_rating: "<=3"
  ]
}

  measure: percent_5_star {
    type: number
    value_format: "0.0%"
    sql: ${count_5_star} / ${count} ;;
  }

  measure: percent_less_than_4_star {
    type: number
    value_format: "0.0%"
    sql: ${count_less_than_4_star} / ${count};;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.Reservation_Code ;;
  }

  measure: clean_count_less_than_4_star {
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      cleanliness_rating_dim: "<=3"
    ]
  }

  measure: count_clean {
    type: count_distinct
    label: "Count Reviews (6 Ratings besides Overall)"
    sql: ${TABLE}.Reservation_Code ;;
    filters: [
      cleanliness_rating_dim: "1,2,3,4,5"
    ]
  }



  measure: percent_less_than_4_star_clean {
    type: number
    value_format: "0.0%"
    sql: ${clean_count_less_than_4_star} / ${count_clean};;
  }

}
