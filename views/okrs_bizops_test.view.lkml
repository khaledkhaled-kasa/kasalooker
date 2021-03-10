view: okrs_bizops_test {
  sql_table_name: `bigquery-analytics-272822.Gsheets.OKRs_Bizops_Test`
    ;;


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

  dimension: actual {
    hidden: yes
    type: number
    sql: ${TABLE}.Actual ;;
  }

  dimension: bhag {
    label: "BHAG"
    type: yesno
    sql: ${TABLE}.BHAG ;;
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

  dimension: target {
    hidden: yes
    type: number
    sql: ${TABLE}.Target ;;
  }

  dimension_group: time_period {
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
