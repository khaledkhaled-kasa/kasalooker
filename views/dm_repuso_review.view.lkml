# The name of this view in Looker is "Dm Repuso Review"
view: dm_repuso_review {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `data-warehouse-333815.Warehouse.dmRepusoReview`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Channel" in Explore.

  dimension: channel {
    label: "Review Channel"
    description: "Source for the review"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: guest_nm {
    hidden: yes
    type: string
    label: "Guest Name"
    sql: ${TABLE}.guestNm ;;
  }

  dimension: overall_rt {
    hidden: yes
    type: number
    sql: ${TABLE}.overallRt ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_overall_rt {
    label: "Overall Rating"
    description: "Guest rating."
    type: sum
    sql: ${overall_rt} ;;
  }

  measure: average_overall_rt {
    hidden: yes
    type: average
    sql: ${overall_rt} ;;
  }

  dimension: property {
    type: string
    label: "Repuso Property Name"
    sql: ${TABLE}.property ;;
  }

  dimension: rating_scale {
    hidden: yes
    type: number
    sql: ${TABLE}.ratingScale ;;
  }

  measure: total_rating_scale {
    label: "Rating Scale"
    description: "Base of the score, total points available"
    type: sum
    sql: ${TABLE}.ratingScale ;;
  }

  measure: review_score_rt {
    label: "Review Score %"
    description: "Ratio of 'Overall Rating'/'Rating Scale'"
    type: number
    value_format: "0.0%"
    sql: ${total_overall_rt} / ${total_rating_scale} ;;
  }

  dimension: record_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.recordId ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: review_dt {
    label: "Review Date"
    description: "Date at which guest wrote the review."
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
    sql: ${TABLE}.reviewDt ;;
  }

  dimension: review_text {
    label: "Review Text"
    description: "Guest free form text"
    type: string
    sql: ${TABLE}.reviewText ;;
  }

  measure: count {
    label: "Review Count"
    description: "Count of reviews"
    type: count
    drill_fields: []
  }

  dimension: prop_cd {
    label: "Property Short"
    type: string
    sql: ${TABLE}.propCd ;;
  }
}
