view: reservations_kustomer {
  label: "Reservations"
  sql_table_name: `bigquery-analytics-272822.mongo.reservations`
  ;;

  dimension: _id {
    hidden: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: additionalguests {
    hidden: yes
    sql: ${TABLE}.additionalguests ;;
  }

  dimension_group: booking {
    hidden: no
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
    sql:  date_diff(${checkin_date}, CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  }

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(${checkout_date}, ${checkin_date}, DAY) ;;
  }


  dimension: length_of_stay_type {
    label: "Length of Stay (Short-term/Long-term)"
    description: "Short-term stays are stays with < 28 nights; whereas long-term stays are >= 28 nights"
    type:  string
    sql:  CASE WHEN ${length_of_stay} < 28 THEN "Short-term stay"
          WHEN ${length_of_stay} >= 28 THEN "Long-term stay"
          END ;;
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
    hidden: yes
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


  dimension_group: checkin {
    type: time
    hidden: no
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.checkindate as TIMESTAMP);;

  }


  dimension_group: checkout {
    type: time
    hidden: no
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
    hidden: yes
    sql: ${TABLE}.listingaddress ;;
  }

  dimension: listingname {
    type: string
    hidden: yes
    sql: ${TABLE}.listingname ;;
  }

  dimension: maybebringingpetsdespiteban {
    type: yesno
    sql: ${TABLE}.maybebringingpetsdespiteban ;;
  }

  dimension: nickname {
    type: string
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

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
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

  dimension: specialrequest {
    type: string
    sql: ${TABLE}.specialrequest ;;
  }

  dimension: property {
    type: string
    hidden: yes
    sql: ${TABLE}.property ;;
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

  measure: total_reservations {
    description: "Total Reservations (with a status of Confirmed or Checked-In"
    type: count
    # sql: ${confirmationcode} ;;
    filters: [status: "confirmed, checked_in"]
  }



  set:reservation_details {
    fields: [confirmationcode, status, source, checkin_date, checkout_date, booking_date]
  }

}
