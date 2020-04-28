view: airbnb_review_master {
  sql_table_name: `bigquery-analytics-272822.airbnb_review_data.airbnb_review_master`
    ;;

  dimension: accuracy_rating {
    type: number
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: checkin_rating {
    type: number
    sql: ${TABLE}.Checkin_Rating ;;
  }

  dimension: cleanliness_rating {
    type: number
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: communication_rating {
    type: number
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension: ds_checkin {
    type: number
    sql: ${TABLE}.ds_checkin ;;
  }

  dimension: ds_checkout {
    type: number
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

  dimension: location_rating {
    type: number
    sql: ${TABLE}.Location_Rating ;;
  }

  measure: overall_rating {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: reservation_code {
    type: string
    sql: ${TABLE}.Reservation_Code ;;
    primary_key: yes
  }

 # dimension: review_date {
  #  type: number
   # sql: ${TABLE}.Review_Date ;;
  #}

  dimension: value_rating {
    type: number
    sql: ${TABLE}.Value_Rating ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  dimension_group: review_date {
    group_label: "Review Date"
    description: "Date guest submitted review"
    type: time
    timeframes: [
      date,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.Review_Date  ;;
    }
}
