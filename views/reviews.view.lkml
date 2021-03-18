# view: reviews {
#   sql_table_name: `bigquery-analytics-272822.mongo.reviews`
#     ;;

  view: reviews {
    derived_table: {
      sql:
      with t3 as (
        with t2 as (
            with t1 as
           (SELECT * FROM mongo.reviews, UNNEST(reviewtags))
            select _id as _id2, value
            from t1)
        select * from mongo.reviews
        left join t2
        on reviews._id = t2._id2)
      select reviewbykasa, reservation, overallratingstandardized, submitdate, _id, target, unit, guest, channel, overallrating, privatereviewtext,
      string_agg(value order by value) as review_tags
      from t3
      group by 1,2,3,4,5,6,7,8,9,10,11;;
    }

  # dimension: __v {
  #   type: number
  #   sql: ${TABLE}.__v ;;
  # }

view_label: "Check-In Survey Data"

  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }


  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: guest {
    type: string
    sql: ${TABLE}.guest ;;
  }

  dimension: overallrating {
    label: "Overall Rating"
    hidden: yes
    type: number
    sql: ${TABLE}.overallrating ;;
  }

  dimension: overallratingstandardized {
    description: "Overall Rating (Standardized)"
    label: "Overall Rating (Standardized)"
    type: number
    sql: ${TABLE}.overallratingstandardized ;;
  }

  dimension: review_tags {
    type: string
    sql: ${TABLE}.review_tags ;;
  }

  measure: avg_rating {
    type:  average
    value_format: "0.0"
    label: "Averaage Real-time Review Rating"
    sql: ${TABLE}.overallratingstandardized ;;
  }

  measure: count_thumbs_up {
    type: count
    hidden: yes
    view_label: "Metrics"
    filters: [overallratingstandardized: "10"]
  }

    measure: percent_thumbs_up {
      type: number
      label: "% Thumbs Up"
      value_format: "0%"
      sql: ${count_thumbs_up} / nullif(${count},0) ;;
    }

  dimension: privatereviewtext {
    label: "Private Revew Text"
    type: string
    sql: ${TABLE}.privatereviewtext ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: reviewbykasa {
    type: yesno
    sql: ${TABLE}.reviewbykasa ;;
  }

  dimension_group: submitdate {
    label: "Real-time Review"
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
    sql: ${TABLE}.submitdate ;;
  }

  dimension: target {
    type: string
    label: "Type"
    sql: ${TABLE}.target ;;
  }

  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
  }

  measure: count {
    label: "Review Count"
    type: count_distinct
    sql: ${reservation};;
    drill_fields: [reservations_clean.confirmation_code]
  }
}
