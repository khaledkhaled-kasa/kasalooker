view: reservations_audit {
  sql_table_name: `bigquery-analytics-272822.dbt.reservations_v3`  ;;

  dimension: confirmationcode {
    label: "Confirmation Code"
    type: string
    primary_key: yes
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }

  dimension: guest_type {
    hidden: no
    type: string
    sql: ${TABLE}.guest_type ;;
  }


  dimension: _id {
    hidden: no
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: additionalguests {
    hidden: yes
    sql: ${TABLE}.additionalguests ;;
  }


  dimension_group: bookingdate {
    view_label: "Date Dimensions"
    group_label: "Booking Date"
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
  }

  dimension: lead_time {
    type:  number
    sql:  date_diff(${checkindate_date}, CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  }

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(${checkoutdate_date}, ${checkindate_date}, DAY) ;;
  }

  dimension: bringingpets {
    type: yesno
    sql: ${TABLE}.bringingpets ;;
  }

  dimension: callboxcode {
    type: string
    sql: ${TABLE}.callboxcode ;;
  }

  dimension_group: cancellationdate {
    view_label: "Date Dimensions"
    group_label: "Cancellation Date"
    label: ""
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

  dimension: cards {
    hidden: yes
    sql: ${TABLE}.cards ;;
  }

  dimension: chargelogs {
    hidden: yes
    sql: ${TABLE}.chargelogs ;;
  }


  dimension_group: checkindate {
    view_label: "Date Dimensions"
    group_label: "Checkin Date"
    label: "Checkin"
    type: time
    hidden: no
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      hour_of_day
    ]
    sql: TIMESTAMP(${TABLE}.checkindate);;
  }


  dimension_group: checkoutdate {
    type: time
    view_label: "Date Dimensions"
    group_label: "Checkout Date"
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
    sql: TIMESTAMP(${TABLE}.checkoutdate);;
  }


  dimension_group: created {
    view_label: "Date Dimensions"
    group_label: "Created Date"
    hidden:  no
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
    sql: ${TABLE}.createdat ;;
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

  dimension: guestscount {
    type: number
    sql: ${TABLE}.guestscount ;;
  }

  dimension: keycafeaccess {
    hidden: yes
    sql: ${TABLE}.keycafeaccess ;;
  }

  dimension: licenseplate {
    type: string
    sql: ${TABLE}.licenseplate ;;
  }

  dimension: listingaddress {
    type: string
    sql: ${TABLE}.listingaddress ;;
  }

  dimension: listingname {
    type: string
    hidden: yes
    sql: ${TABLE}.listingname ;;
  }

  dimension: maybebringingpetsdespiteban {
    type: yesno
    hidden: yes
    sql: ${TABLE}.maybebringingpetsdespiteban ;;
  }

  dimension: nickname {
    type: string
    hidden: yes
    sql: ${TABLE}.nickname ;;
  }

  dimension: notes {
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  dimension: numberofpets {
    type: number
    sql: ${TABLE}.numberofpets ;;
  }

  dimension: parkingspaceneeded {
    type: yesno
    sql: ${TABLE}.parkingspaceneeded ;;
  }

  dimension: petdescription {
    type: string
    hidden: yes
    sql: ${TABLE}.petdescription ;;
  }

  dimension: petfeescard {
    hidden: yes
    sql: ${TABLE}.petfeescard ;;
  }

  dimension: pets {
    type: yesno
    sql: ${TABLE}.pets ;;
  }

  dimension: pettype {
    type: string
    sql: ${TABLE}.pettype ;;
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

  dimension: smartlockcodeisset {
    type: yesno
    sql: ${TABLE}.smartlockcodeisset ;;
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
    type: string
    hidden: yes
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

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }


  dimension: suspicious {
    type: yesno
    sql: ${TABLE}.suspicious ;;
  }

  dimension: termsaccepted {
    type: yesno
    sql: ${TABLE}.termsaccepted ;;
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

  dimension_group: updatedat {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedat ;;
  }


  dimension: financial_night_part_of_res {
    type:  yesno
    hidden: no
    sql: ${financials_audit.night_date} < ${checkoutdate_date} and
      ${financials_audit.night_date} >= ${checkindate_date};;
  }

  measure: guestscount_sum {
    label: "Total Number of Guests"
    view_label: "Metrics"
    description: "Total number of guests for the reservation(s) filtered for only confirmed / checked in bookings."
    type: sum
    sql: guestscount ;;
    filters: [status: "confirmed, checked_in"]
  }

  measure: avg_length_of_stay {
    view_label: "Metrics"
    label: "Average Length of Stay"
    description: "Number of days of stay filtered for only confirmed / checked in bookings."
    value_format: "0.0"
    type:  average
    sql: ${length_of_stay};;
    filters: [status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]
  }

  measure: median_length_of_stay {
    view_label: "Metrics"
    label: "Median Length of Stay"
    description: "Number of days of stay filtered for only confirmed / checked in bookings."
    value_format: "0.0"
    type:  median
    sql: ${length_of_stay};;
    filters: [status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]
  }

# - These numbers may be slightly higher than the Kasametrics model as they are also taking into account reservations that aren't mapped to units / active units
  measure: reservation_night {
    view_label: "Metrics"
    label: "Num ReservationNights"
    description: "Reservation night stay filtered for only confirmed / checked in bookings."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${financials_audit.night_date});;
    filters: [financial_night_part_of_res: "yes", status: "confirmed, checked_in"]
    drill_fields: [financials_audit.night_date, reservation_details*]
  }

  measure: reservation_night_canceled {
    view_label: "Metrics"
    label: "Num ReservationNights (Canceled)"
    description: "Reservation night stay for canceled bookings"
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${financials_audit.night_date});;
    filters: [status: "canceled, cancelled"]
    drill_fields: [financials_audit.night_date, reservation_details*]
  }

# - These numbers may be slightly higher than the Kasametrics model as they are also taking into account reservations that aren't mapped to units / active units
  measure: num_reservations {
    view_label: "Metrics"
    label: "Num Reservations"
    description: "Number of unique reservations (confirmed / checked in bookings)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]
  }


  measure: num_reservations_canceled {
    view_label: "Metrics"
    label: "Num Reservations (Canceled)"
    description: "Number of unique reservations for canceled bookings"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "canceled, cancelled"]
    drill_fields: [reservation_details*]
  }


  set:reservation_details {
    fields: [confirmationcode, status, sourcedata_channel, bookingdate_date]
  }

}
