connection: "bigquery"
include: "../views/*"


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
    type:  inner
    relationship: many_to_one
    sql_on:
        ${financials.night_date} = ${capacities_rolled.night}
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
  join: master {
    type: inner
    relationship:  one_to_one
    sql_on: ${reservations.confirmationcode} = ${master.reservation_code} ;;
  }
  join: booking_reviews {
    type: inner
    relationship: one_to_many
    sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  }
}

# explore: reservationsRev {
#   from: capacities_rolled
#   join: financials {
#   type:  inner
#   relationship: many_to_one
#   sql_on:
#       ${capacities_rolled.night} = ${financials.night_date}
#       {% if complexes.title._is_selected or complexes.title._is_filtered %}
#         and
#         ${complexes._id} = ${capacities_rolled.complex}
#       {% endif %}
#       and ${reservations._id} = ${financials.reservation}
#     ;;
#   }
#   join: reservations {
#     type:  inner
#     relationship:  many_to_one
#      sql_on: ${reservations._id} = ${financials.reservation}
#   }
#   join: units {
#     type:  inner
#     relationship: many_to_one
#     sql_on: ${units._id} = ${reservations.unit} ;;
#   }
#   join: complexes {
#     type:  inner
#     relationship: many_to_one
#     sql_on: ${complexes._id} = ${units.complex} ;;
#   }
#
# }
