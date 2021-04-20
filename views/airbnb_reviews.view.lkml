view: airbnb_reviews {
  derived_table: {
    sql:  SELECT *
          FROM `bigquery-analytics-272822.airbnb_review_master.Airbnb_Reviews`;;

  #datagroup_trigger: reviews_default_datagroup
  persist_for: "6 hours"
  }

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
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Accuracy_Comments ;;
  }

  dimension: checkin_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Checkin_Comments ;;
  }

  dimension: cleanliness_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Cleanliness_Comments ;;
  }

  dimension: communication_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Communication_Comments ;;
  }

  dimension: location_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Location_Comments ;;
  }

  dimension: overall_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Overall_Comments ;;
  }

  dimension: value_comments {
    group_label: "Comments"
    type: string
    sql: ${TABLE}.Value_Comments ;;
  }


  dimension_group: reservation_checkin {
    type: time
    timeframes: [raw, time, date, week, month, year, quarter]
    label: "Reservation Check-In"
    sql: timestamp(${reservations_clean.checkindate_time}) ;;
    convert_tz: no
  }

  dimension_group: reservation_checkout {
    label: "Reservation Check-Out"
    type: time
    timeframes: [raw, time, date, week, month, year, quarter]
    sql: timestamp(${reservations_clean.checkoutdate_time}) ;;
    convert_tz: no
  }

  dimension_group: ds_checkin {
    hidden: yes
    type: time
    label: "Checkin"
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
    hidden: yes
    type: time
    #group_label: "Airbnb Check-out Date"
    #view_label: "Date Dimensions"
    label: "Checkout"
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

  dimension: overall_rating {
    group_label: "Ratings"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: accuracy_rating {
    group_label: "Ratings"
    label: "Accuracy Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: value_rating {
    group_label: "Ratings"
    label: "Value Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Value_Rating ;;
  }

  dimension: location_rating {
    group_label: "Ratings"
    label: "Locatin Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Location_Rating ;;
  }

  dimension: cleanliness_rating {
    group_label: "Ratings"
    label: "Cleanliness Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: checkin_rating {
    group_label: "Ratings"
    label: "Checkin Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Checkin_Rating ;;
  }

  dimension: communication_rating {
    group_label: "Ratings"
    label: "Communication Rating"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension: reservation_code {
    type: string
    #hidden: yes
    sql: ${TABLE}.Reservation_Code ;;
    primary_key: yes
  }

  dimension_group: review {
    #group_label: "Airbnb Review Date"
    #view_label: "Date Dimensions"
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

  measure: avg_location_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Location Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Location_Rating ;;
  }

  measure: avg_overall_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Overall Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  measure: avg_value_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Value Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Value_Rating ;;
  }

  measure: avg_accuracy_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Accuracy Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  measure: overall_quality_score {
    #view_label: "Metrics"
    #group_label: "OQS Metrics"
    label: "Airbnb OQS"
    type: number
    value_format: "0%"
    sql: (${avg_overall_rating} - 4.535)/(4.825 - 4.535) ;;
  }


  measure: avg_checkin_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Checkin Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Checkin_Rating ;;
  }

  measure: avg_cleanliness_rating {
    group_label: "Ratings (Aggregated)"
    label: "Average Cleanliness Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  # measure: overall_quality_score_accuracy {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${accuracy_rating} - 4.761)/(4.901 - 4.761) ;;
  # }

  # measure: overall_quality_score_cleanliness {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${cleanliness_rating} - 4.66)/(4.855 - 4.66) ;;
  # }

  # measure: overall_quality_score_communication {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${communication_rating} - 4.681)/(4.848 - 4.681) ;;
  # }

  # measure: overall_quality_score_checkin_rating {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${checkin_rating} - 4.482)/(4.729 - 4.482) ;;
  # }

  # measure: overall_quality_score_value {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${value_rating} - 4.614)/(4.783 - 4.614) ;;
  # }

  # measure: overall_quality_score_location {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb OQS Metrics"
  #   type: number
  #   value_format: "0%"
  #   sql: (${location_rating} - 4.799)/(4.871 - 4.799) ;;
  # }

  measure: count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Overall"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "5"
    ]
  }

  measure: count_promoter {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "# of Perfect Stays (Promoters)"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "5"
    ]
  }


  measure: count_4_star {
    group_label: "Review Counts"
    label: "Count 4 Star Overall"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "4"
    ]
  }

  measure: count_3_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 3 Star Overall"
    type: count_distinct
    hidden: no
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "3"
    ]
  }

  measure: count_2_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 2 Star Overall"
    type: count_distinct
    hidden: no
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "2"
    ]
  }

  measure: count_1_star {
    #view_label: "Metrics"
    type: count_distinct
    group_label: "Review Counts"
    label: "Count 1 Star Overall"
    hidden: no
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      overall_rating: "1"
    ]
  }

  measure: count_less_than_4_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Overall "
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
    overall_rating: "<=3"
  ]
}

  measure: count_detractor {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "# of Bad Stays (Detractors)"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      overall_rating: "<=3"
    ]
  }

