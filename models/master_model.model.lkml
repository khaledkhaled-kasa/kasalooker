connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard



datagroup: aircalls_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hours"
}

datagroup: compliance_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hours"
}

datagroup: breezeway_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "6 hours"
}

datagroup: reviews_default_datagroup {
  #sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "6 hours"
}

datagroup: kasametrics_audit_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  sql_trigger: SELECT MAX(createdat) from reservations ;;
  max_cache_age: "1 hours"
}

datagroup: kasametrics_v3_default_datagroup {
  sql_trigger: SELECT MAX(createdat) from reservations;;
  max_cache_age: "1 hours"
}

datagroup: capacities_v3_default_datagroup {
  sql_trigger: SELECT MAX(createdat) from capacitydenorms;;
  max_cache_age: "24 hours"
}

datagroup: ximble_default_datagroup {
  sql_trigger: SELECT MAX(date) FROM ximble.ximble_master`;;
  max_cache_age: "1 hour"
}


explore: compliance_tracker {
  group_label: "Legal"
  persist_with: aircalls_default_datagroup
  label: "Compliance Tracker"
}


explore: aircall_segment {
  group_label: "Software"
  persist_with: compliance_default_datagroup
  label: "Aircall"
}

explore: breezeway_export {
  group_label: "Software"
  persist_with: breezeway_default_datagroup
  from: breezeway_export
  label: "Breezeway (Exports)"
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
    # sql_on: ${units._id} = ${reservations_clean.unit} ;;

  }

  join: airbnb_reviews {
    type: left_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmation_code} = ${airbnb_reviews.reservation_code} ;;
  }

  join: post_checkout_data {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmation_code}code} ;;
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

  join: financials_clean {
    type:  full_outer
    relationship: one_to_many
    sql_on: ${reservations_clean._id} = ${financials_clean.reservation} ;;
  }
}

explore: reservations_clean {
  persist_with: reviews_default_datagroup
  group_label: "Kasa Metrics"
  label: "Reviews"
  from: reservations_clean
  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${reservations_clean.unit} ;;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }

  join: complexes__address {
    from: complexes__address
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes__address._id} = ${reservations_clean.property};;
  }

  join: airbnb_reviews {
    type: full_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmation_code} = ${airbnb_reviews.reservation_code} ;;
  }

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${complexes__address.address_city_revised} = ${geo_location.city}
      and ${complexes__address.address_state_revised} = ${geo_location.state};;
  }

  join: reviews {
    type:  full_outer
    relationship:  one_to_one
    sql_on:  ${reviews.reservation} = ${reservations_clean._id} ;;
  }

  join: post_checkout_data {
    view_label: "Post Checkout Surveys"
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmation_code} ;;
  }

# for marketing
  join: latest_listing_review_date {
    type: full_outer
    relationship: one_to_one
    sql_on: ${latest_listing_review_date.airbnb_reviews_listing_id} = ${airbnb_reviews.listing_id} ;;
  }
}

explore: reservations_audit {
  label: "Reservations (Finance Audit)"
  group_label: "Kasa Metrics"
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

  join: gv_form_ts {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${reservations_audit.confirmationcode} = ${gv_form_ts.confirmationcode} ;;
  }

}

explore: capacities_v3 {
  group_label: "Kasa Metrics"
  label: "Reservations"
  persist_with: kasametrics_v3_default_datagroup
  from: capacities_v3
  join: units {
    type:  inner
    relationship: one_to_one #one_to_one
    sql_on: ${capacities_v3.unit} = ${units._id} ;;
  }
  join: complexes {
    type:  inner
    relationship: one_to_one #one_to_one
    sql_on: ${units.complex} = ${complexes._id} ;;
  }
  join: reservations_v3 {
    type:  left_outer
    relationship: one_to_many # One_to_Many
    sql_on: ${units._id} = ${reservations_v3.unit}  ;;
  }
  join: financials_v3 {
    type:  left_outer
    relationship: one_to_many # One_to_Many
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

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
      and ${units.address_state} = ${geo_location.state};;
  }


  # join: reviews {
  #   type:  full_outer
  #   relationship:  one_to_one
  #   sql_on:  ${reviews.reservation} = ${reservations_v3._id} ;;
  # }
  # join: airbnb_reviews {
  #   type: full_outer
  #   relationship:  one_to_one
  #   sql_on: ${reservations_v3.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  # }
  # join: booking_reviews {
  #   type: full_outer
  #   relationship: one_to_many
  #   sql_on: ${units.propcode} = ${booking_reviews.building} ;;
  # }
  # join: post_checkout_data {
  #   type:  full_outer
  #   relationship: one_to_one
  #   sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_v3.confirmationcode} ;;
  # }

# # for marketing
#   join: latest_listing_review_date {
#     type: full_outer
#     relationship: one_to_one
#     sql_on: ${latest_listing_review_date.airbnb_reviews_listing_id} = ${airbnb_reviews.listing_id} ;;
#   }

}

explore: guest_verification_form {
  group_label: "Product & Tech"
  label: "CSS (GV Verification)"
  persist_with: kasametrics_v3_default_datagroup
}

explore: okrs_test_gx {
  group_label: "OKRs (WIP)"
  label: "GX"
}

explore: okrs_bizops_test {
  group_label: "OKRs (WIP)"
  label: "BizOps"
}


explore: ximble_master {
  group_label: "Software"
  label: "Ximble"
  persist_with: kasametrics_v3_default_datagroup
}

# Project on Hold (Forecast Schedule)
# explore: ximble_hourly_schedule {
#   group_label: "Ximble"
#   persist_with: ximble_default_datagroup
#   from: ximble_hourly_schedule
# }
