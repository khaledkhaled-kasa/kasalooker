view: google_review_tracker {
  sql_table_name:`bigquery-analytics-272822.Gsheets.google_review_tracker`
      ;;


  dimension: review_date {
    type: date
    datatype: date
    sql: ${TABLE}.Review_Date ;;
  }
dimension: id {
  type: string
  sql: concat(${review_date},${name},${property})  ;;
  primary_key: yes
  hidden: yes
}

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.Score ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }
measure: count {
  type: count_distinct
  sql: ${id} ;;
  drill_fields: [detail*]
}

  set: detail {
    fields: [review_date, property, name, score, type]
  }
}
