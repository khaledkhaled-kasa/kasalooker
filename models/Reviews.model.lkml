connection: "bigquery"
include: "../views/*"


datagroup: reviews_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: reviews_default_datagroup
label: "Kasa Reviews"
explore: reservations_clean {
  label: "Reservations"
  from: reservations_clean
  join: units {
    type:  inner
    relationship: many_to_one
    sql_on: ${units._id} = ${reservations_clean.unit} ;;
  }

  join: complexes {
    type:  inner
    relationship: many_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }

  join: airbnb_reviews {
    type: full_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }
  join: booking_reviews {
    type: full_outer
    relationship: one_to_many
    sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  }
  join: post_checkout_data {
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }
  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
    and ${units.address_state} = ${geo_location.state};;
  }
}
