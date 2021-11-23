view: slack_bugs_tech {
  derived_table: {
    sql: SELECT *
      FROM `bigquery-analytics-272822.Gsheets.slack_bugs` slack_bugs
      where slack_bugs.confirmation_code is not null


       ;;

    persist_for: "1 hours"
  }

  measure: count {
    type: count
    label: "# of Bugs"
  }

  dimension: confirmation_code {
    type: string
    sql: ${TABLE}.Confirmation_Code ;;
  }

  dimension: category_on_submit {
    type: string
    sql: ${TABLE}.Category_on_Submit ;;
  }

  dimension: new_category {
    type: string
    sql: ${TABLE}.New_Category ;;
  }

  dimension: what_happened_ {
    type: string
    sql: ${TABLE}.What_happened_ ;;
  }

  dimension: what_was_the_expected_behavior_ {
    type: string
    sql: ${TABLE}.What_was_the_expected_behavior_ ;;
  }

  dimension: urgency_of_your_request {
    type: string
    sql: ${TABLE}.Urgency_of_your_request ;;
  }

  dimension_group: date_time {
    type: time
    label: ""
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
    sql: ${TABLE}.Date_Time ;;
    convert_tz: no
  }

  set: detail {
    fields: [
      confirmation_code,
      category_on_submit,
      new_category,
      what_happened_,
      what_was_the_expected_behavior_,
      urgency_of_your_request,
      date_time_time
    ]
  }
}
