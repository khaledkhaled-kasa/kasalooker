view: reservations_clean {
  label: "Reservations"
  sql_table_name: `bigquery-analytics-272822.dbt.reservations_v3`  ;;



  dimension: _id {
    hidden: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: property {
    hidden: yes
    type: string
    sql: ${TABLE}.property ;;
  }


  dimension: length_of_stay {
    type:  number
    sql:  date_diff(${checkoutdate_date}, ${checkindate_date}, DAY) ;;
  }

  dimension: guest {
    hidden: yes
    type: string
    sql: ${TABLE}.guest ;;
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


  dimension: length_of_stay_type {
    label: "Length of Stay (Short-term/Long-term)"
    description: "Short-term stays are stays with < 28 nights; whereas long-term stays are >= 28 nights"
    type:  string
    sql:  CASE WHEN ${length_of_stay} < 28 THEN "Short-term stay"
          WHEN ${length_of_stay} >= 28 THEN "Long-term stay"
          END ;;
  }

  dimension_group: submittedat {
    label: "KBC submitted"
    description: "Date Guest completed KBC"
    group_label: "KBC"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.kbc.submittedat;;
    convert_tz: no

  }

  dimension: kbc_completed_inadvance {
    label: "KBC Completed 24 hrs pre Checkin (Yes/No)"
    group_label: "KBC"
    description: "Is KBC completed 24 hrs in Advance of Checkin"
    hidden: no
    type: string
    sql:CASE WHEN date_diff(timestamp(${submittedat_time}),timestamp(${checkindate_time}),hour)<=24 THEN "Yes" ELSE "No" END;;

  }
  dimension: kbc_completed_postBooking {
    label: "KBC Completed 24 hrs post Booking(Yes/No)"
    group_label: "KBC"
    description: "Is KBC completed within 24 hrs after Booking Date"
    hidden: no
    type: string
    sql:CASE WHEN date_diff(timestamp(${submittedat_time}),timestamp(${bookingdate_time}),hour)<=24 THEN "Yes" ELSE "No" END;;

  }
  dimension: riskstatus {
    label: "Risk Status"
    type: string
    sql: ${TABLE}.infinitystones.riskstatus ;;
  }


  dimension_group: bookingdate {
    label: "Booking"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.bookingdate ;;
    convert_tz: no
  }

  dimension: preceding_cleaning_task {
    hidden: no
    type: string
    description: "This will pull the BW task prior to the stay"
    sql: ${TABLE}.precedingcleaningtask ;;
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
    timeframes: [raw, time, date, week,month, year, quarter]
    label: "Reservation Check-In"
    sql: CAST(${TABLE}.checkindate as TIMESTAMP);;
  }

  dimension_group: checkoutdate {
    label: "Reservation Check-Out"
    type: time
    timeframes: [raw, time, date, week,month, year, quarter]
    sql: CAST(${TABLE}.checkoutdate as TIMESTAMP);;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }


  dimension: parking_space_needed {
    type: yesno
    sql: ${TABLE}.parkingspaceneeded ;;
  }


  dimension: pets {
    type: yesno
    sql: ${TABLE}.pets ;;
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


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: timezone {
    hidden: yes
    type: string
    sql: ${TABLE}.timezone ;;
  }
  dimension: guestisverifiedyesno {
    label: "Is Guest verified "
    type: yesno
    sql: ${TABLE}.infinitystones.guestisverified;;
  }

  dimension: guesty_id {
    hidden: no
    label: "Guesty ID"
    type: string
    sql: ${TABLE}.externalrefs.guesty_id ;;
  }

  dimension: unit {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
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

  dimension: LCOrequestedtime {
    label: "LCO Requested Time"
    description: "Late check out requested Time"
    type: number
    sql: ${TABLE}.latecheckout.requestedtime ;;
    hidden: no
  }
  dimension: ECIrequestedtime {
    label: "ECI Requested Time"
    description: "early check in requested Time"
    type: string
    sql: ${TABLE}.earlycheckin.requestedtime/60
    ;;
    hidden: no
  }
  dimension: ECIrequestedststus {
    label: "ECI Status"
    type: string
    sql: ${TABLE}.earlycheckin.status ;;
    hidden: no
  }
  dimension: LCOrequestedststus {
    label: "LCO Status"
    type: string
    sql: ${TABLE}.latecheckout.status ;;
    hidden: no
  }

  measure: numLcoRequested {
    label: "Number of LCO Requested"
    description: "Number of Late Check out Requsted"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [ LCOrequestedststus: "denied,approved,requested"]
    drill_fields: [confirmationcode,LCOrequestedststus,LCOrequestedtime,status]

  }
  measure: numECIRequested{
    label: "Number of ECI Requested"
    description: "Number of Early Check in Requsted"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [ ECIrequestedststus: "denied,approved,requested"]
    drill_fields: [confirmationcode,ECIrequestedststus,ECIrequestedtime,status]

  }
  measure: numLcoRequestedApproved {
    label: "Number of LCO Approved "
    description: "Number of Late Check out Approved"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [ LCOrequestedststus: "approved"]
    drill_fields: [confirmationcode,LCOrequestedststus,LCOrequestedtime,status]

  }
  measure: numECIApproved{
    label: "Number of ECI Approved"
    description: "Number of Early Check in Approved"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [ ECIrequestedststus: "approved"]
    drill_fields: [confirmationcode,ECIrequestedststus,ECIrequestedtime,status]
  }

  measure: number_of_checkouts {
    label: "Number of Checkouts"
    description: "Number of Check-outs EXCLUDING Initial Extended Booking Checkouts"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [ initial_booking: "no", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }
  measure: number_of_checkins {
    label: "Number of Checkins"
    description: "Number of Check-ins EXCLUDING Extensions"
    type: count_distinct
    sql: CONCAT(${_id},${confirmationcode}) ;;
    filters: [ extended_booking: "no", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]

  }


  measure: num_reservations {
    label: "Num Reservations"
    description: "Number of unique reservations. This metric will only consider confirmed / checked in bookings. Also, this includes extended bookings as a SEPARATE booking."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "confirmed, checked_in",units._id: "-null"]
    drill_fields: [reservation_details*]
  }
  measure: kbc_completed {
    label: "Num of Guests Completed KBC"
    group_label: "KBC"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [submittedat_date:  "-null"]
    drill_fields: [reservation_details*]
  }
  measure: kbc_Notompleted {
    label: "Num of Guests did Not Completed KBC"
    group_label: "KBC"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [submittedat_date: "NULL"]
    drill_fields: [reservation_details*]
  }
  measure: guestisverified {
    label: "Num of Guests verified"
    group_label: "KBC"
    type: count_distinct
    sql: ${confirmationcode};;
    filters: [guestisverifiedyesno: "yes"]
    drill_fields: [reservation_details*]
  }

  measure: kbc_ompletedInAdvance{
    label: "Num of Guests Completed KBC 24 hrs pre Checkin"
    group_label: "KBC"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [kbc_completed_inadvance: "Yes"]
    drill_fields: [reservation_details*]
  }
  measure: kbc_ompletedPost{
    label: "Num of Guests Completed KBC 24 hrs post Booking"
    group_label: "KBC"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [kbc_completed_postBooking: "Yes"]
    drill_fields: [reservation_details*]
  }


  set:reservation_details {
    fields: [confirmationcode, status, source, checkindate_date, checkoutdate_date, bookingdate_date]
  }
}
