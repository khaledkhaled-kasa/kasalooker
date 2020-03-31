connection: "bigquery"
include: "../views/*"


datagroup: kasametrics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kasametrics_default_datagroup

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
#   join: capacities {
#     type:  inner
#     relationship: many_to_one
#     sql_on: ${financials.night_date} = ${capacities.night_date} ;;
#   }
#   join: capacities_rolled {
#     type:  inner
#     relationship: many_to_one
#     sql_on: ${financials.night_date} = ${capacities_rolled.night_date} ;;
#   }

}

explore: capacities {
  from:  capacities
  join: complexes {
    type:  inner
    relationship:  many_to_one
    sql_on: ${capacities.complex} = ${complexes._id} ;;
  }
}
