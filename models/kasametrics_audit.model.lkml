connection: "bigquery"
include: "../views/*"

datagroup: kasametrics_audit_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kasametrics_audit_default_datagroup
label: "Finance (Audit)"

explore: reservations_audit {
  from: reservations_audit
  join: financials_audit {
    type:  inner
    relationship: one_to_many
    sql_on: ${reservations_audit._id} = ${financials_audit.reservation} ;;
  }
  join: units {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${units._id} = ${reservations_audit.unit} ;;
  }
  join: complexes {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;

  }

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
      and ${units.address_state} = ${geo_location.state};;
  }
  # join: capacities_rolled_audit {
  #   type:  left_outer
  #   relationship: many_to_one
  #   sql_on:
  #       ${capacities_rolled_audit.night} = ${financials_audit.night_date}
  #       and cast(${capacities_rolled_audit.bedroom} as string) = cast(${units.bedrooms} as string)
  #     {% if complexes.title._is_selected or complexes.title._is_filtered %}
  #       and
  #       ${complexes._id} = ${capacities_rolled_audit.complex}
  #     {% endif %}
  #   ;;
  # }


}
