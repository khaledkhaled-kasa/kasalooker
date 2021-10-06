view: airbnb_reviews {
  derived_table: {
    sql:
          SELECT airbnb_reviews.*, RANK() OVER (PARTITION BY complex ORDER BY airbnb_reviews.Review_Date DESC, airbnb_reviews.ds_checkout DESC) Review_Order
          FROM `bigquery-analytics-272822.airbnb_review_master.Master` airbnb_reviews
          LEFT JOIN reservations ON reservations.confirmationcode = airbnb_reviews.Reservation_Code
          LEFT JOIN units ON units._id = reservations.unit ;;

          # SELECT * -- OLD
          # FROM `bigquery-analytics-272822.airbnb_review_master.Master`;;

      persist_for: "4 hours"
    }

    dimension: review_order {
      hidden: yes
      type: number
      sql: ${TABLE}.Review_Order ;;
    }

    dimension: last_30_reviews {
      type: yesno
      sql: ${TABLE}.Review_Order <= 30 ;;
    }

    dimension: accuracy_comments {
      group_label: "Comments"
      type: string
      sql: ${TABLE}.Accuracy_Comments ;;
    }

    dimension: private_feedback {
      group_label: "Comments"
      type: string
      sql: ${TABLE}.Private_Feedback ;;
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
      hidden: yes
      timeframes: [raw, time, date, week, month, year, quarter]
      label: "Reservation Check-In"
      sql: timestamp(${reservations_clean.checkindate_time}) ;;
      convert_tz: no
    }

    dimension_group: reservation_checkout {
      label: "Reservation Check-Out"
      type: time
      hidden: yes
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

    dimension: number_of_days {
      description: "Number of days it took to complete real-time checkin survey post check-in"
      hidden: yes
      type:  number
      sql:  date_diff(${review_date}, ${reservations_clean.checkoutdate_date}, DAY) ;;
    }


    measure: number_of_days_median {
      description: "Median number of days it took to complete Airbnb Survey."
      label: "Median # of Days to Complete Airbnb Survey"
      value_format: "0.0"
      type:  median_distinct
      sql_distinct_key: ${reservation_code} ;;
      sql: ${number_of_days};;
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
      hidden: yes
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
      drill_fields: [review_date, ds_checkin_date, ds_checkout_date , units.internaltitle, cleanliness_rating, cleanliness_comments, value_comments, overall_comments]

    }

    measure: cleaning_rating_score {
      group_label: "POM Scorecard Metrics"
      type: number
      description: "POM Cleaning Rating Score"
      sql:  CASE WHEN ${avg_cleanliness_rating} > 4.73 THEN 1
              ELSE ${avg_cleanliness_rating}/NULLIF(4.73,0)
          END;;
      value_format: "0.00"
    }

    measure: cleaning_rating_score_weighted {
      group_label: "POM Scorecard Metrics"
      type: number
      label: "POM Cleaning Rating Score (Weighted)"
      description: "POM Cleaning Rating Score (Weighted)"
      sql: ${cleaning_rating_score} * ${pom_information.Cleaning_Score_Weighting} ;;
      value_format: "0.00"
    }


    measure: count_5_star {
      #view_label: "Metrics"
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
      label: "# of Perfect Stays (Promoters)"
      type: count_distinct
      value_format: "0"
      sql: ${reservation_code};;
      filters: [
        overall_rating: "5"
      ]
    }


    measure: count_4_star {
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
      label: "# of Bad Stays (Detractors)"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        overall_rating: "<=3"
      ]
    }


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
      label: "NQS (Overall)"
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
      drill_fields: [airbnb_details*, reservation_code ,review_date, cleanliness_comments, value_comments, overall_comments]
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
      drill_fields: [airbnb_details*, review_date, cleanliness_comments, value_comments, overall_comments]
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
      label: "Airbnb Review Count"
      description: "This will take the count of all reviews which had an overall rating (Higher than subcategory review count)"
      type: count_distinct
      sql: ${reservation_code} ;;
    }

    measure: clean_count_5_star {
      #view_label: "Metrics"
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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
      group_label: "Other Review Counts"
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

    measure: count_4_star_clean {
      group_label: "Other Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        cleanliness_rating: "4"
      ]
    }

    measure: count_4_star_value {
      group_label: "Other Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        value_rating: "4"
      ]
    }

    measure: count_4_star_location {
      group_label: "Other Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        location_rating: "4"
      ]
    }

    measure: count_4_star_communication {
      group_label: "Other Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        communication_rating: "4"
      ]
    }


    measure: count_4_star_checkin {
      group_label: "Other Review Counts"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [
        checkin_rating: "4"
      ]
    }

    ##### 90 Day Metrics

    measure: count_clean_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      type: count_distinct
      label: "Count Reviews (Clean) First 90 Days of Onboarding"
      sql: ${reservation_code} ;;
      filters: [cleanliness_rating: "1,2,3,4,5", hk_partners.first_3_months: "Yes"]
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: clean_count_5_star_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      label: "Count 5 Star Clean - First 90 Days"
      hidden: yes
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [cleanliness_rating: "5", hk_partners.first_3_months: "Yes"]
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: clean_count_less_than_4_star_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      label: "Count Less Than 4 Star Clean - First 90 Days"
      hidden: yes
      type: count_distinct
      value_format: "0"
      sql: ${reservation_code};;
      filters: [cleanliness_rating: "<=3", hk_partners.first_3_months: "Yes"]
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: percent_5_star_clean_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      label: "% Good Quality Stays- First 90 Days"
      description: "This refers to stays with 5 star ratings on cleanliness"
      type: number
      value_format: "0.0%"
      sql: ${clean_count_5_star} / nullif(${count_clean},0);;
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: percent_less_than_4_star_clean_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      label: "% Bad Stays - First 90 Days"
      description: "This refers to stays with less than 4 star ratings on cleanliness"
      type: number
      value_format: "0.0%"
      sql: ${clean_count_less_than_4_star} / nullif(${count_clean},0);;
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: net_quality_score_clean_first90 {
      #view_label: "Metrics"
      group_label: "HK Onboarding Metrics (First 90 Days)"
      label: "NQS (Clean) - First 90 Days"
      type: number
      value_format: "0.0"
      sql: 100*(${percent_5_star_clean} - ${percent_less_than_4_star_clean});;
      drill_fields: [reservation_code, reservation_checkin_date, reservation_checkout_date, cleanliness_rating, cleanliness_comments]

    }

    measure: net_quality_score_clean_last_30_reviews {
      group_label: "NQS Metrics"
      label: "NQS (Clean) - Last 30 Reviews"
      type: number
      value_format: "0.0"
      sql: 100*(${percent_5_star_clean_last_30_reviews} - ${percent_less_than_4_star_clean_last_30_reviews});;
      drill_fields: [airbnb_details*, review_date, cleanliness_comments, value_comments, overall_comments]
    }

    measure: percent_5_star_clean_last_30_reviews {
      #view_label: "Metrics"
      hidden: yes
      group_label: "Review Percentages"
      type: number
      value_format: "0.0%"
      sql: ${clean_count_5_star_last_30_reviews} / nullif(${count_clean_last_30_reviews},0);;
    }

    measure: count_clean_last_30_reviews {
      #view_label: "Metrics"
      hidden: yes
      group_label: "Other Review Counts"
      type: count_distinct
      label: "Count Reviews (Subcategories) - Last 30 Reviews"
      sql: ${reservation_code} ;;
      filters: [cleanliness_rating: "1,2,3,4,5", last_30_reviews: "Yes"]
    }

    measure: clean_count_5_star_last_30_reviews {
      hidden: yes
      #view_label: "Metrics"
      group_label: "Other Review Counts"
      label: "Count 5 Star Clean (Last 30 Reviews)"
      type: count_distinct
      value_format: "0"
      sql: ${TABLE}.Reservation_Code;;
      filters: [cleanliness_rating: "5", last_30_reviews: "Yes"]
    }

    measure: percent_less_than_4_star_clean_last_30_reviews {
      #view_label: "Metrics"
      hidden: yes
      group_label: "Review Percentages"
      type: number
      value_format: "0.0%"
      sql: ${clean_count_less_than_4_star_last_30_reviews} / nullif(${count_clean_last_30_reviews},0);;
    }

    measure: clean_count_less_than_4_star_last_30_reviews {
      #view_label: "Metrics"
      hidden: yes
      group_label: "Other Review Counts"
      label: "Count Less Than 4 Star Clean - Last 30 Reviews"
      type: count_distinct
      value_format: "0"
      sql: ${reservation_code};;
      filters: [cleanliness_rating: "<=3", last_30_reviews: "Yes"]
    }

    set:airbnb_details {
      fields: [complexes.title, count, net_quality_score, net_quality_score_accuracy, net_quality_score_checkin, net_quality_score_clean, net_quality_score_communication, net_quality_score_location, net_quality_score_value]
    }


  }
