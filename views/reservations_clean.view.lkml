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

  dimension: length_of_stay {
    type:  number
    sql:  date_diff(${checkoutdate_date}, ${checkindate_date}, DAY) ;;
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

  # dimension_group: review_date {
  #   label: "Review"
  #   description: "If Airbnb Review Present, this date will reflect the Airbnb Review. Otherwise, date is grabbed from Post-Checkout Data"
  #   type: time
  #   datatype: date
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql:  case
  #   when ${airbnb_reviews.review_raw} is not NULL then ${airbnb_reviews.review_raw}
  #   when cast(${post_checkout_data.review_raw} as Date) is not NULL AND ${airbnb_reviews.review_raw} IS NULL then Cast(${post_checkout_data.review_raw} as Date)
  #   else NULL
  #   end;;
  #   #sql: coalesce(${airbnb_reviews.review_raw},CAST(${post_checkout_data.review_raw} as DATE),${booking_reviews.review_raw}) ;;
  # }

  dimension: preceding_cleaning_task {
    hidden: no
    type: string
    description: "This will pull the BW task prior to the stay"
    sql: ${TABLE}.precedingcleaningtask ;;
  }


  dimension: bring_pets {
    type: yesno
    sql: ${TABLE}.bringingpets ;;
  }

  dimension: call_box_code {
    type: string
    sql: ${TABLE}.callboxcode ;;
  }

  dimension_group: cancellation_date {
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

  dimension: confirmation_code {
    type: string
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }


  dimension: guests_count {
    type: number
    sql: ${TABLE}.guestscount ;;
  }

  dimension: number_of_pets {
    type: number
    sql: ${TABLE}.numberofpets ;;
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
    type: string
    sql: ${TABLE}.source ;;
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


  measure: OQS {
    label: "Overall Quality Score (OQS)"
    # view_label: "Metrics"
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
