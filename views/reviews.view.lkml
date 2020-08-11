view: reviews {
  sql_table_name: `bigquery-analytics-272822.mongo.reviews`
    ;;

  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
  }

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
