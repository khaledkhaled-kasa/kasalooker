connection: "bigquery"
include: "../views/*"
# include: "../dashboards/*"


datagroup: breezeway_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
max_cache_age: "12 hours"
}

persist_with: breezeway_default_datagroup
label: "Breezeway"
explore: breezeway_export {
  from: breezeway_export
  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units.internaltitle} = ${breezeway_export.property_internal_id} ;;
  }
  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }
  join: hk_partners {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${hk_partners.buildings} = ${complexes.internaltitle} ;;
  }
  join: reservations_clean {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${reservations_clean.unit} ;;
  }

  join: airbnb_reviews {
    type: full_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
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

  join: reviews {
    type:  full_outer
    relationship:  one_to_one
    sql_on:  ${reviews.reservation} = ${reservations_clean._id} ;;
  }

}
