view: reservations_clean {
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

  dimension: sourcedetail {
    type: string
    sql: ${TABLE}.sourcedetail ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.property ;;
  }

  dimension_group: bookingdate {
    # view_label: "Date Dimensions"
    # group_label: "Booking Date"
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

  dimension_group: review_date {
    # view_label: "Date Dimensions"
    # group_label: "All Reviews Date"
    label: "Review"
    description: "If Airbnb Review Present, this date will reflect the Airbnb Review. Otherwise, date is grabbed from Post-Checkout Data"
    type: time
    # datatype: date
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql:  case
    when ${airbnb_reviews.review_raw} is not NULL then ${airbnb_reviews.review_raw}
    when cast(${post_checkout_data.review_raw} as Date) is not NULL AND ${airbnb_reviews.review_raw} IS NULL then Cast(${post_checkout_data.review_raw} as Date)
    else NULL
    end;;
    #sql: coalesce(${airbnb_reviews.review_raw},CAST(${post_checkout_data.review_raw} as DATE),${booking_reviews.review_raw}) ;;
  }

  dimension: preceding_cleaning_task {
    hidden: no
    type: string
    description: "This will pull the BW task prior to the stay"
    sql: ${TABLE}.precedingcleaningtask ;;
  }

  # dimension: lead_time {
  #   type:  number
  #   sql:  date_diff(CAST(${checkindate} as DATE), CAST(${TABLE}.bookingdate as DATE), DAY) ;;
  # }


  # dimension: length_of_stay {
  #   type:  number
  #   sql:  date_diff(CAST(${checkoutdate} as DATE), CAST(${checkindate} as DATE), DAY) ;;
  # }

  # measure: avg_lead_time {
  #   view_label: "Metrics"
  #   description: "Days between booking and checking in"
  #   value_format: "0.0"
  #   type:  average
  #   sql: ${lead_time};;
  #   drill_fields: [reservation_details*]
  # }

  # measure: median_lead_time {
  #   view_label: "Metrics"
  #   description: "Days between booking and checking in"
  #   value_format: "0.0"
  #   type:  median
  #   sql: ${lead_time};;
  #   drill_fields: [reservation_details*]
  # }

  # measure: avg_length_of_stay {
  #   view_label: "Metrics"
  #   description: "Number of days of stay"
  #   value_format: "0.0"
  #   type:  average
  #   sql: ${length_of_stay};;
  #   drill_fields: [reservation_details*]
  # }

  # measure: median_length_of_stay {
  #   view_label: "Metrics"
  #   description: "Number of days of stay"
  #   value_format: "0.0"
  #   type:  median
  #   sql: ${length_of_stay};;
  #   drill_fields: [reservation_details*]
  # }


  dimension: bring_pets {
    type: yesno
    sql: ${TABLE}.bringingpets ;;
  }

  dimension: call_box_code {
    type: string
    sql: ${TABLE}.callboxcode ;;
  }

  dimension_group: cancellation_date {
    # view_label: "Date Dimensions"
    # group_label: "Reservation Cancellation Date"
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

  dimension: cards {
    hidden: yes
    sql: ${TABLE}.cards ;;
  }

  dimension: chargelogs {
    hidden: yes
    sql: ${TABLE}.chargelogs ;;
  }

  dimension_group: checkindate {
    type: time
    timeframes: [raw, date, month, year, quarter]
    label: "Reservation Check-In"
    sql: CAST(${TABLE}.checkindate as TIMESTAMP);;
  }

  dimension_group: checkoutdate {
    label: "Reservation Check-Out"
    type: time
    timeframes: [raw, date, month, year, quarter]
    sql: CAST(${TABLE}.checkoutdate as TIMESTAMP);;
  }

  dimension: confirmation_code {
    type: string
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }

  dimension_group: created_date {
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

  dimension: early_check_in {
    hidden: yes
    sql: ${TABLE}.earlycheckin ;;
  }

  dimension: external_refs {
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

  dimension: key_cafe_access {
    hidden: yes
    sql: ${TABLE}.keycafeaccess ;;
  }

  dimension: license_plate {
    type: string
    sql: ${TABLE}.licenseplate ;;
  }

  dimension: listingg_address {
    type: string
    sql: ${TABLE}.listingaddress ;;
  }

  dimension: listing_name {
    type: string
    sql: ${TABLE}.listingname ;;
  }

  dimension: maybe_bringing_pets_despite_ban {
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

  dimension: number_of_pets {
    type: number
    sql: ${TABLE}.numberofpets ;;
  }

  dimension: parking_space_needed {
    type: yesno
    sql: ${TABLE}.parkingspaceneeded ;;
  }

  dimension: pet_description {
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

  dimension: pet_type {
    type: string
    sql: ${TABLE}.pettype ;;
  }

  dimension: planned_arrival {
    type: string
    sql: ${TABLE}.plannedarrival ;;
  }

  dimension: planned_departure {
    type: string
    sql: ${TABLE}.planneddeparture ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: signed_doc {
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

  dimension: special_request {
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

  dimension: terms_accepted {
    hidden: yes
    type: yesno
    sql: ${TABLE}.termsaccepted ;;
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

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }

  # measure: num_reservations {
  #   view_label: "Metrics"
  #   label: "Num Reservations"
  #   description: "Number of unique reservations"
  #   type: count_distinct
  #   sql: ${confirmationcode} ;;
  #   drill_fields: [reservation_details*]
  # }

  measure: OQS {
    label: "Overall Quality Score (OQS)"
    view_label: "Metrics"
    group_label: "OQS Metrics"
    type: number
    value_format: "0%"
    sql: (ifnull((${airbnb_reviews.overall_quality_score} * ${airbnb_reviews.count}),0) +  ifnull((${post_checkout_data.direct_oqs} * ${post_checkout_data.count_direct_reviews}),0)
    + ifnull((${post_checkout_data.expedia_oqs} * ${post_checkout_data.count_expedia_reviews}),0) + ifnull((${post_checkout_data.booking_oqs} * ${post_checkout_data.count_booking_reviews}),0))
    / nullif((ifnull(${airbnb_reviews.count},0) + ifnull(${post_checkout_data.count_direct_reviews},0) + ifnull(${post_checkout_data.count_expedia_reviews},0) + ifnull(${post_checkout_data.count_booking_reviews},0)),0);;
  }

  measure: count_total {
    type: number
    label: "Total Reviews"
    value_format: "0"
    sql: ${airbnb_reviews.count} + ${post_checkout_data.count_direct_reviews} + ${post_checkout_data.count_expedia_reviews} + ${post_checkout_data.count_booking_reviews} ;;
  }

  set:reservation_details {
    fields: [confirmation_code, status, source, checkindate_date, checkoutdate_date, bookingdate_date]
  }
}

# view: reservations__notes__value {
#   dimension: _id {
#     type: string
#     sql: ${TABLE}._id ;;
#   }
#
#   dimension: kind {
#     type: string
#     sql: ${TABLE}.kind ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: reservations__earlycheckin {
#   dimension: approvedtime {
#     type: number
#     sql: ${TABLE}.approvedtime ;;
#   }
#
#   dimension: requestedtime {
#     type: number
#     sql: ${TABLE}.requestedtime ;;
#   }
#
#   dimension: requestnote {
#     type: string
#     sql: ${TABLE}.requestnote ;;
#   }
#
#   dimension: status {
#     type: string
#     sql: ${TABLE}.status ;;
#   }
# }
#
# view: reservations__keycafeaccess {
#   dimension: accesscode {
#     type: string
#     sql: ${TABLE}.accesscode ;;
#   }
#
#   dimension: accessid {
#     type: string
#     sql: ${TABLE}.accessid ;;
#   }
# }
#
# view: reservations__petfeescard {
#   dimension_group: submittedat {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.submittedat ;;
#   }
#
#   dimension: wasprovided {
#     type: yesno
#     sql: ${TABLE}.wasprovided ;;
#   }
# }
#
#
# view: reservations__additionalguests__value {
#   dimension: _id {
#     type: string
#     sql: ${TABLE}._id ;;
#   }
#
#   dimension: email {
#     type: string
#     sql: ${TABLE}.email ;;
#   }
#
#   dimension: name {
#     type: string
#     sql: ${TABLE}.name ;;
#   }
# }
#
# view: reservations__cards__value__usefor {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: reservations__cards__value {
#   dimension: _id {
#     type: string
#     sql: ${TABLE}._id ;;
#   }
#
#   dimension: card {
#     type: string
#     sql: ${TABLE}.card ;;
#   }
#
#   dimension: usefor {
#     hidden: yes
#     sql: ${TABLE}.usefor ;;
#   }
# }
#
# view: reservations__chargelogs {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: reservations__externalrefs {
#   dimension: guesty_id {
#     type: string
#     sql: ${TABLE}.guesty_id ;;
#   }
#
#   dimension: stripecardid {
#     type: string
#     sql: ${TABLE}.stripecardid ;;
#   }
# }
#
# view: reservations__notes {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: reservations__additionalguests {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: reservations__cards {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
