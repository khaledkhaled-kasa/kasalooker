connection: "bigquery"

include: "/views/*.view.lkml"                 # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                  # include all views in this project
# include: "/dashboards/*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: kustomer_default_datagroup {
  sql_trigger: SELECT MAX(_fivetran_synced) FROM kustomer.conversation;;
  max_cache_age: "1 hours"
}

datagroup: default_datagroup {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "24 hours"
}

datagroup: ST_Installation_Dates_Tracker_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `bigquery-analytics-272822.Gsheets.ST_Installation_Dates_Tracker`
  where  UnitInternalTitle is not null ;;
  max_cache_age: "1 minutes"
}

datagroup: meeting_attendance_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `bigquery-analytics-272822.Gsheets.POM_Meeting_Attendance` WHERE Date is NOT NULL ;;
  max_cache_age: "1 hours"
}


datagroup: units_kpo_overview_default_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `bigquery-analytics-272822.Gsheets.kpo_overview_clean` WHERE UID IS NOT NULL ;;
  max_cache_age: "1 hours"
}

datagroup: adaptive_export_default_datagroup {
  sql_trigger: SELECT count(*) FROM Gsheets.adaptive_export WHERE Building is NOT NULL ;;
  max_cache_age: "1 hours"
}

datagroup: breezeway_default_datagroup {
  sql_trigger: SELECT count(*) FROM Breezeway_Data.export_summary WHERE type is NOT NULL ;;
  max_cache_age: "1 hours"
}

datagroup: pom_checklist_default_datagroup {
  sql_trigger: SELECT extract(hour FROM current_timestamp) ;;
  max_cache_age: "1 hours"
}

datagroup: reviewforce_default_datagroup {
  sql_trigger: SELECT count(*) FROM `bigquery-analytics-272822.Gsheets.reviewforce_categorization_clean` WHERE ConfirmationCode IS NOT NULL ;;
  max_cache_age: "1 hours"
}

datagroup: reviews_default_datagroup {
  sql_trigger: SELECT MAX(createdat) from `bigquery-analytics-272822.dbt.reservations_v3` ;;
  max_cache_age: "1 hours"
}

datagroup: kasametrics_reservations_datagroup {
  sql_trigger: SELECT MAX(createdat) from `bigquery-analytics-272822.dbt.reservations_v3` ;;
  max_cache_age: "1 hours"
}


datagroup: gv_form_ts_default_datagroup {
  sql_trigger: SELECT extract(hour FROM current_timestamp) ;;
  max_cache_age: "1 hours"
}


datagroup: ximble_default_datagroup {
  sql_trigger: SELECT COUNT(*) FROM ximble.ximble_master WHERE First_Name IS NOT NULL ;;
  max_cache_age: "1 hour"
}


explore: pom_weighting_standards_final {
  group_label: "PropOps"
  hidden: yes
  label: "POM Scorecard Weights"
}


explore: compliance_tracker {
  group_label: "Legal"
  hidden: yes
  label: "Compliance Tracker"
}


explore: aircall_segment {
  group_label: "Software"
  description: "This explore pulls all air-call related events in real-time to power all aircall related metrics (Missed calls, inbound & outbound calls, etc.)"
  label: "Aircall"
}

