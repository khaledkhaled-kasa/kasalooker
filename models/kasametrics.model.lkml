connection: "bigquery"
include: "../views/*"
#include: "../dashboards/*"

datagroup: kasametrics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kasametrics_default_datagroup
label: "Kasa Metrics"

explore: reservations {
  from: reservations
  join: financials {
    type:  inner
    relationship: one_to_many
    sql_on: ${reservations._id} = ${financials.reservation} ;;
  }
  join: units {
    type:  inner
    relationship: many_to_one
    sql_on: ${units._id} = ${reservations.unit} ;;
  }
  join: complexes {
    type:  inner
    relationship: many_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }
  join: capacities_rolled {
    type:  left_outer
    relationship: many_to_one
    sql_on:
        ${capacities_rolled.night} = ${financials.night_date}
        and cast(${capacities_rolled.bedroom} as string) = cast(${units.bedrooms} as string)
      {% if complexes.title._is_selected or complexes.title._is_filtered %}
        and
        ${complexes._id} = ${capacities_rolled.complex}
      {% endif %}
    ;;
  }

  join: guests {
    type:  inner
    relationship: one_to_one
    sql_on:  ${reservations.guest} = ${guests._id} ;;
  }
  join: reviews {
    type:  inner
    relationship:  one_to_one
    sql_on:  ${reviews.reservation} = ${reservations._id} ;;
  }
  join: airbnb_reviews {
    type: inner
    relationship:  one_to_one
    sql_on: ${reservations.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }
  join: booking_reviews {
    type: inner
    relationship: one_to_many
    sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  }
  join: post_checkout_data {
    type:  inner
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations.confirmationcode} ;;
  }
  join: cleaninglogs {
    type: inner
    relationship: one_to_many
    sql_on: ${cleaninglogs.unit} = ${units._id} ;;
  }
  join: staffs {
    type: inner
    relationship: one_to_one
    sql_on: ${cleaninglogs.housekeeper} = ${staffs._id} ;;
  }
  join: breezeway_config {
    type:  inner
    relationship: one_to_one
    sql_on: ${breezeway_config.units_nickname} = ${units.nickname} ;;
  }
  join: hk_scorecard {
    type: inner
    relationship: one_to_one
    sql_on: ${reservations.confirmationcode} = ${hk_scorecard.confCode} ;;
  }
  join: hk_cleanings_with_confcode {
    type: inner
    relationship: one_to_one
    sql_on: ${reservations.confirmationcode} = ${hk_cleanings_with_confcode.conf_code} ;;
  }
  join: hk_clean_time {
    type: inner
    relationship: one_to_one
    sql_on: ${reservations.confirmationcode} = ${hk_clean_time.conf_code} ;;

  }
}
