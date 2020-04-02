view: reservations {
  sql_table_name: `bigquery-analytics-272822.mongo.reservations`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: additionalguests {
    hidden: yes
    sql: ${TABLE}.additionalguests ;;
  }

  dimension_group: bookingdate {
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

  dimension: bringingpets {
    type: yesno
    sql: ${TABLE}.bringingpets ;;
  }

  dimension: callboxcode {
    type: string
    sql: ${TABLE}.callboxcode ;;
  }

  dimension_group: cancellationdate {
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
    type: string
    sql: ${TABLE}.checkindatelocal ;;
  }

  dimension: checkoutdate {
    type: string
    sql: ${TABLE}.checkoutdatelocal ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
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

  dimension: guestid {
    type: string
    sql: ${TABLE}.guestid ;;
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
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }

  measure: reservation_night {
    view_label: "Metrics"
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${financials.night_date});;
    drill_fields: [financials.night_date, reservation_details*]
  }

  measure: num_reservations {
    type: count_distinct
    sql: ${confirmationcode} ;;
    drill_fields: [reservation_details*]
  }

  measure: occupancy {
    type: number
    value_format: "0.00%"
    sql:  ${reservation_night} / ${capacities_rolled.capacity_measure} ;;
    drill_fields: [financials.night_date, reservation_details*]

  }

  set:reservation_details {
    fields: [confirmationcode, status, source, checkindate, checkoutdate]
  }
}

view: reservations__notes__value {
  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: kind {
    type: string
    sql: ${TABLE}.kind ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: reservations__earlycheckin {
  dimension: approvedtime {
    type: number
    sql: ${TABLE}.approvedtime ;;
  }

  dimension: requestedtime {
    type: number
    sql: ${TABLE}.requestedtime ;;
  }

  dimension: requestnote {
    type: string
    sql: ${TABLE}.requestnote ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: reservations__keycafeaccess {
  dimension: accesscode {
    type: string
    sql: ${TABLE}.accesscode ;;
  }

  dimension: accessid {
    type: string
    sql: ${TABLE}.accessid ;;
  }
}

view: reservations__petfeescard {
  dimension_group: submittedat {
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
    sql: ${TABLE}.submittedat ;;
  }

  dimension: wasprovided {
    type: yesno
    sql: ${TABLE}.wasprovided ;;
  }
}

view: reservations__apis {
  dimension: guesty_reservation {
    type: string
    sql: ${TABLE}.guesty_reservation ;;
  }
}

view: reservations__additionalguests__value {
  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: reservations__cards__value__usefor {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: reservations__cards__value {
  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: card {
    type: string
    sql: ${TABLE}.card ;;
  }

  dimension: usefor {
    hidden: yes
    sql: ${TABLE}.usefor ;;
  }
}

view: reservations__chargelogs {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: reservations__externalrefs {
  dimension: guesty_id {
    type: string
    sql: ${TABLE}.guesty_id ;;
  }

  dimension: stripecardid {
    type: string
    sql: ${TABLE}.stripecardid ;;
  }
}

view: reservations__notes {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: reservations__additionalguests {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: reservations__cards {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}
