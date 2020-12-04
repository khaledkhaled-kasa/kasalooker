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

  dimension: _id {
    type: string
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
    type: number
    sql: ${TABLE}.overallrating ;;
  }

  dimension: overallratingstandardized {
    type: number
    sql: ${TABLE}.overallratingstandardized ;;
  }

  dimension: review_tags {
    type: string
    sql: ${TABLE}.review_tags ;;
  }

  measure: Rating {
    type:  average
    sql: ${TABLE}.overallratingstandardized ;;
  }

  dimension: privatereviewtext {
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
    sql: ${TABLE}.target ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
