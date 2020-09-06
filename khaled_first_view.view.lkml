explore: khaled_first_view {}
view: khaled_first_view {
  derived_table: {
    sql: select *
      from airbnb_review_data.airbnb_review_master
      limit 500;
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ds_checkin {
    type: number
    sql: ${TABLE}.ds_checkin ;;
  }

  dimension: ds_checkout {
    type: number
    sql: ${TABLE}.ds_checkout ;;
  }

  dimension: review_date {
    type: number
    sql: ${TABLE}.Review_Date ;;
  }

  dimension: host_id {
    type: number
    sql: ${TABLE}.Host_ID ;;
  }

  dimension: listing_id {
    type: number
    sql: ${TABLE}.Listing_ID ;;
  }

  dimension: reservation_code {
    type: string
    sql: ${TABLE}.Reservation_Code ;;
  }

  dimension: accuracy_rating {
    type: number
    sql: ${TABLE}.Accuracy_Rating ;;
  }

  dimension: overall_rating {
    type: number
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: cleanliness_rating {
    type: number
    sql: ${TABLE}.Cleanliness_Rating ;;
  }

  dimension: communication_rating {
    type: number
    sql: ${TABLE}.Communication_Rating ;;
  }

  dimension: checkin_rating {
    type: number
    sql: ${TABLE}.Checkin_Rating ;;
  }

  dimension: value_rating {
    type: number
    sql: ${TABLE}.Value_Rating ;;
  }

  dimension: location_rating {
    type: number
    sql: ${TABLE}.Location_Rating ;;
  }

  set: detail {
    fields: [
      ds_checkin,
      ds_checkout,
      review_date,
      host_id,
      listing_id,
      reservation_code,
      accuracy_rating,
      overall_rating,
      cleanliness_rating,
      communication_rating,
      checkin_rating,
      value_rating,
      location_rating
    ]
  }
}
