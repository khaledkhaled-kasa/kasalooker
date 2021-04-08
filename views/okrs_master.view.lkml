view: okrs_master {
  sql_table_name: `bigquery-analytics-272822.Gsheets.OKRs_Master`
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

  dimension: KR {
    label: "KR #"
    type: number
    hidden: no
    sql: ${TABLE}.KR__ ;;
  }

  dimension: eoh_target {
    type: string
    label: "H1 Target"
    hidden: no
    sql: ${TABLE}.EOH_Target ;;
  }

  dimension: data_type {
    type: string
    hidden: no
    sql: ${TABLE}.Data_Type ;;
  }

  measure: actual_measure {
    label: "Actual"
    type: max
    sql: CASE WHEN ${data_type} = "#" THEN ${actual}
          WHEN ${data_type} = "$" THEN ${actual}
          WHEN ${data_type} = "%" THEN ROUND(${actual}*100,2)
          WHEN ${data_type} = "Boolean" THEN ${actual}
          END;;
  }

  measure: target_measure {
    label: "Target"
    type: max
    sql: CASE WHEN ${data_type} = "#" THEN ${target}
          WHEN ${data_type} = "$" THEN ${target}
          WHEN ${data_type} = "%" THEN ROUND(${target}*100,2)
          WHEN ${data_type} = "Boolean" THEN ${actual}
          END;;
  }

  measure: actual_null {
    label: "Unreported Actuals"
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
    filters: [actual: "null"]
  }


  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: BHAG {
    label: "BHAG"
    type: yesno
    sql: ${TABLE}.BHAG ;;
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

  dimension: comments {
    type: string
    sql: ${TABLE}.Comments ;;
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
