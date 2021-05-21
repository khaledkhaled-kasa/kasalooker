view: channel_cost_marketing {
  derived_table: {

    # This table is created to pull cancelled bookings which have / have never been rebooked
    sql: WITH financials_f1 as (
      select reservation, round(sum(amount__fl),2) amount
      from financials
      where type not IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability")
      and financials.isvalid is null or financials.isvalid = true
      and actualizedat is not null
      group by 1)

      select r1.confirmationcode confirmationcode_booking_1, r1.bookingdate bookingdate_booking_1, r1.cancellationdate cancellationdate_booking_1, r1.checkindate checkindate_booking_1, r1.checkoutdate checkoutdate_booking_1, r1.status status_booking_1, r1.sourcedata.channel source_channel_booking_1, f1.amount amount_booking_1,
      r2.confirmationcode confirmationcode_booking_2, r2.bookingdate bookingdate_booking_2, r2.checkindate checkindate_booking_2, r2.checkoutdate checkoutdate_booking_2, r2.status status_booking_2, r2.sourcedata.channel source_channel_booking_2, f2.amount amount_booking_2,
      CASE WHEN r2.confirmationcode is null THEN "No"
      ELSE "Yes"
      END rebooked
      from reservations r1
      left join reservations r2
      on (r1.unit = r2.unit
      and r2.checkindate BETWEEN r1.checkindate AND r1.checkoutdate
      and r1.bookingdate < r2.bookingdate
      and r2.status != 'canceled')
      left join financials_f1 f1 on r1._id = f1.reservation left join financials_f1 f2 on r2._id = f2.reservation
      where r1.status = 'canceled'
      and r1.confirmationcode is not null
       ;;
  }


  dimension: confirmationcode_booking_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.confirmationcode_booking_1 ;;
  }


  dimension_group: bookingdate_booking_1 {
    label: "Booking"
    hidden: yes
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
    sql: ${TABLE}.bookingdate_booking_1 ;;
  }

  dimension_group: cancellationdate_booking_1 {
    label: "Cancellation"
    hidden: yes
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
    sql: ${TABLE}.cancellationdate_booking_1 ;;
  }

  dimension_group: checkindate_1 {
    type: time
    hidden: yes
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
    sql: CAST(${TABLE}.checkindate_booking_1 as TIMESTAMP);;
  }

  dimension_group: checkoutdate_1 {
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
    sql: CAST(${TABLE}.checkoutdate_booking_1 as TIMESTAMP);;
  }

  dimension: status_booking_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.status_booking_1 ;;
  }

  dimension: source_channel_booking_1 {
    label: "Channel (Source)"
    type: string
    hidden: no
    sql: ${TABLE}.source_channel_booking_1 ;;
  }

  dimension: amount_booking_1 {
    type: number
    hidden: yes
    sql: ${TABLE}.amount_booking_1 ;;
  }

  dimension: confirmationcode_booking_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.confirmationcode_booking_2 ;;
  }

  dimension: bookingdate_booking_2 {
    type: date
    hidden: yes
    datatype: date
    sql: ${TABLE}.bookingdate_booking_2 ;;
  }

  dimension: checkindate_booking_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.checkindate_booking_2 ;;
  }

  dimension: checkoutdate_booking_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.checkoutdate_booking_2 ;;
  }

  dimension: status_booking_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.status_booking_2 ;;
  }

  dimension: source_channel_booking_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.source_channel_booking_2 ;;
  }

  dimension: amount_booking_2 {
    type: number
    hidden: yes
    sql: ${TABLE}.amount_booking_2 ;;
  }

  dimension: rebooked {
    type: string
    hidden: yes
    sql: ${TABLE}.rebooked ;;
  }

  measure: count_not_rebooked {
    label: "Total Unique Cancelled Reservations Not Rebooked"
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    type: count_distinct
    sql: ${confirmationcode_booking_1} ;;
    filters: [rebooked: "No"]
  }

  measure: count_total {
    label: "Total Unique Cancelled Reservations"
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    type: count_distinct
    sql: ${confirmationcode_booking_1} ;;
  }

  measure: cancelled_not_rebooked {
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "% Cancelled Bookings not Rebooked"
    type: number
    value_format: "0.0%"
    sql: ${count_not_rebooked} / nullif(${count_total},0) ;;

  }


}

view: missing_cost_channel_metrics {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.cost_channel_dash_metrics`
      ;;
  }


  dimension: channel {
    type: string
    sql: ${TABLE}.Channel ;;
  }

  # dimension: month {
  #   type: date
  #   datatype: date
  #   sql: ${TABLE}.Month ;;
  # }

  dimension_group: month {
    label: ""
    hidden: no
    type: time
    timeframes: [
      month,
      month_name,
      quarter,
      year
    ]
    sql: TIMESTAMP(${TABLE}.month) ;;
    convert_tz: no
  }

  dimension: metric {
    type: string
    sql: ${TABLE}.Metric ;;
  }

  dimension: value {
    type: number
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Marketing Fees (ex: TravelAds) (L3M)"
    description: "Preset from Marketing Sheet"
    value_format: "$#,##0.00"
    sql: ${TABLE}.Value ;;
  }

  measure: value_measure {
    type: max
    view_label: "Channel Cost Dashboard Metrics (Marketing)"
    label: "Marketing Fees (ex: TravelAds) (L3M)"
    description: "Preset from Marketing Sheet"
    value_format: "$#,##0.00"
    sql: coalesce(${TABLE}.Value,0) ;;
  }

}
