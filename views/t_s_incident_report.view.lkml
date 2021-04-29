view: t_s_incident_report {
  label: "T&S Security Incident Report"
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.t_s_incident_report`
    where reservation_code is not null
      ;;
  }


  dimension: reservation_code {
    type: string
    sql: ${TABLE}.Reservation_Code ;;
  }


  dimension_group: incident_report_date {
    type: time
    label: "Incident Report"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: TIMESTAMP(${TABLE}.Incident_Report_Date);;
    convert_tz: no
  }


  dimension: incident_location {
    type: string
    sql: ${TABLE}.Incident_Location ;;
  }

  dimension: incident_room_number {
    type: string
    sql: ${TABLE}.Incident_Room_Number ;;
  }

  dimension: incident_severity {
    type: string
    sql: ${TABLE}.Incident_Severity ;;
  }

  dimension: incident_taxonomy {
    type: string
    sql: ${TABLE}.Incident_Taxonomy ;;
  }

  dimension: reporting_party_classification {
    type: string
    sql: ${TABLE}.Reporting_Party_Classification ;;
  }

  dimension: offender_name {
    type: string
    sql: ${TABLE}.Offender_Name ;;
  }

  dimension: offender_email_address {
    type: string
    sql: ${TABLE}.Offender_Email_Address ;;
  }

  dimension: offender_phone_number {
    type: string
    sql: ${TABLE}.Offender_Phone_Number ;;
  }

  dimension: offender_classification {
    type: string
    sql: ${TABLE}.Offender_Classification ;;
  }

  dimension: victim_classification {
    type: string
    sql: ${TABLE}.Victim_Classification ;;
  }

  dimension: booking_channel {
    type: string
    sql: ${TABLE}.Booking_Channel ;;
  }

  dimension: offender_year_of_birth {
    type: string
    sql: ${TABLE}.Offender_YOB__Year_of_Birth_ ;;
  }

  dimension: offender_gender {
    type: string
    sql: ${TABLE}.Offender_Gender ;;
  }

  dimension: suspicous_email {
    type: string
    sql: ${TABLE}.Suspicous_Email ;;
  }

  dimension: offender_id_type {
    type: string
    sql: ${TABLE}.Offender_ID_Type ;;
  }

  dimension: offender_dl_zip_code {
    type: string
    sql: ${TABLE}.Offender_DL_Zip_Code ;;
  }

  dimension: offender_dl__ {
    type: string
    sql: ${TABLE}.Offender_DL__ ;;
  }

  dimension: offender_dl_expiration_date {
    type: string
    sql: ${TABLE}.Offender_DL_Expiration_Date ;;
  }

  dimension: selfie_photo_match {
    type: string
    sql: ${TABLE}.Selfie_Photo_Match ;;
  }

  dimension: offender_billing_zip_code {
    type: string
    sql: ${TABLE}.Offender_Billing_Zip_Code ;;
  }

  dimension: offender_dl_zip_code___billing_zip_code_match {
    type: string
    sql: ${TABLE}.Offender_DL_Zip_Code___Billing_Zip_Code_Match ;;
  }

  dimension: local_guest__phone_number_area_code_ {
    type: string
    sql: ${TABLE}.Local_Guest__Phone_Number_Area_Code_ ;;
  }

  dimension: local_guest_dl_zip_code__25_miles_ {
    type: string
    sql: ${TABLE}.Local_Guest_DL_Zip_Code__25_miles_ ;;
  }

  dimension: local_guest_billing_zip_code__25_miles_ {
    type: string
    sql: ${TABLE}.Local_Guest_Billing_Zip_Code__25_miles_ ;;
  }

  dimension: local_guest_ip_address__25_miles_ {
    type: string
    sql: ${TABLE}.Local_Guest_IP_Address__25_miles_ ;;
  }

  dimension: distance_between_billing_zip_code_and_ip_address {
    type: string
    sql: ${TABLE}.Distance_Between_Billing_Zip_Code_and_IP_Address ;;
  }

  dimension: stripe_email_address {
    type: string
    sql: ${TABLE}.Stripe_Email_Address ;;
  }

  dimension: email_address_match {
    type: string
    sql: ${TABLE}.Email_Address_Match ;;
  }

  dimension: payment_authorization_rate {
    type: string
    sql: ${TABLE}.Payment_Authorization_Rate ;;
  }

  dimension: sum_of_declined_cards_associated_w__email {
    type: string
    sql: ${TABLE}.Sum_of_Declined_Cards_Associated_w__Email ;;
  }

  dimension: sum_ip_addresses_associated_w__payment_information_ {
    type: string
    sql: ${TABLE}.Sum_IP_Addresses_associated_w__Payment_Information_ ;;
  }

  dimension: checkout_behavior {
    type: string
    sql: ${TABLE}.Checkout_Behavior ;;
  }

  dimension: prepaid_card {
    type: string
    sql: ${TABLE}.Prepaid_Card ;;
  }

  dimension: average_transaction_amount {
    type: string
    sql: ${TABLE}.Average_Transaction_Amount ;;
  }

  dimension: standard_deviation_transaction_amount {
    type: string
    sql: ${TABLE}.Standard_Deviation_Transaction_Amount ;;
  }

  dimension: party_risk {
    type: string
    sql: ${TABLE}.Party_Risk ;;
  }

  dimension: trust_risk {
    type: string
    sql: ${TABLE}.Trust_Risk ;;
  }

  dimension: animal_companion {
    type: string
    sql: ${TABLE}.Animal_Companion ;;
  }

  dimension: reservation_amount {
    type: string
    sql: ${TABLE}.Reservation_Amount ;;
  }

  dimension: accompanying_guests {
    type: string
    sql: ${TABLE}.Accompanying_Guests ;;
  }

  dimension: sum_total_guests {
    type: string
    sql: ${TABLE}.Sum_Total_Guests ;;
  }

  dimension: max_occupancy_reached {
    type: string
    sql: ${TABLE}.Max_Occupancy_Reached ;;
  }

  dimension: sum_of_bedrooms {
    type: string
    sql: ${TABLE}.Sum_of_Bedrooms ;;
  }

  dimension: reservation_extended {
    type: string
    sql: ${TABLE}.Reservation_Extended ;;
  }

  dimension: sum_of_extensions {
    type: string
    sql: ${TABLE}.Sum_of_Extensions ;;
  }

  dimension: length_of_stay__nights_ {
    type: string
    sql: ${TABLE}.Length_of_Stay__Nights_ ;;
  }

  dimension: booking_lead_time {
    type: string
    sql: ${TABLE}.Booking_Lead_Time ;;
  }

  dimension: repeat_guest {
    type: string
    sql: ${TABLE}.Repeat_Guest ;;
  }

  dimension: simultaneous_reservations {
    type: string
    sql: ${TABLE}.Simultaneous_Reservations ;;
  }

  dimension: sum_of_prior_reservations {
    type: number
    sql: ${TABLE}.Sum_of_Prior_Reservations ;;
  }

  dimension: sum_of_noise_events {
    type: number
    sql: ${TABLE}.Sum_of_Noise_Events ;;
  }

  dimension: sum_of_smoking_alerts {
    type: number
    sql: ${TABLE}.Sum_of_Smoking_Alerts ;;
  }

  dimension: added_to_no_fly_list {
    type: string
    sql: ${TABLE}.Added_to_No_Fly_List ;;
  }

  dimension: guest_removed {
    type: string
    sql: ${TABLE}.Guest_Removed ;;
  }

  dimension: damage_amount {
    type: string
    sql: ${TABLE}.Damage_Amount ;;
  }

  dimension: phone_queue {
    type: string
    sql: ${TABLE}.Phone_Queue ;;
  }

  dimension: phone_queue_contact_successful {
    type: string
    sql: ${TABLE}.Phone_Queue_Contact_Successful ;;
  }

  measure: count {
    type: count
    label: "Sum of Incident Reports"
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      reservation_code,
      incident_report_date_date,
      incident_location,
      incident_room_number,
      incident_severity,
      incident_taxonomy,
      reporting_party_classification,
      offender_name,
      offender_email_address,
      offender_phone_number,
      offender_classification,
      victim_classification,
      booking_channel,
      offender_year_of_birth,
      offender_gender,
      suspicous_email,
      offender_id_type,
      offender_dl_zip_code,
      offender_dl__,
      offender_dl_expiration_date,
      selfie_photo_match,
      offender_billing_zip_code,
      offender_dl_zip_code___billing_zip_code_match,
      local_guest__phone_number_area_code_,
      local_guest_dl_zip_code__25_miles_,
      local_guest_billing_zip_code__25_miles_,
      local_guest_ip_address__25_miles_,
      distance_between_billing_zip_code_and_ip_address,
      stripe_email_address,
      email_address_match,
      payment_authorization_rate,
      sum_of_declined_cards_associated_w__email,
      sum_ip_addresses_associated_w__payment_information_,
      checkout_behavior,
      prepaid_card,
      average_transaction_amount,
      standard_deviation_transaction_amount,
      party_risk,
      trust_risk,
      animal_companion,
      reservation_amount,
      accompanying_guests,
      sum_total_guests,
      max_occupancy_reached,
      sum_of_bedrooms,
      reservation_extended,
      sum_of_extensions,
      length_of_stay__nights_,
      booking_lead_time,
      repeat_guest,
      simultaneous_reservations,
      sum_of_prior_reservations,
      sum_of_noise_events,
      sum_of_smoking_alerts,
      added_to_no_fly_list,
      guest_removed,
      damage_amount,
      phone_queue,
      phone_queue_contact_successful
    ]
  }
}
