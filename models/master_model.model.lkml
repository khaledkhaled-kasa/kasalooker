connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "/dashboards/*.dashboard.lookml"               # include a LookML dashboard called my_dashboard



datagroup: default_datagroup {
  max_cache_age: "1 hours"
}

datagroup: breezeway_default_datagroup {
  sql_trigger: SELECT count(*) FROM Breezeway_Data.export_summary ;;
  max_cache_age: "1 hours"
}

datagroup: pom_checklist_default_datagroup {
  sql_trigger: SELECT count(*) FROM Gsheets.POM_QA_Walkthrough_Survey ;;
  max_cache_age: "1 hours"
}

datagroup: reviews_default_datagroup {
  max_cache_age: "6 hours"
}

datagroup: kasametrics_reservations_datagroup {
  sql_trigger: SELECT MAX(createdat) from reservations ;;
  max_cache_age: "1 hours"
}


datagroup: gv_form_ts_default_datagroup {
  sql_trigger: SELECT extract(hour FROM current_timestamp) ;;
  max_cache_age: "1 hours"
}

datagroup: capacities_v3_default_datagroup {
  sql_trigger: SELECT MAX(createdat) from capacitydenorms;;
  max_cache_age: "24 hours"
}

datagroup: ximble_default_datagroup {
  sql_trigger: SELECT MAX(date) FROM ximble.ximble_master;;
  max_cache_age: "1 hour"
}

explore: pom_weighting_standards_initial {
  group_label: "POM Weights"
  label: "POM Weighting Test"
}

explore: pom_weighting_standards_final {
  group_label: "POM Weights"
  label: "POM Weighting Test 2"
}


explore: compliance_tracker {
  group_label: "Legal"
  persist_with: default_datagroup
  label: "Compliance Tracker"
}


explore: aircall_segment {
  group_label: "Software"
  persist_with: default_datagroup
  label: "Aircall"
}

explore: breezeway_export {
  fields: [
    ALL_FIELDS*,
    -complexes.title,
    -units.propcode
  ]
  group_label: "Software"
  persist_with: breezeway_default_datagroup
  from: breezeway_export
  label: "Breezeway (Exports)"
  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${breezeway_export.property_internal_id} =  ${units.breezeway_id};;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${units.propcode} = ${pom_information.Prop_Code} ;;
  }

  join: hk_partners {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${hk_partners.buildings} = ${breezeway_export.propcode}
          AND (${breezeway_export.assigned_date_date} BETWEEN ${hk_partners.start_date} AND ${hk_partners.end_date})
          AND ${breezeway_export.type} = "Cleaning";;
  }
  join: reservations_clean {
    type:  left_outer
    relationship: one_to_one
    sql_on: CAST(${breezeway_export.id} as STRING) = ${reservations_clean.preceding_cleaning_task} ;;
    # sql_on: ${units._id} = ${reservations_clean.unit} ;;

  }

  join: pom_qa_walkthrough_survey {
    type: full_outer
    relationship: one_to_one
    sql_on: (DATE(${pom_qa_walkthrough_survey.submitdate_date}) BETWEEN DATE(${breezeway_export.completed_date_date}) AND DATE(${reservations_clean.checkindate_date}))
    AND ${units.internaltitle} = ${pom_qa_walkthrough_survey.Unit}
    AND ${reservations_clean.status} IN ("confirmed","checked_in")
    ;;
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


explore: units_buildings_information {
  from: units
  view_label: "Unit Information"
  sql_always_where: ${units_buildings_information.availability_enddate_string} <> 'Invalid date' ;;
  label: "Units and Property Information"
  group_label: "Properties"

  join: pom_walkthrough_with_reservations {
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information.internaltitle} = ${pom_walkthrough_with_reservations.internaltitle} ;;
  }

  join: airbnb_reviews {
    fields: [airbnb_reviews.avg_cleanliness_rating, airbnb_reviews.avg_accuracy_rating, airbnb_reviews.avg_checkin_rating, airbnb_reviews.avg_communication_rating, airbnb_reviews.avg_overall_rating]
    type: left_outer
    relationship: one_to_one
    sql_on: ${pom_walkthrough_with_reservations.confirmation_code} = ${airbnb_reviews.reservation_code} ;;
  }

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units_buildings_information.address_city} = ${geo_location.city}
      and ${units_buildings_information.address_state} = ${geo_location.state};;
  }

  join: complexes {
    type: left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units_buildings_information.complex};;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${units_buildings_information.propcode} = ${pom_information.Prop_Code} ;;
  }

  join: pom_meeting_attendance {
    view_label: "POM Meeting Data"
    type: left_outer
    relationship: one_to_many
    sql_on: ${pom_information.pom} = ${pom_meeting_attendance.pom} ;;
  }

  join: unit_submission_data_final {
    view_label: "POM Visit Information"
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information.internaltitle} = ${unit_submission_data_final.buildingunit} ;;
  }

  join: noiseaware {
    view_label: "NoiseAware"
    type: left_outer
    relationship: one_to_one
    sql_on: ${units_buildings_information.internaltitle} = ${noiseaware.building_unit} ;;
  }

  join: freshair_data {
    view_label: "FreshAir"
    type: left_outer
    relationship: one_to_one
    sql_on: ${units_buildings_information.internaltitle} = ${freshair_data.uid} ;;
  }

  join: nexia_data {
    view_label: "Nexia"
    type: left_outer
    relationship: one_to_one
    sql_on: ${units_buildings_information.internaltitle} = ${nexia_data.uid} ;;
  }

}


