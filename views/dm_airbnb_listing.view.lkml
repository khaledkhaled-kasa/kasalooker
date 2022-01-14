# The name of this view in Looker is "Dm Airbnb Listing"

view: dm_airbnb_listing {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `data-warehouse-333815.Warehouse.dmAirbnbListing`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Booking Channel" in Explore.

  dimension: booking_channel {
    label: "Booking Channel"
    type: string
    sql: ${TABLE}.bookingChannel ;;
  }

  dimension: first_page_impression_rt {
    label: "First Page Impression Rate"
    type: number
    sql: ${TABLE}.firstPageImpressionRt ;;
  }

  dimension: reservation_source_channel {
    label: "Reservation Source Channel"
    type: string
    sql: ${TABLE}.reservationSourceChannel ;;
  }
  # dimension: first_page_search_impressions_ct {
  #   type: number
  #   sql: ${TABLE}.firstPageSearchImpressionsCt ;;
  # }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: total_first_page_search_impressions_ct {
    label: "First Page Search Impressions Count"
    type: number
    sql: ${TABLE}.firstPageSearchImpressionsCt ;;
  }

  # measure: average_first_page_search_impressions_ct {
  #   type: average
  #   sql: ${first_page_search_impressions_ct} ;;
  # }

  measure: night_stay_ct {
    label: "Num ReservationNights"
    type: sum
    sql: ${TABLE}.nightStayCt ;;
  }

  dimension: page_views_ct {
    label: "Page View Count"
    type: number
    sql: ${TABLE}.pageViewsCt ;;
  }

  dimension: prop_unit_cd {
    hidden: yes
    label: "Unit"
    type: string
    sql: ${TABLE}.propUnitCd ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: record_dt {
    label: "Airbnb Listing Visibility"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.recordDt ;;
  }

  dimension: record_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.recordId ;;
  }

  measure: reservation_cancel_ct {
    label: "Num Reservations (Canceled)"
    type: sum
    sql: ${TABLE}.reservationCancelCt ;;
  }

  measure: reservation_ct {
    label: "Num Reservations"
    type: sum
    sql: ${TABLE}.reservationCt ;;
  }

  measure: room_revenue {
    label: "Amount"
    type: sum
    sql: ${TABLE}.roomRevenue ;;
  }

  measure: ADR {
    label: "ADR"
    description: "Average Daily Rate"
    type: number
    sql: ${room_revenue} / NULLIF(${night_stay_ct}, 0) ;;
  }

  dimension: unit_id {
    type: string
    hidden: yes
    sql: ${TABLE}.unitId ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: []
  # }
}
