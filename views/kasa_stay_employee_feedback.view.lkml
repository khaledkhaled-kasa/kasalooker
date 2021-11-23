view: kasa_stay_employee_feedback {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.kasa_stay_employee_feedback`
    where Timestamp is not null
      ;;
  }


  dimension_group: feedback {
    type: time
    sql: ${TABLE}.Timestamp ;;
    convert_tz: no
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: who_is_submitting_the_feedback {
    hidden: yes
    type: string
    sql: ${TABLE}.Who_is_submitting_the_feedback ;;
  }

  dimension: property {
    hidden: yes
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: reservation_code {
    type: string
    sql: ${TABLE}.Reservation_Code ;;
  }

}
