view: latest_listing_review_date {
  derived_table: {
    sql: SELECT
        airbnb_reviews.Listing_ID  AS airbnb_reviews_listing_id,
        count(*) as all_time_num_reviews,
        round(AVG(accuracy_rating),2) as all_time_average_accuracy,
        CAST(max((CAST(CAST(airbnb_reviews.Review_Date  AS TIMESTAMP) AS DATE)))  AS DATE) AS airbnb_reviews_latest_review_date
      FROM `bigquery-analytics-272822.mongo.reservations`
           AS reservations_clean
      FULL OUTER JOIN `bigquery-analytics-272822.airbnb_review_master.Airbnb_Reviews`
           AS airbnb_reviews ON reservations_clean.confirmationcode = airbnb_reviews.Reservation_Code
      where accuracy_rating is not null
      GROUP BY 1
       ;;
    persist_for: "1 hour"
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: all_time_num_reviews {
    type: number
    label: "# of Accuracy Reviews (all time)"
    sql: ${TABLE}.all_time_num_reviews ;;
  }

  dimension: airbnb_reviews_listing_id {
    type: number
    sql: ${TABLE}.airbnb_reviews_listing_id ;;
  }

  dimension: all_time_average_accuracy {
    type: number
    sql: ${TABLE}.all_time_average_accuracy ;;
  }

  dimension: airbnb_reviews_latest_review_date {
    type: date
    datatype: date
    sql: ${TABLE}.airbnb_reviews_latest_review_date ;;

  }

  set: detail {
    fields: [airbnb_reviews_listing_id, all_time_average_accuracy, airbnb_reviews_latest_review_date]
  }

  measure: accuracy_rating_latest_date {
    type: average
    value_format: "0.00"
    sql: CASE
          WHEN ${airbnb_reviews.review_date} = ${latest_listing_review_date.airbnb_reviews_latest_review_date}
          THEN Airbnb_Reviews.accuracy_rating
          ELSE NULL
          END;;
  }

  # Hmmm
  dimension: latest_title {
    type: string
    sql:
    CASE
    WHEN ${airbnb_reviews.review_date} = ${latest_listing_review_date.airbnb_reviews_latest_review_date}
    THEN
    ${TABLE}.title
    ELSE NULL
    END;;
  }

}
