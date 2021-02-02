connection: "bigquery"
include: "../views/*"
# include: "../dashboards/*"


datagroup: breezeway_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
max_cache_age: "6 hours"
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
    sql_on:  ${hk_partners.buildings} = LEFT(${breezeway_export.property_internal_id},3)
    AND (${breezeway_export.assigned_date_date} BETWEEN ${hk_partners.start_date} AND ${hk_partners.end_date})
    AND ${breezeway_export.type} = "Cleaning";;
  }
  join: reservations_clean {
    type:  left_outer
    relationship: one_to_one
    sql_on: CAST(${breezeway_export.id} as STRING) = ${reservations_clean.preceding_cleaning_task} ;;
  }

  join: airbnb_reviews {
    type: left_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }

  join: post_checkout_data {
    type:  left_outer
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
    type:  left_outer
    relationship:  one_to_one
    sql_on:  ${reviews.reservation} = ${reservations_clean._id} ;;
  }

}
