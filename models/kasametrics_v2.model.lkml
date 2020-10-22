connection: "bigquery"
include: "../views/*"
include: "../dashboards/*"

datagroup: kasametrics_default_datagroup_v2 {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kasametrics_default_datagroup_v2
label: "Kasa Metrics V2"

explore: capacities_rolled {
  label: "Reservations"
  from: capacities_rolled
  join: complexes {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${capacities_rolled.complex} = ${complexes._id} ;;
  }
  join: units {
    type:  left_outer
    relationship: one_to_many
    sql_on: ${capacities_rolled.complex} = ${units.complex}
    and
    cast(${capacities_rolled.bedroom} as string) = cast(${units.bedrooms} as string)
    ;;
  }
  join: reservations {
    type:  left_outer
    relationship: one_to_many
    sql_on: ${reservations.unit} = ${units._id};;

  }
  join: financials {
    type: left_outer
    relationship: one_to_many
    sql_on:
        ${reservations._id} = ${financials.reservation}
        and ${capacities_rolled.night_date} = ${financials.night_date};;

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

explore: guest_verification_form {
  label: "GV Verification"
}
