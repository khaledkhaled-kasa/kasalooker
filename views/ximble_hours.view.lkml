view: ximble_hours {
  sql_table_name: `bigquery-analytics-272822.ximble.ximble_hours`
    ;;

  dimension: break_1_end {
    type: string
    sql: ${TABLE}.Break_1_End ;;
  }

  dimension: break_1_start {
    type: string
    sql: ${TABLE}.Break_1_Start ;;
  }

  dimension: break_2_end {
    type: string
    sql: ${TABLE}.Break_2_End ;;
  }

  dimension: break_2_start {
    type: string
    sql: ${TABLE}.Break_2_Start ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      hour_of_day
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: e_mail {
    type: string
    sql: ${TABLE}.E_mail ;;
  }

  dimension: end_time {
    type: string
    sql: ${TABLE}.End_Time ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.First_Name ;;
  }

  dimension: job {
    type: string
    sql: ${TABLE}.Job ;;
  }

  dimension: labor_cost {
    type: number
    sql: ${TABLE}.Labor_Cost ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.Last_Name ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: shift_label {
    type: string
    sql: ${TABLE}.Shift_Label ;;
  }

  dimension: start_time {
    type: string
    sql: ${TABLE}.Start_Time ;;
  }

  dimension: total_hours {
    type: number
    sql: ${TABLE}.Total_Hours ;;
  }

  measure: count {
    type: count
    drill_fields: [first_name, last_name]
  }
}
