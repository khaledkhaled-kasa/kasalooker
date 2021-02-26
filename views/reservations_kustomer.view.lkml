view: reservations_kustomer {
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

  dimension_group: bookingdate {
    view_label: "Date Dimensions"
    hidden: yes
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
    sql:  date_diff(CAST(${TABLE}.checkindate as DATE), CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  }

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(CAST(${TABLE}.checkoutdate as DATE), CAST(${TABLE}.checkindate as DATE), DAY) ;;
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

  dimension: checkindate_local {
    type: date
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
    convert_tz: no
  }


  dimension_group: reservation_checkin {
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
    sql: CAST(${TABLE}.checkindate as TIMESTAMP);;
  }

  dimension: checkoutdate_local {
    type: date
    sql: CAST(${TABLE}.checkoutdatelocal as TIMESTAMP);;
    convert_tz: no
  }

  dimension_group: reservation_checkout {
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



  set:reservation_details {
    fields: [confirmationcode, status, source, checkindate_local, checkoutdate_local, bookingdate_date]
  }

}
