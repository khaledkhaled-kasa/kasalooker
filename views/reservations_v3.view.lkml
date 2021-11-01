view: reservations_v3 {
  sql_table_name: `bigquery-analytics-272822.dbt.reservations_v3`  ;;
  label: "Reservations"

  dimension: confirmationcode {
    type: string
    primary_key: yes
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }

  dimension: reason_for_stay {
    description: "This will pull the reason for stay if provided by the guest."
    type:  string
    sql: ${TABLE}.reasonforstay  ;;
  }

    dimension: guest_type {
      hidden: no
      view_label: "Guests"
      type: string
      description: "Multibooker is classified as someone making more than one UNIQUE reservation (extensions are excluded). Null records are returned for bookings made by guest with no email."
      sql: CASE
      WHEN ${TABLE}.guest_type = "Multi Booker" and ${TABLE}.number_of_unique_reservations = 1 THEN "Single Booker"
      ELSE ${TABLE}.guest_type
      END;;
    }

  dimension: guest_reservations {
    view_label: "Guests"
    label: "Total Guest Reservations (Including Extensions)"
    hidden: no
    description: "This pulls the number of reservations the guest has made including extensions"
    type: number
    sql: ${TABLE}.number_of_bookings ;;
  }

    dimension: guest_unique_reservations {
      view_label: "Guests"
      description: "This pulls the number of reservations the guest has made excluding extensions"
      label: "Total Guest Reservations (Excluding Extensions)"
      hidden: no
      type: number
      sql: ${TABLE}.number_of_unique_reservations ;;
      }


  dimension: unit_stay_count {
    description: "This will pull the unit stay count sorted by earliest checkin date"
    type: number
    sql: ${TABLE}.unit_stay_count ;;
  }

  dimension: building_stay_count {
    description: "This will pull the building stay count sorted by earliest checkin date first, then looking at earlier booking date for reservations with the same checkindate"
    type: number
    sql: ${TABLE}.building_stay_count ;;
  }


    dimension: extended_booking {
      description: "An extended booking is defined as two consecutive bookings by the same guest (e-mail id) within the same building (i.e. a unit swap would still be considered an extension). An extended booking will only return Yes for the extended reservation."
      type: yesno
      sql: ${TABLE}.extended_booking = 1 ;;
    }


    dimension: initial_booking {
      label: "Initial Booking (For Extensions Only)"
      description: "This will inform us if it's the original / initial booking of an extended stay. Will only show as Yes for the initial booking of an extended reservation."
      type: yesno
      sql: ${TABLE}.initial_booking = 1 ;;
    }

  dimension: property {
    hidden: yes
    type: string
    sql: ${TABLE}.property ;;
  }


    dimension: _id {
      hidden: yes
      type: string
      sql: ${TABLE}._id ;;
    }


    dimension_group: bookingdate {
      label: "Booking"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        week_of_year,
        month,
        month_name,
        quarter,
        year
      ]
      sql: ${TABLE}.bookingdate ;;
    }

  dimension: lead_time {
    description: "This will pull the time between the booking date and checkin date."
    type:  number
    sql:  date_diff(${checkindate_date}, CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  }

  dimension: cancellation_window {
    description: "This will pull the time between the cancellation date and checkin date."
    type:  number
    sql:  date_diff(${checkindate_date}, CAST(${TABLE}.cancellationdate as DATE), DAY) ;;
  }

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(${checkoutdate_date}, ${checkindate_date}, DAY) ;;
  }

  dimension: preceding_cleaning_task {
    hidden: no
    type: string
    description: "This will pull the BW task prior to the stay"
    sql: ${TABLE}.precedingcleaningtask ;;
  }

  dimension: length_of_stay_type {
    label: "Length of Stay (Short-term/Long-term)"
    description: "Short-term stays are stays with < 28 nights; whereas long-term stays are >= 28 nights"
    type:  string
    sql:  CASE WHEN ${length_of_stay} < 28 THEN "Short-term stay"
    WHEN ${length_of_stay} >= 28 THEN "Long-term stay"
    END ;;
  }

  dimension: late_checkout_status {
    type: string
    description: "Returns whether a late checkout was approved or not. If late checkout wasn't requested, this returns a NULL or notRequested."
    sql: ${TABLE}.latecheckout.status ;;
  }

  dimension: bringingpets {
    type: yesno
    sql: ${TABLE}.bringingpets ;;
  }



  dimension_group: cancellationdate {
    label: "Cancellation"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.cancellationdate ;;
  }


    dimension_group: checkindate {
      type: time
      label: "Checkin"
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: TIMESTAMP(${TABLE}.checkindate);;
    }


    dimension_group: checkoutdate {
      type: time
      label: "Checkout"
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: CAST(${TABLE}.checkoutdate as TIMESTAMP);;
    }


    dimension: earlycheckin {
      hidden: yes
      sql: ${TABLE}.earlycheckin ;;
    }

    dimension: externalrefs {
      hidden: yes
      sql: ${TABLE}.externalrefs ;;
    }

    dimension: guest {
      hidden: yes
      type: string
      sql: ${TABLE}.guest ;;
    }

    dimension: guests_count {
      type: number
      sql: ${TABLE}.guestscount ;;
    }


    dimension: parking_space_needed {
      description: "This will pull reservations where guests have requested for a parking spot during booking. This does not neccessarily equate to the guest using a parking spot."
      type: yesno
      sql: ${TABLE}.parkingspaceneeded ;;
    }

  dimension: license_plate_provided {
    type: yesno
    description: "This will pull reservations where guests have provided us with their license plate information."
    sql: ${TABLE}.licenseplate is NOT NULL AND (LENGTH(${TABLE}.licenseplate) != 0) ;;
  }


    dimension: number_of_pets {
    type: number
    sql: ${TABLE}.numberofpets ;;
  }


    dimension: plannedarrival {
      type: string
      sql: ${TABLE}.plannedarrival ;;
    }

    dimension: planneddeparture {
      type: string
      sql: ${TABLE}.planneddeparture ;;
    }


    dimension: signeddoc {
      type: string
      sql: ${TABLE}.signeddoc ;;
    }

    dimension: smartlockcode {
      type: string
      sql: ${TABLE}.smartlockcode ;;
    }


    dimension: source {
      hidden: yes
      type: string
      sql: ${TABLE}.source ;;
    }

  dimension: sourcedetail {
    hidden: yes
    type: string
    sql: ${TABLE}.sourcedetail ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: sourcedata_channel {
    label: "Source (Channel)"
    type: string
    sql: ${TABLE}.sourcedata.channel ;;
  }

  dimension: sourcedata_channel_manager {
    label: "Source (Channel Manager)"
    type: string
    sql: ${TABLE}.sourcedata.channelmanager ;;
  }


    dimension: specialrequest {
      type: string
      sql: ${TABLE}.specialrequest ;;
    }

    # Update 08-04-2021; This will start pulling from status_revised which will convert all confirmed status with cancellation dates to canceled status
    dimension: status {
      type: string
      sql: ${TABLE}.status_revised ;;
    }

    dimension: suspicious {
      type: yesno
      sql: ${TABLE}.suspicious ;;
    }

    dimension: timezone {
      hidden: yes
      type: string
      sql: ${TABLE}.timezone ;;
    }

    dimension: unit {
      type: string
      hidden: yes
      sql: ${TABLE}.unit ;;
    }


    dimension: financial_night_part_of_res {
      hidden: yes
      type:  yesno
      sql: ${financials_v3.night_date} < ${checkoutdate_date} and
        ${financials_v3.night_date} >= ${checkindate_date};;
    }

    dimension: financial_night_part_of_res_modified {
      hidden: yes
      description: "This will ultimately just apply the financial night part of reservations for any financial nights prior to 01-21 where neccessary data manipulation for historic data was set in place"
      type:  string
      sql: CASE WHEN (${financial_night_part_of_res} OR ${financials_v3.night_date} >= '2021-01-01')THEN "yes"
            ELSE "no"
            END;;
    }

    dimension: capacity_night_part_of_res {
      type:  yesno
      hidden: yes
      sql: ${capacities_v3.night_date} < ${checkoutdate_date} and
        ${capacities_v3.night_date} >= ${checkindate_date};;
    }
  dimension: riskstatus {
    label: "Risk Status"
    type: string
    sql: ${TABLE}.infinitystones.riskstatus ;;
  }
  dimension: guestisverified {
    label: "Is Guest verified"
    type: yesno
    sql: ${TABLE}.infinitystones.guestisverified;;
  }

  dimension: capacity_night_part_of_checkin {
    type:  yesno
    hidden: yes
    sql: ${capacities_v3.night_date} = ${checkindate_date};;
  }

  dimension: checkin_night {
    hidden: yes
    type:  yesno
    sql: ${capacities_v3.night_date} = ${checkindate_date} ;;
  }

  dimension: checkout_night {
    hidden: yes
    type:  yesno
    sql: ${capacities_v3.night_date} = ${checkoutdate_date} ;;
  }
  measure: reservation_night {
    label: "Num ReservationNights"
    description: "Reservation night stay. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${capacities_v3.night_date});;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }

  measure: reservation_night_canceled {
    label: "Num ReservationNights (Canceled)"
    description: "Reservation night stay. This metric will only filter for canceled bookings. Also, this includes extended bookings as a SEPARATE booking."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${capacities_v3.night_date});;
    filters: [capacity_night_part_of_res: "yes", status: "cancelled, canceled"]
    drill_fields: [reservation_details*]

  }


    measure: num_reservations {
      label: "Num Reservations"
      description: "Number of unique reservations. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
      type: count_distinct
      sql: ${confirmationcode} ;;
      filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
      drill_fields: [reservation_details*]
    }


  measure: num_reservations_canceled {
    label: "Num Reservations (Canceled)"
    description: "Number of unique reservations. This metric will only filter for canceled bookings. Also, this includes extended bookings as a SEPARATE booking."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", status: "cancelled, canceled"]
    drill_fields: [reservation_details*]
  }

  measure: num_reservations_late_checkout {
    label: "Num Reservations (w/ Late Checkout)"
    description: "Returns the count of reservations who had an approved late checkout"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in", late_checkout_status: "approved"]
  }


    measure: occupancy {
      label: "Occupancy"
      description: "Number of reservation nights / capacity - This metric should be grouped by Night Available Date Group to retrieve accurate results"
      type: number
      value_format: "0.0%"
      sql:  ${reservation_night} / NULLIF(${capacities_v3.capacity}, 0) ;;
      drill_fields: [reservation_details*, capacities_v3.capacity]

    }


    measure: number_of_checkins {
      label: "Number of Checkins"
      description: "Number of Check-ins EXCLUDING Extensions"
      type: count_distinct
      sql: CONCAT(${_id},${confirmationcode}) ;;
      filters: [checkin_night: "yes", extended_booking: "no", status: "confirmed, checked_in"]
      drill_fields: [reservation_details*]

    }

  measure: number_of_checkins_star {
    label: "Number of Checkins - Including Extensions"
    description: "Number of Check-ins INCLUDING Extensions"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [checkin_night: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }

    measure: number_of_checkouts {
      label: "Number of Checkouts"
      description: "Number of Check-outs EXCLUDING Initial Extended Booking Checkouts"
      type: count_distinct
      sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
      filters: [checkout_night: "yes", initial_booking: "no", status: "confirmed, checked_in"]
      drill_fields: [reservation_details*]

    }

  measure: number_of_checkouts_star {
    label: "Number of Checkouts - Including Extensions"
    description: "Number of Check-outs INCLUDING Initial Extended Booking Checkouts"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [checkout_night: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }

  measure: extended_booking_count {
    label: "Extended Booking Count"
    description: "This would apply only to confirmed / checked-in bookings"
    type: count_distinct
    sql: CONCAT(${extended_booking}, ${confirmationcode}) ;;
    filters: [extended_booking: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }

  measure: avg_lead_time {
    label: "Average Lead Time"
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: avg_cancellation_window {
    description: "Days between cancelling and checking in."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${cancellation_window};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes"]
  }

  measure: median_lead_time {
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    label: "Median Lead Time"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: median_lead_time_checkin {
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings and only for reservations with available nights occurring on the check-in date. Also, this includes extended bookings as a SEPARATE booking."
    label: "Median Lead Time (Available Nights @ Checkin)"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_checkin: "yes", status: "confirmed, checked_in"]
  }


  measure: avg_length_of_stay {
    description: "Number of days of stay. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    label: "Average Length of Stay"
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: median_length_of_stay {
    description: "Number of days of stay. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    label: "Median Length of Stay"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: guestscount_sum {
    label: "Total Number of Guests"
    description: "Number of guests within the reservation(s). This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    type: sum_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${guests_count} ;;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*, guests_count]

  }

  measure: num_reservations_pets {
    label: "Num Reservations (Pets)"
    hidden: yes
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in", bringingpets: "yes"]

  }
  measure: num_unique_guest {
    label: "Num Unique guests"
    hidden: no
    type: count_distinct
    sql: ${guest} ;;
    filters: [ status: "confirmed, checked_in", guest: "-60dc47b356b7bb0009fd82e9,-NULL,-604a1163f17ca400088be57f"]

  }

  measure: percent_reservations_pets {
    label: "% Reservations (Pets)"
    description: "% of Reservations with Pets. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    hidden: no
    value_format: "0.0%"
    type: number
    sql: ${num_reservations_pets} / nullif(${num_reservations},0);;
    drill_fields: [reservation_details*, bringingpets]

  }

  # Channel Cost Dashboard Metrics


  measure: num_reservations_excluding_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Total Confirmed Bookings"
    description: "Number of unique reservations. This metric will only consider confirmed / checked in bookings. Also, this EXCLUDES extended bookings."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", extended_booking: "no", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]
  }


  measure: num_reservations_canceled_excluding_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Total Cancelled Bookings"
    description: "Number of unique reservations. This metric will only filter for canceled bookings. Also, this EXCLUDES extended bookings."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", extended_booking: "no", status: "cancelled, canceled"]
    drill_fields: [reservation_details*]
  }


  measure: reservation_night_excluding_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Total Confirmed Room Nights"
    description: "Reservation night stay. This metric will only consider confirmed / checked in bookings. Also, this EXCLUDES extended bookings."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${capacities_v3.night_date});;
    filters: [capacity_night_part_of_res: "yes",extended_booking: "no", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }

  measure: avg_lead_time_excluding_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Average Lead Time"
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings. Also, this EXCLUDES extended bookings."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in",extended_booking: "no"]
  }

  measure: avg_length_of_stay_excluding_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    description: "Number of days of stay. This metric will only consider confirmed / checked in bookings. Also, this EXCLUDES extended bookings."
    label: "Average Length of Stay"
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in",extended_booking: "no"]
  }

  measure: channel_fee_commission {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    description: "Preset"
    label: "Channel Fee / Commission % (L3M)"
    value_format: "0.0%"
    type:  number
    sql:
    CASE WHEN ${sourcedata_channel} = 'airbnb' THEN 0.03
    WHEN ${sourcedata_channel} = 'booking.com' THEN 0.166
    WHEN ${sourcedata_channel} = 'expedia' THEN 0.18
    WHEN ${sourcedata_channel} = 'vrbo' THEN 0.05
    WHEN ${sourcedata_channel} = 'nestpick' THEN 0.07
    WHEN ${sourcedata_channel} IN ('zeus','oasis') THEN 0.15
    WHEN ${sourcedata_channel} IN ('kasawebsite','gx') THEN 0
    ELSE null
    END;;
  }

  measure: channel_fee_revenue {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    description: "Preset"
    label: "Channel Fee Revenue for Kasa"
    value_format: "0.0%"
    type:  number
    sql:
    CASE WHEN ${sourcedata_channel} IN ('airbnb','booking.com', 'expedia', 'vrbo', 'nestpick', 'zeus', 'oasis') THEN 0
    WHEN ${sourcedata_channel} IN ('kasawebsite','gx') THEN 0.1
    ELSE null
    END;;
  }

  measure: percentage_cancellations_kasa_initiated {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    description: "Preset - sample from 2/12-2/19"
    label: "% Cancellations Kasa Initiated / Invalid Card"
    value_format: "0.0%"
    type:  number
    sql:
    CASE WHEN ${sourcedata_channel} = 'kasawebsite' THEN 0.306
    WHEN ${sourcedata_channel} = 'gx' THEN 0.217
    WHEN ${sourcedata_channel} = 'booking.com' THEN 0.434
    WHEN ${sourcedata_channel} = 'vrbo' THEN 0.438
    WHEN ${sourcedata_channel} IN ('airbnb', 'expedia', 'nestpick', 'zeus', 'oasis') THEN 0
    ELSE null
    END;;
  }

  measure: percentage_cancelled_bookings {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "% Cancelled Bookings"
    value_format: "0.0%"
    type:  number
    sql: ${num_reservations_canceled_excluding_extensions} / nullif((${num_reservations_canceled_excluding_extensions} + ${num_reservations_excluding_extensions}),0) ;;
  }

  measure: percentage_cancellations_excluding_invalid_card {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "% Cancellations Excluding Invalid Card"
    value_format: "0.0%"
    type:  number
    sql: (1 - ${percentage_cancellations_kasa_initiated})*${percentage_cancelled_bookings} ;;
  }

  measure: avg_finance_time_spent_cancelled_reservation {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Average Finance Time Spent / Cancelled Reservation (hours)"
    value_format: "0.00"
    type:  number
    sql: ((1 - ${percentage_cancellations_kasa_initiated})*${financials_v3.finance_time_spent_per_standard_cancellation}) + (${percentage_cancellations_kasa_initiated}*${financials_v3.finance_time_spent_per_invalid_card});;
  }


  measure: finance_personnel_cost_per_cancelled_reservation {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    description: "Finance Time Spent per Cancelled Reservation * $35"
    label: "Finance Personnel Cost per Cancelled Reservation $"
    value_format: "$#,##0.00"
    type:  number
    sql: ${avg_finance_time_spent_cancelled_reservation} * 35  ;;
  }

  measure: avg_cancellation_window_no_extensions {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Average Cancellation Window (days)"
    description: "Days between cancelling and checking in. This EXCLUDES Extended Bookings."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${cancellation_window};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", extended_booking: "no"]
  }

  measure: avg_booking_window_cancelled_bookings {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Average Booking Window for Cancelled Bookings (days)"
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings. Also, this EXCLUDES extended bookings."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "cancelled, canceled", extended_booking: "no"]
  }

  measure: num_reservations_canceled_due_idFailure{
    type: count_distinct
    label: "Canceled Reservation Due ID Failure"
    sql:CASE WHEN ${capacity_night_part_of_res}=True and
          (${status}="cancelled" or ${status}= "canceled")
          and ${guests.idcheckstatus}="failure" THEN ${confirmationcode} ELSE null END;;
    drill_fields: [confirmationcode,guests.idcheckstatus]
    }

  measure: num_reservations_canceled_due_BGCFailure{
    type: count_distinct
    label: "Canceled Reservation Due BGC Failure"
    sql:CASE WHEN ${capacity_night_part_of_res}=True and
          (${status}="cancelled" or ${status}= "canceled")
          and (${guests.backgroundCheckStatus}="failure" or  ${guests.backgroundCheckStatus} ="failed")  THEN ${confirmationcode} ELSE null END;;
    drill_fields: [reservation_details*]
    }

  set:reservations_clean {
    fields: [property, _id, length_of_stay, preceding_cleaning_task,length_of_stay_type,bringingpets, cancellationdate_date,checkindate_date, checkoutdate_date,guests_count, parking_space_needed, number_of_pets, source, sourcedetail, sourcedata_channel, sourcedata_channel_manager, status, timezone, unit, checkindate_month, checkindate_quarter, checkindate_raw, checkindate_time, checkindate_week, checkindate_year, checkoutdate_month, checkoutdate_quarter, checkoutdate_raw, checkoutdate_time, checkoutdate_week, checkoutdate_year]
    }


    set:reservation_details {
      fields: [confirmationcode, status, source, bookingdate_date, cancellationdate_date, checkindate_date, checkoutdate_date, reservation_night, reservation_night_canceled, num_reservations, num_reservations_canceled, sourcedata_channel, sourcedata_channel_manager]
    }


}
