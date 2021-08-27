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



  dimension: length_of_stay_type {
    label: "Length of Stay (Short-term/Long-term)"
    description: "Short-term stays are stays with < 28 nights; whereas long-term stays are >= 28 nights"
    type:  string
    sql:  CASE WHEN ${length_of_stay} < 28 THEN "Short-term stay"
          WHEN ${length_of_stay} >= 28 THEN "Long-term stay"
          END ;;
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

  dimension: unit {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: initial_booking {
    label: "Initial Booking (For Extensions Only)"
    description: "This will inform us if it's the original / initial booking of an extended stay. Will only show as Yes for the initial booking of an extended reservation."
    type: yesno
    sql: ${TABLE}.initial_booking = 1 ;;
  }

  measure: number_of_checkouts {
    label: "Number of Checkouts"
    description: "Number of Check-outs EXCLUDING Initial Extended Booking Checkouts"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [ initial_booking: "no", status: "confirmed, checked_in"]
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



  set:reservation_details {
    fields: [confirmationcode, status, source, checkindate_date, checkoutdate_date, bookingdate_date]
  }
}