explore: breezeway_export {
  fields: [
    ALL_FIELDS*,
    -complexes.title,
    -complexes_general_building.title,
    -complexes.externalrefs_stripepayoutaccountid,-complexes_general_building.externalrefs_stripepayoutaccountid,
    -units.propcode,
    -pom_qa_walkthrough_survey.total_qas_completed_percentage, -geo_location.marketing_property_dash_transition
  ]
  group_label: "PropOps"
  description: "This explore is based on a Breezeway export updated every Monday which displays all Breezeway related tasks for our POM teams (HK / PropOps). It also ties cleans to all reviews (Airbnb, Post-checkout, etc.) for feedback loop reinforcement."
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

  join: complexes_general_building { ## This will pull building title for general buildings where there is no property internal ids
    from: complexes
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes_general_building.internaltitle} = ${breezeway_export.building};;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
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
        AND left(${units.internaltitle},3) = left(${pom_qa_walkthrough_survey.Unit},3) AND right(${units.internaltitle},3) = right(${pom_qa_walkthrough_survey.Unit},3)
    AND ${reservations_clean.status} IN ("confirmed","checked_in")
    ;;
  }

  join: airbnb_reviews {
    type: left_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }

  join: post_checkout_data {
    view_label: "Post Checkout Surveys"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: post_checkout_v2 {
    view_label: "Post Checkout Surveys V2"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_v2.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: csat_review {
    view_label: "CSAT Review"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${csat_review.confirmationcode} = ${reservations_clean.confirmationcode} ;;
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
  fields: [ALL_FIELDS*, -geo_location.city_full_uid, -pom_information.live_partners]
  from: units
  view_label: "Unit Information"
  sql_always_where: ${units_buildings_information.availability_enddate_string} <> 'Invalid date' OR ${units_buildings_information.availability_enddate_string} IS NULL ;;
  label: "Units and Property Information"
  group_label: "Properties"


  join: accesses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information._id} = ${accesses.unitid} ;;
  }

  join: pom_qa_walkthrough_survey_agg {
    view_label: "QA Walkthrough Survey Data"
    type: left_outer
    relationship: one_to_many
    sql_on: right(${units_buildings_information.internaltitle},3) = right(${pom_qa_walkthrough_survey_agg.unit},3) and left(${units_buildings_information.internaltitle},3) = left(${pom_qa_walkthrough_survey_agg.unit},3) ;;
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
    relationship: one_to_one
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
    sql_on: left(${units_buildings_information.internaltitle},3) = left(${unit_submission_data_final.buildingunit},3) and right(${units_buildings_information.internaltitle},3) = right(${unit_submission_data_final.buildingunit},3) ;;
  }


  join: minut_data {
    from: devices
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information._id} = ${minut_data.unit}
            AND ${minut_data.devicetype} LIKE '%Minut%';;
  }

  join: lock_data {
    from: devices
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information._id} = ${lock_data.unit}
      AND lower(${lock_data.devicetype}) LIKE '%lock%';;
  }

  join: hub_devices {
    from: devices
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information._id} = ${hub_devices.unit}
    AND ${hub_devices.devicetype} IN ('Nexia_v1', 'Smartthings_v1') and ${hub_devices.active}=true;;
  }

  join: fresh_air_data {
    view_label: "Fresh Air Data"
    from: devices
    type: left_outer
    relationship: one_to_many
    sql_on: ${units_buildings_information._id} = ${fresh_air_data.unit}
      AND ${fresh_air_data.devicetype} = "FreshAir_v1";;
  }

}


