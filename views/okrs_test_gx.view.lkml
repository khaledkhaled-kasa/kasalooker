view: okrs_test_gx {
  sql_table_name: `bigquery-analytics-272822.Gsheets.OKRs_Test_GX`
    ;;

  dimension: actual {
    type: number
    hidden: yes
    sql: ${TABLE}.Actual ;;
  }

  dimension: target {
    type: number
    hidden: yes
    sql: ${TABLE}.Target ;;
  }

  measure: actual_measure {
    label: "Actual"
    type: max
    sql: ${actual} ;;
  }

  measure: target_measure {
    label: "Target"
    type: max
    sql: ${target} ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: key_result {
    type: string
    sql: ${TABLE}.Key_Result ;;
  }

  dimension: objective {
    type: string
    sql: ${TABLE}.Objective ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.Owner ;;
  }

  dimension: source__manual___looker_ {
    type: string
    sql: ${TABLE}.Source__Manual___Looker_ ;;
  }


  dimension_group: time_period {
    label: ""
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
    sql: ${TABLE}.Time_Period ;;
  }


}
