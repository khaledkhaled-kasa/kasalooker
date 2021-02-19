view: reservations_audit {
  sql_table_name: `bigquery-analytics-272822.mongo.reservations`
    ;;


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

  measure: guestscount_sum {
    label: "Total Number of Guests"
    view_label: "Metrics"
    type: sum
    sql: guestscount ;;
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
    sql:  date_diff(CAST(${checkindate} as DATE), CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  }

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(CAST(${checkoutdate} as DATE), CAST(${checkindate} as DATE), DAY) ;;
  }

  measure: avg_lead_time {
    view_label: "Metrics"
    description: "Days between booking and checking in"
    value_format: "0.0"
    type:  average
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
  }

  measure: median_lead_time {
    view_label: "Metrics"
    description: "Days between booking and checking in"
    value_format: "0.0"
    type:  median
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
  }

  measure: avg_length_of_stay {
    view_label: "Metrics"
    description: "Number of days of stay"
    value_format: "0.0"
    type:  average
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
  }

  measure: median_length_of_stay {
    view_label: "Metrics"
    description: "Number of days of stay"
    value_format: "0.0"
    type:  median
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
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

  dimension: checkindate {
    type: date
    hidden: yes
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
  }


  dimension_group: reservation_checkin {
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
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
  }

  dimension: checkoutdate {
    hidden: yes
    type: date
    sql: CAST(${TABLE}.checkoutdatelocal as TIMESTAMP);;
  }

  dimension_group: reservation_checkout {
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
    sql: CAST(${TABLE}.checkoutdatelocal as TIMESTAMP);;
  }

  dimension: confirmationcode {
    type: string
    primary_key: yes
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }

  dimension_group: createdat {
    hidden:  yes
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

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
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

  dimension: status_booked{
    description: "Was this night booked?"
    type: yesno
    sql: ${TABLE}.status IN ("confirmed","checked_in");;

  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: sourcedetail {
    type: string
    sql: ${TABLE}.sourcedetail ;;
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

  measure: reservation_night {
    view_label: "Metrics"
    label: "Num ReservationNights"
    description: "Reservation night stay"
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${financials_audit.night_date});;
    filters: [financial_night_part_of_res: "yes", status: "confirmed, checked_in"]
    drill_fields: [financials_audit.night_date, reservation_details*]
  }

  measure: reservation_night_canceled {
    view_label: "Metrics"
    label: "Num ReservationNights (Cancelled)"
    description: "Reservation night stay for canceled bookings"
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${financials_audit.night_date});;
    filters: [status: "canceled"]
    drill_fields: [financials_audit.night_date, reservation_details*]
  }

  dimension: financial_night_part_of_res {
    type:  yesno
    sql: format_date('%Y-%m-%d', ${financials_audit.night_date}) < ${TABLE}.checkoutdatelocal and
      format_date('%Y-%m-%d', ${financials_audit.night_date}) >= ${TABLE}.checkindatelocal;;
  }

  measure: num_reservations {
    view_label: "Metrics"
    label: "Num Reservations"
    description: "Number of unique reservations - These numbers may be slightly higher than the Kasametrics model as they are also taking into account reservations that aren't mapped to units / active units"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [financial_night_part_of_res: "yes", status: "confirmed, checked_in"]
    drill_fields: [reservation_details*]
  }


  measure: num_reservations_canceled {
    view_label: "Metrics"
    label: "Num Reservations (Canceled)"
    description: "Number of unique reservations for canceled bookings"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "canceled"]
    drill_fields: [reservation_details*]
  }




  set:reservation_details {
    fields: [confirmationcode, status, source, checkindate, checkoutdate, bookingdate_date]
  }

}
