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
    label: "Source (Manual / Looker)"
    description: "Source the data point is pulled from. It could be from a source living within Looker or manually entered from an external source. Looker (Potential) will show for metrics pulled manually with a potential of it being pulled from a Looker source."
    sql: ${TABLE}.Source__Manual___Looker_ ;;
  }

  dimension: automated_looker {
    label: "Automated on Looker (Yes/No)"
    description: "This will return Yes for metrics living on Looker and are updated through Looker. No for metrics which live on Looker but are still not automated and returns a null value for manually pulled metrics."
    type: string
    sql: ${TABLE}.Automated_Looker ;;
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

  measure: count_actual {
    label: "KR Count"
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
  }

  measure: percent_missing {
    label: "% Actuals Unreported"
    type: number
    value_format: "0%"
    sql: ${actual_null} / ${count_actual} ;;
  }

  measure: count_source {
    label: "Count (All Sources)"
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
    drill_fields: [department, objective, key_result, source__manual___looker_, automated_looker]
  }

  measure: count_looker_source {
    label: "Count (Looker Source)"
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
    filters: [source__manual___looker_: "Looker"]
    drill_fields: [department, objective, key_result, source__manual___looker_, automated_looker]
  }

  measure: count_looker_source_potential {
    label: "Count (Looker Potential)"
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
    filters: [source__manual___looker_: "Looker (Potential)"]
    drill_fields: [department, objective, key_result, source__manual___looker_, automated_looker]
  }

  measure: count_looker_source_automated {
    label: "Count (Looker) - Automated"
    hidden: yes
    type: count_distinct
    sql: CONCAT(${TABLE}.Department,${TABLE}.KR__) ;;
    filters: [source__manual___looker_: "Looker", automated_looker: "Yes"]
    drill_fields: [department, objective, key_result, source__manual___looker_]
  }

  measure: percent_looker_source {
    label: "% OKRs Sourced from Looker"
    description: "This will pull the % of OKRs which are a LOOKER SOURCE."
    hidden: no
    type: number
    value_format: "0.0%"
    sql: ${count_looker_source} / nullif(${count_source},0) ;;
    drill_fields: [department, objective, key_result, source__manual___looker_]
  }

  measure: percent_looker_source_automated {
    label: "% OKRs Automated"
    description: "This will pull the % of OKRs which are a LOOKER SOURCE and already being updated automatically."
    hidden: no
    type: number
    value_format: "0.0%"
    sql: ${count_looker_source_automated} / nullif(${count_looker_source},0) ;;
    drill_fields: [department, objective, key_result, source__manual___looker_]
  }
}
