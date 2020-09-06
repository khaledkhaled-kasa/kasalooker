view: khaled_trial_dataset {
  sql_table_name: `bigquery-analytics-272822.airbnb_review_data.Khaled_Trial_Dataset`
    ;;

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension: occurences {
    type: number
    sql: ${TABLE}.Occurences ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: top_name {
    type: string
    sql: ${TABLE}.Top_Name ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: count {
    type: count
    drill_fields: [top_name]
  }

  measure: avg_occurences {
    type: average
    value_format: "0.00"
    sql: ${TABLE}.Occurences ;;
  }
}