explore: reservations_clean {
  fields: [
    ALL_FIELDS*, -airbnb_reviews.clean_count_5_star_first90, -airbnb_reviews.clean_count_less_than_4_star_first90, -airbnb_reviews.count_clean_first90, -airbnb_reviews.net_quality_score_clean_first90, -airbnb_reviews.percent_5_star_clean_first90, -airbnb_reviews.percent_less_than_4_star_clean_first90]
  # sql_always_where: ${units.availability_enddate} <> 'Invalid date' ;;
  persist_with: reviews_default_datagroup
  group_label: "Kasa Metrics"
  label: "Reviews"
  from: reservations_clean

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${reservations_clean.unit};;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${units.propcode} = ${pom_information.Prop_Code} ;;
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

  join: post_checkout_v2 {
    view_label: "Post Checkout Surveys V2"
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_v2.confirmationcode} = ${reservations_clean.confirmation_code} ;;
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
  group_label: "Finance"
  from: reservations_audit

  join: financials_audit {
    type:  inner
    relationship: one_to_many
    sql_on: ${reservations_audit._id} = ${financials_audit.reservation} ;;
  }

  join: chargelogs {
    view_label: "Charge Logs"
    type: inner
    relationship: one_to_one
    sql_on: ${reservations_audit._id} = ${chargelogs.reservation} ;;
  }

  join: guests {
    view_label: "Guest Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${reservations_audit.guest} = ${guests._id} ;;
  }

  join: paymentint {
    view_label: "Payment Intent"
    type: left_outer
    relationship: one_to_one
    sql_on: ${reservations_audit._id} = ${paymentint.reservation} ;;
  }

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} =
    (CASE WHEN ${reservations_audit.unit} IS NOT NULL THEN ${reservations_audit.unit}
    ELSE ${financials_audit.unit}
    END);;
    }


  join: complexes {
    type:  left_outer
    relationship: one_to_one
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
  persist_with: kasametrics_reservations_datagroup
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
  join: pom_information {
    type:  left_outer
    relationship: one_to_one #one_to_one
    sql_on: ${complexes.internaltitle} = ${pom_information.Prop_Code} ;;
  }
  join: reservations_v3 {
    type:  left_outer
    relationship: one_to_many # One_to_Many
    sql_on: ${units._id} = ${reservations_v3.unit};;
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



explore: okrs_master {
  group_label: "Kasa Metrics"
  label: "Kasa OKRs"
}

explore: devices {
  group_label: "Product & Tech"
  label: "Guest Alerts (Smoke & Noise)"
  from: devices

  join: units {
    type:  full_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${devices.unit} AND (${units.propertyinternaltitle} != 'TST');;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }

  join: all_guest_alerts {
    type: full_outer
    relationship: many_to_one
    sql_on: ${units._id} = ${all_guest_alerts.unit_ID};;
  }

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
      and ${units.address_state} = ${geo_location.state};;
  }

}

explore: bw_cleaning {
  fields: [
    ALL_FIELDS*,
    -complexes.title,
    -units.propcode
  ]
  group_label: "Software"
  label: "BW Cleaning Pricing Schedule"
  from: breezeway_export
  view_label: "BW Export"
  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${bw_cleaning.property_internal_id} =  ${units.breezeway_id} ;;

  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex};;
  }


  join: hk_cleaning_pricing {
    type: left_outer
    relationship: one_to_one
    sql_on: ${hk_cleaning_pricing.property_code} = ${units.propcode}
    AND ${units.bedrooms} = ${hk_cleaning_pricing.br}
    AND ${hk_cleaning_pricing.task} = ${bw_cleaning.name_revised};;
  }

  join: hk_pricing_unit_specific {
    type: left_outer
    relationship: one_to_one
    sql_on: ${hk_pricing_unit_specific.property_code} = ${bw_cleaning.propcode}
          AND ${bw_cleaning.unit} = ${hk_pricing_unit_specific.unit}
          AND ${hk_pricing_unit_specific.task} = ${bw_cleaning.name_revised};;
  }

  join: hk_pricing_companies {
    type: left_outer
    relationship: one_to_one
    sql_on: ${bw_cleaning.propcode} = ${hk_pricing_companies.property_code};;
  }

}

explore: pom_qa_walkthrough_survey {
  fields: [
    ALL_FIELDS*, -hk_partners.first_3_months]
  group_label: "Software"
  label: "POM QA Walkthrough Checklist"

  join: hk_partners {
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${hk_partners.buildings} = ${pom_qa_walkthrough_survey.property_code_3_letter}
          AND (${pom_qa_walkthrough_survey.submitdate_date} BETWEEN ${hk_partners.start_date} AND ${hk_partners.end_date});;
  }
}

explore: disputes_tracker {
  group_label: "Finance"
  label: "Disputes Tracker"

  join: reservations_clean {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${disputes_tracker.reservation_id} = ${reservations_clean.confirmation_code};;
  }

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${reservations_clean.unit};;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }

  join: stripe_aggregated_balance {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${disputes_tracker.dispute_created_month} = ${stripe_aggregated_balance.created_month};;
  }

}

explore: trs_prs {
  group_label: "T & S"
  label: "TRS / PRS Violations"
}

explore: t_s_security_deployment {
  group_label: "T & S"
  label: "Security Deployment Report"
}

explore: t_s_incident_report {
  group_label: "T & S"
  label: "Security Incident Report"
}


explore: ximble_master {
  group_label: "Software"
  label: "Ximble"
}

# Project on Hold (Forecast Schedule)
# explore: ximble_hourly_schedule {
#   group_label: "Ximble"
#   persist_with: ximble_default_datagroup
#   from: ximble_hourly_schedule
# }
