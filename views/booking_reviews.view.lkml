view: booking_reviews {
  sql_table_name: `bigquery-analytics-272822.overall_quality_score.booking_reviews`
    ;;

  dimension: _5_star_rating {
    type: number
    sql: ${TABLE}._5_star_Rating ;;
  }

  measure: _5_star_rating_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}._5_star_Rating ;;
  }

  dimension: building {
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: building_address {
    type: string
    sql: ${TABLE}.Building_Address ;;
  }

  dimension: negatives {
    type: string
    sql: ${TABLE}.Negatives ;;
  }

  dimension: normalized_score {
    type: number
    sql: ${TABLE}.Normalized_Score ;;
  }

  measure: normalized_score_avg {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Normalized_Score ;;
  }

  dimension: positives {
    type: string
    sql: ${TABLE}.Positives ;;
  }

  dimension: primary_key {
    type: number
    sql: ${TABLE}.Primary_Key ;;
    primary_key: yes
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.Rating ;;
  }

  dimension_group: review {
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
    sql: ${TABLE}.Review_Date ;;
  }

  #dimension: review_month {
  #  type: string
  #  sql: ${TABLE}.Review_Month ;;
  #}

  dimension: room_type {
    type: string
    sql: ${TABLE}.Room_Type ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.Title ;;
  }

  measure: overall_quality_score {
    type:  number
    value_format: "0%"
    sql: (${_5_star_rating_avg} - 4.05) /(4.57-4.05) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
