connection: "bigquery_new"
include: "../views/*"


datagroup: reservations_marketing_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: reservations_marketing_default_datagroup
label: "Kasa Reviews"
explore: reservations_marketing {
  from: reservations_clean
  join: units {
    type:  inner
    relationship: many_to_one
    sql_on: ${units._id} = ${reservations_marketing.unit} ;;
  }
  join: airbnb_reviews {
    type: full_outer
    relationship:  one_to_one
    sql_on: ${reservations_marketing.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }
  join: booking_reviews {
    type: full_outer
    relationship: one_to_many
    sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  }
  join: post_checkout_data {
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_marketing.confirmationcode} ;;
  }
  #latest join
  join: latest_listing_review_date {
    type: full_outer
    relationship: one_to_one
    sql_on: ${latest_listing_review_date.airbnb_reviews_listing_id} = ${airbnb_reviews.listing_id} ;;
  }
}
