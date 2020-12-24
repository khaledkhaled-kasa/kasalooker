connection: "bigquery"
include: "../views/*"
include: "../dashboards/*"

datagroup: kasametrics_v3_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: pdt_hourly {
  max_cache_age: "1 hour"
}

persist_with: kasametrics_v3_default_datagroup
label: "Kasa Metrics V3"



# explore: test {
#     from:  base_view
#   join: capacities_v3 {
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${capacities_v3._id} = ${test._id} ;;
#   }

#   join: complexes {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${complexes._id} = ${test.complex_id}_id} ;;
#   }

#   join: reservations_v3 {
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${reservations_v3.unit} = ${test.unit} ;;
#   }
#   join: financials_v3 {
#     type:  left_outer
#     relationship: one_to_many
#     sql_on: ${reservations_v3._id} = ${financials_v3.reservation}
#       and ${test.night_date} = ${financials_v3.night_date};;
#   }
#   join: units {
#     type:  left_outer
#     relationship: one_to_one
#     sql_on: ${test.unit} = ${units._id} ;;
#   }

  # }



explore: capacities_v3 {
  label: "Reservations"
  from: capacities_v3
  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${capacities_v3.unit} = ${units._id} ;;
  }
  join: complexes {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${units.complex} = ${complexes._id} ;;
  }
  join: reservations_v3 {
    type:  left_outer
    relationship: one_to_many
    sql_on: ${reservations_v3.unit} = ${units._id} ;;
  }
  join: financials_v3 {
    type:  left_outer
    relationship: one_to_many
    sql_on: ${reservations_v3._id} = ${financials_v3.reservation}
        and ${capacities_v3.night_date} = ${financials_v3.night_date};;
  }

  join: str_index {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${str_index.market} = ${complexes.city}
      and ${capacities_v3.night_date} = ${str_index.str_night_date};;
  }

  join: guests {
    type:  inner
    relationship: one_to_one
    sql_on:  ${reservations_v3.guest} = ${guests._id} ;;
  }
  join: reviews {
    type:  inner
    relationship:  one_to_one
    sql_on:  ${reviews.reservation} = ${reservations_v3._id} ;;
  }
  join: airbnb_reviews {
    type: inner
    relationship:  one_to_one
    sql_on: ${reservations_v3.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }
  join: booking_reviews {
    type: inner
    relationship: one_to_many
    sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  }
  join: post_checkout_data {
    type:  inner
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_v3.confirmationcode} ;;
  }

}