explore: reservations_clean {
  aggregate_table: reviews_by_month_and_metrics {
    query: {
      dimensions: [complexes__address.title, reservations_clean.checkoutdate_month]
      measures: [airbnb_reviews.count, airbnb_reviews.net_quality_score, airbnb_reviews.avg_overall_rating, airbnb_reviews.avg_cleanliness_rating,
        airbnb_reviews.count_clean, airbnb_reviews.avg_accuracy_rating, airbnb_reviews.net_quality_score_clean, airbnb_reviews.avg_checkin_rating,
        airbnb_reviews.avg_communication_rating, airbnb_reviews.net_quality_score_accuracy, airbnb_reviews.net_quality_score_checkin, airbnb_reviews.net_quality_score_communication,
        post_checkout_v2.net_quality_score_accuracy, post_checkout_v2.net_quality_score_checkin, post_checkout_v2.net_quality_score_cleanliness, post_checkout_v2.net_quality_score_communication,
        post_checkout_v2.net_quality_score_location, post_checkout_v2.net_quality_score_overall, post_checkout_v2.net_quality_score_value, post_checkout_v2.count, post_checkout_v2.count_clean]
      timezone: America/Los_Angeles
    }

    materialization: {
      sql_trigger_value: SELECT MAX(createdat) from `bigquery-analytics-272822.dbt.reservations_v3`;;
    }
  }
  fields: [ALL_FIELDS*, -airbnb_reviews.clean_count_5_star_first90, -airbnb_reviews.clean_count_less_than_4_star_first90, -airbnb_reviews.count_clean_first90, -airbnb_reviews.net_quality_score_clean_first90, -airbnb_reviews.percent_5_star_clean_first90, -airbnb_reviews.percent_less_than_4_star_clean_first90, -complexes.title, -units.propcode, -geo_location.marketing_property_dash_transition]
  # sql_always_where: ${units.availability_enddate} <> 'Invalid date' ;;
  persist_with: reviews_default_datagroup
  group_label: "Kasa Metrics"
  label: "Reviews"
  description: "This pulls review data from different platforms including Airbnb, Post-checkout surveys, Real-time checkin surveys (VFD)"
  from: reservations_clean

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${reservations_clean.unit};;
  }

  join: guests {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${reservations_clean.guest} = ${guests._id};;
  }

  join: ST_Installation_Dates_Tracker{
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units.internaltitle} = ${ST_Installation_Dates_Tracker.unit_internal_title};;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
    sql_on: ${complexes__address.propcode_revised} = ${pom_information.Prop_Code} ;;
  }


  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex} ;;
  }
  join: google_review_tracker {
    type:  left_outer
    relationship: one_to_many
    sql_on: ${complexes__address.propcode_revised} = ${google_review_tracker.property} ;;
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
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
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
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: post_checkout_v2 {
    view_label: "Post Checkout Surveys V2"
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_v2.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: csat_review {
    view_label: "CSAT Review"
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${csat_review.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: reviewforce {
    view_label: "Review Force"
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${reviewforce.confirmation_code} = ${reservations_clean.confirmationcode} ;;
  }

# for marketing
  join: latest_listing_review_date {
    type: full_outer
    relationship: one_to_one
    sql_on: ${latest_listing_review_date.airbnb_reviews_listing_id} = ${airbnb_reviews.listing_id} ;;
  }
  join: braze_email_link_clicked {
    type: left_outer
    relationship: one_to_many
    sql_on: ${post_checkout_v2.userid} = ${braze_email_link_clicked.userid} ;;
  }
  join: braze_email_sent {
    type: left_outer
    relationship: one_to_many
    sql_on: ${post_checkout_v2.userid} = ${braze_email_sent.user_id} ;;
  }
  join: braze_webhook_sent {
    type: left_outer
    relationship: one_to_many
    sql_on: ${post_checkout_v2.userid} = ${braze_webhook_sent.user_id};;
  }

}

explore: reservations_audit {
  label: "Reservations (Finance Audit)"
  description: "This explore is exclusively built for our Finance team for auditing purposes. It differs from the Reservations in the sense that it will report financials for nights when the units weren't active as well. As a result, there is a slight difference in reported financials between both explores (roughly 1%). This explore does not house any guests or capacity (occupancy data)."
  group_label: "Finance"
  from: reservations_audit
  fields: [ALL_FIELDS*]

  join: financials_audit {
    type:  inner
    relationship: one_to_many
    sql_on: ${reservations_audit._id} = ${financials_audit.reservation} ;;
  }

  join: adaptive_export_revamped {
    view_label: "Financials - Adaptive (Monthly)"
    type:  full_outer
    relationship: one_to_one
    sql_on: ${financials_audit.night_month} = ${adaptive_export_revamped.month}
      and ${adaptive_export_revamped.prop_code} = ${units.propcode};;
  }

  join: chargelogs {
    view_label: "Charge Logs"
    type: left_outer
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
  aggregate_table: capacities_by_month_and_metrics {
    query: {
      dimensions: [complexes.title, capacities_v3.night_month]
      measures: [financials_v3.adr, financials_v3.revpar,reservations_v3.occupancy,financials_v3.amount,reservations_v3.num_reservations,
        reservations_v3.reservation_night,reservations_v3.number_of_checkins,capacities_v3.capacity]
      timezone: America/Los_Angeles
    }

    materialization: {
      sql_trigger_value: SELECT MAX(createdat) from `bigquery-analytics-272822.dbt.reservations_v3`;;
    }
  }

  group_label: "Kasa Metrics"
  label: "Reservations"
  description: "The mother of all explores. This houses all our capacities, reservations, units, buildings, guests and financials data."
  from: capacities_v3
  fields: [ALL_FIELDS*, -adaptive_export_revamped.month_finance_audit]
  join: units {
    type:  inner
    relationship: many_to_one
    sql_on: ${capacities_v3._id} = ${units._id} ;;
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
  join: guestreservationevents {
    view_label: "IoT Alerts"
    type: left_outer
    relationship: one_to_many
    sql_on: ${reservations_v3.confirmationcode} = ${guestreservationevents.confirmationcode};;
  }


  join: accesses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${reservations_v3.confirmationcode} = ${accesses.confirmationcode} ;;
  }
  join: codejobs_v2 {
    view_label: "Codejobs"
    type: full_outer
    relationship: one_to_many
    sql_on:${reservations_v3.confirmationcode} = ${codejobs_v2.confirmationcode} ;;
  }


  join: financials_v3 {
    type:  left_outer
    relationship: one_to_many # One_to_Many
    sql_on: ${reservations_v3._id} = ${financials_v3.reservation}
      and ${capacities_v3.night_date} = ${financials_v3.night_date};;
  }

  join: costar_data {
    type:  full_outer
    relationship: one_to_one
    sql_on: ${costar_data.metro_area} = ${geo_location.metro}
      and ${costar_data.state} = ${geo_location.state}
      and ${capacities_v3.night_month} = ${costar_data.month};;
  }


  join: seasonality_chart {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${seasonality_chart.metro_area} = ${geo_location.metro}
      and ${capacities_v3.night_month_name} = ${seasonality_chart.month};;
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

  join: adaptive_export_revamped {
    view_label: "Financials - Adaptive (Monthly)"
    type:  full_outer
    relationship: one_to_one
    sql_on: ${capacities_v3.night_month} = ${adaptive_export_revamped.month}
      and ${adaptive_export_revamped.prop_code} = ${units.propcode};;
  }

}

explore: okrs_master {
  group_label: "Kasa Metrics"
  label: "Kasa OKRs"
  hidden: yes
}

explore: devices {
  group_label: "Product & Tech"
  label: "Guest Alerts (Smoke & Noise)"
  fields: [ALL_FIELDS*,
    -devices.fresh_air_score,-devices.fresh_air_score_weighted]
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
  fields: [bw_cleaning.title,bw_cleaning.propcode, bw_cleaning.id, bw_cleaning.property_internal_id, bw_cleaning.tags, bw_cleaning.name, bw_cleaning.name_revised,
    bw_cleaning.assigned_date, bw_cleaning.completed_date_date, bw_cleaning.unit, bw_cleaning.type ,
    hk_cleaning_pricing.pricing, hk_cleaning_pricing.total_pricing, hk_pricing_companies.company, units.bedrooms
  ]
  group_label: "PropOps"
  label: "BW Cleaning Pricing Schedule"
  hidden: yes
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


  join: complexes_general_building { ## This will pull building title for general buildings where there is no property internal ids
    from: complexes
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes_general_building.internaltitle} = ${bw_cleaning.building};;
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
    ALL_FIELDS*,
    -units*,
    -hk_partners.first_3_months,
    -pom_qa_walkthrough_survey.total_qas_completed_percentage, -units*,-hk_partners.first_3_months,
    -pom_qa_walkthrough_survey.airbnb_reviews_POM_Walkthrough, -pom_qa_walkthrough_survey.real_time_POM_Walkthrough, -pom_information.live_partners
  ]
  persist_with: pom_checklist_default_datagroup
  group_label: "PropOps"
  label: "POM QA Walkthrough Checklist"
  hidden: yes

  join: hk_partners {
    type:  full_outer
    relationship: one_to_one
    sql_on:  ${hk_partners.buildings} = ${pom_qa_walkthrough_survey.property_code_3_letter}
          AND (${pom_qa_walkthrough_survey.submitdate_date} BETWEEN ${hk_partners.start_date} AND ${hk_partners.end_date});;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
    sql_on: ${pom_qa_walkthrough_survey.property_code_3_letter} = ${pom_information.Prop_Code} ;;
  }

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units.propcode} =  ${pom_information.Prop_Code} ;;
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

}

explore: disputes_tracker {
  group_label: "Finance"
  hidden: yes
  label: "Disputes Tracker"

  join: reservations_clean {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${disputes_tracker.reservation_id} = ${reservations_clean.confirmationcode};;
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
  hidden: no
}

explore: t_s_incident_report {
  fields: [t_s_incident_report*,-complexes.externalrefs_stripepayoutaccountid, pom_information.RevenueManager, pom_information.PortfolioManager, complexes.title, pom_information.property_owner]
  group_label: "T & S"
  label: "Security Incident Report"
  hidden: no

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
    sql_on: ${t_s_incident_report.incident_location} = ${pom_information.Prop_Code} ;;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes.internaltitle} = ${t_s_incident_report.incident_location}  ;;
  }
}

explore: channel_cost_marketing {
  group_label: "Marketing Analytics"
  label: "Channel Cost Dashboard"
  hidden: yes

  join: missing_cost_channel_metrics {
    type: full_outer
    relationship: one_to_one
    sql_on: ${channel_cost_marketing.source_channel_booking_1} = ${missing_cost_channel_metrics.channel}
      AND ${channel_cost_marketing.checkoutdate_1_month} = ${missing_cost_channel_metrics.month_month};;
  }

}

explore: slack_bugs_tech {
  hidden: yes
  fields: [
    ALL_FIELDS*,
    -pom_information*,
    -airbnb_reviews.cleaning_rating_score, -airbnb_reviews.cleaning_rating_score_weighted,
    -airbnb_reviews.clean_count_5_star_first90,
    -airbnb_reviews.clean_count_less_than_4_star_first90,
    -airbnb_reviews.count_clean_first90,
    -airbnb_reviews.net_quality_score_clean_first90,
    -airbnb_reviews.percent_5_star_clean_first90,
    -airbnb_reviews.percent_less_than_4_star_clean_first90,
    -post_checkout_v2.aggregated_comments_all_unclean]
  group_label: "Product & Tech"
  label: "Slack Bugs"

  join: reservations_clean {
    type: left_outer
    relationship: one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${slack_bugs_tech.confirmation_code};;
  }

  join: units {
    type: left_outer
    relationship: one_to_one
    sql_on: ${reservations_clean.unit} = ${units._id};;
  }

  join: complexes {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${complexes._id} = ${units.complex};;
  }

  join: airbnb_reviews {
    type: left_outer
    relationship:  one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${airbnb_reviews.reservation_code} ;;
  }

  join: post_checkout_data {
    view_label: "Post Checkout Surveys"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_data.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: post_checkout_v2 {
    view_label: "Post Checkout Surveys V2"
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${post_checkout_v2.confirmationcode} = ${reservations_clean.confirmationcode} ;;
  }

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
      and ${units.address_state} = ${geo_location.state};;
  }

}

explore: kasa_kredit_reimbursement {
  group_label: "People Ops"
  hidden: yes
  label: "Kasa Kredits"

  join: kasa_team_summary {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${kasa_kredit_reimbursement.email_address} = ${kasa_team_summary.email};;
  }

  join: kasa_stay_employee_feedback {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${kasa_kredit_reimbursement.confirmation_code} = ${kasa_stay_employee_feedback.reservation_code} ;;
  }

  join: reservations_clean {
    type: left_outer
    relationship: one_to_one
    sql_on: ${reservations_clean.confirmationcode} = ${kasa_kredit_reimbursement.confirmation_code} ;;
  }

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

  join: geo_location {
    type:  left_outer
    relationship: one_to_one
    sql_on:  ${units.address_city} = ${geo_location.city}
      and ${units.address_state} = ${geo_location.state};;
  }
}


explore: blocks {
  group_label: "Reservations"
  hidden: yes
  label: "Guesty Calendar Blocks"
  fields: [geo_location.city, geo_location.state, geo_location.metro, complexes.title, units.propcode, units.internaltitle,
            blocks.startdatelocal, blocks.enddatelocal, blocks.createdat_date, blocks.createdat_month, blocks.createdat_quarter,
            blocks.createdby, blocks.category, blocks.notes, blocks.status]

  join: units {
    type:  left_outer
    relationship: one_to_one
    sql_on: ${units._id} = ${blocks.unit} ;;
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
}

# -- SELECT complexes.internaltitle, units.internaltitle, startdatelocal, enddatelocal, blocks.createdat, blocks.createdby, category, notes, blocks.*
# -- FROM `bigquery-analytics-272822.mongo.blocks` blocks
# -- JOIN units ON blocks.unit = units._id
# -- JOIN complexes ON complexes._id = units.complex
# -- where units.internaltitle = 'ARW-222'


explore: security_deposits_kfc {
  group_label: "KFC Reporting"
  label: "Security Deposits"
  hidden: yes
}

# explore: adaptive_export_revamped {
#   group_label: "Finance"
#   label: "Adaptive Export"
#   hidden: yes
# }


explore: ximble_master {
  description: "This explore is based on a Ximble export updated every Monday which provides scheduled hours by GX teams to power metrics such as messages sent / hour."
  group_label: "Software"
  label: "Ximble"
}



explore: KPO_AUDIT{
  group_label: "Properties"
  description: "This explore will pull data directly from the KPO Overview tab. It was created for audit checks between the KPO and our Units DB"
  label: "KPO (Audit)"
}