## This will calculate perfect stays when all categories are 5
  # measure: count_perfect_stay {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb Metrics"
  #   type: count_distinct
  #   value_format: "0"
  #   sql: ${TABLE}.Reservation_Code;;
  #   filters: [overall_rating: "5", cleanliness_rating_dim: "5", accuracy_rating_dim: "5", checkin_rating_dim: "5", communication_rating_dim: "5", location_rating_dim: "5", value_rating_dim: "5"]
  # }

    # measure: percent_perfect_stay {
  #  #view_label: "Metrics"
  #  #group_label: "Airbnb Metrics"
  #   type: number
  #   value_format: "0.0%"
  #   sql: ${count_perfect_stay} / nullif(${count},0);;
  # }


  measure: percent_5_star {
    #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent 5 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_5_star} / nullif(${count},0) ;;
  }


  measure: net_quality_score {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "Net Quality Score (NQS)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_perfect_stay} - ${percent_bad_stay});;
    drill_fields: [airbnb_details*]
  }

  measure: net_quality_score_accuracy {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Accuracy)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_accuracy} - ${percent_less_than_4_star_accuracy});;
    drill_fields: [airbnb_details*]
  }

  measure: net_quality_score_value{
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Value)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_value} - ${percent_less_than_4_star_value});;
  }

  measure: net_quality_score_location {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Location)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_location} - ${percent_less_than_4_star_location});;
  }

  measure: net_quality_score_checkin {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Checkin)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_checkin} - ${percent_less_than_4_star_checkin});;
  }

  measure: net_quality_score_clean {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Clean)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_clean} - ${percent_less_than_4_star_clean});;
  }

  measure: net_quality_score_communication {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    label: "NQS (Communication)"
    type: number
    value_format: "0.0"
    sql: 100*(${percent_5_star_communication} - ${percent_less_than_4_star_communication});;
  }


  measure: percent_perfect_stay{
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    description: "This is the same as % 5 star (overall)"
    label: "% Perfect Stays (Promoters)"
    type: number
    value_format: "0.0%"
    sql: ${count_5_star} / nullif(${count},0) ;;
  }


  measure: percent_bad_stay {
    #view_label: "Metrics"
    group_label: "NQS Metrics"
    description: "This is the same as % less than 4 star"
    label: "% Bad Stays (Detractors)"
    type: number
    value_format: "0.0%"
    sql: ${count_less_than_4_star} / nullif(${count},0);;
  }

  measure: percent_less_than_4_star {
    #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent Less Than 4 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_less_than_4_star} / nullif(${count},0);;
  }

  measure: percent_3_star {
    #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent 3 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_3_star} / nullif(${count},0);;
  }

  measure: percent_2_star {
    #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent 2 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_2_star} / nullif(${count},0);;
  }

  measure: percent_1_star {
    #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent 1 Star Overall"
    type: number
    value_format: "0.0%"
    sql: ${count_1_star} / nullif(${count},0);;
  }

  measure: count {
    #view_label: "Metrics"
    #group_label: "Airbnb Count Metrics"
    description: "This will take the count of all reviews which had an overall rating (Higher than subcategory review count)"
    type: count_distinct
    sql: ${reservation_code} ;;
  }

  measure: clean_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Clean"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      cleanliness_rating: "5"
    ]
  }

  measure: accuracy_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Accuracy"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      accuracy_rating: "5"
    ]
  }

  measure: accuracy_count_4_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 4 Star Accuracy"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      accuracy_rating: "4"
    ]
  }

  measure: value_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Value"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      value_rating: "5"
    ]
  }

  measure: location_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Location"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      location_rating: "5"
    ]
  }

  measure: communication_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Communication"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      communication_rating: "5"
    ]
  }

  measure: checkin_count_5_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count 5 Star Checkin"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      checkin_rating: "5"
    ]
  }

  measure: clean_count_less_than_4_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Clean"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      cleanliness_rating: "<=3"
    ]
  }

  measure: accuracy_count_less_than_4_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Accuracy"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      accuracy_rating: "<=3"
    ]
  }

  measure: value_count_less_than_4_star {
    #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Value"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      value_rating: "<=3"
    ]
  }

  measure: location_count_less_than_4_star {
   #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Location"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.Reservation_Code;;
    filters: [
      location_rating: "<=3"
    ]
  }

  measure: communication_count_less_than_4_star {
   #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Communication"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      communication_rating: "<=3"
    ]
  }

  measure: checkin_count_less_than_4_star {
   #view_label: "Metrics"
    group_label: "Review Counts"
    label: "Count Less Than 4 Star Checkin"
    type: count_distinct
    value_format: "0"
    sql: ${reservation_code};;
    filters: [
      checkin_rating: "<=3"
    ]
  }

  measure: count_clean {
   #view_label: "Metrics"
    group_label: "Review Counts"
    type: count_distinct
    label: "Count Reviews (Subcategories)"
    sql: ${reservation_code} ;;
    filters: [
      cleanliness_rating: "1,2,3,4,5"
    ]
  }


  measure: percent_less_than_4_star_clean {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${clean_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_less_than_4_star_accuracy {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_less_than_4_star_location {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${location_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_less_than_4_star_value {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${value_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_less_than_4_star_communication {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${communication_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_less_than_4_star_checkin {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${checkin_count_less_than_4_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_clean {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${clean_count_5_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_value {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${value_count_5_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_location {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${location_count_5_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_communication {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${communication_count_5_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_checkin {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${checkin_count_5_star} / nullif(${count_clean},0);;
  }

  measure: percent_5_star_accuracy {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: ${accuracy_count_5_star} / nullif(${count_clean},0);;
  }

  measure: avg_communication_rating {
    #view_label: "Metrics"
    group_label: "Ratings (Aggregated)"
    label: "Average Communication Rating"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Communication_Rating ;;
  }

  measure: percent_4_star_clean {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_clean} + ${percent_less_than_4_star_clean});;
  }

  measure: percent_4_star_value {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_value} + ${percent_less_than_4_star_value});;
  }

  measure: percent_4_star_location {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_location} + ${percent_less_than_4_star_location});;
  }

  measure: percent_4_star_communication {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_communication} + ${percent_less_than_4_star_communication});;
  }

  measure: percent_4_star_checkin {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_checkin} + ${percent_less_than_4_star_checkin});;
  }

  measure: percent_4_star_accuracy {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star_accuracy} + ${percent_less_than_4_star_accuracy});;
  }

  measure: percent_4_star {
   #view_label: "Metrics"
    group_label: "Review Percentages"
    label: "Percent 4 Star Overall"
    type: number
    value_format: "0.0%"
    sql: 1 - (${percent_5_star} + ${percent_less_than_4_star});;
  }

  # measure: points_off_perfect_overall_nqs {
  #   label: "Points Off Perfect Overall NQS"
  #   description: "test"
  #   type: number
  #   sql: 100 * (${count_4_star} + ${count_less_than_4_star}*2) / NULLIF(${count},0) ;;
  # }

  # 100* (${airbnb_reviews.count_4_star} + ${airbnb_reviews.count_less_than_4_star}*2) / sum(${airbnb_reviews.count})


  set:airbnb_details {
    fields: [complexes.title, net_quality_score, count]
  }

}
