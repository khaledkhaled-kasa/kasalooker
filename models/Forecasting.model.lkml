connection: "bigquery"
include: "../views/*"


datagroup: forecasting_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: forecasting_default_datagroup
label: "Kasa Reviews"
explore: ximble_hourly_schedule {

}



# from: ximble_hourly_schedule
# join: conversation {
#   type:  inner
#   relationship: many_to_one
#   sql_on: ${ximble_hourly_schedule.start_date} = ${conversation_kk.created_pst_date} ;;
# }
# join: airbnb_reviews {
#   type: full_outer
#   relationship:  one_to_one
#   sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
# }
# join: booking_reviews {
#   type: full_outer
#   relationship: one_to_many
#   sql_on: ${units.propcode} = ${booking_reviews.building} ;;
# }
# join: post_checkout_data {
#   type:  full_outer
#   relationship: one_to_one
#   sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmationcode} ;;
# }
