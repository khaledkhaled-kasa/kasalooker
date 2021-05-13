view: pom_qa_walkthrough_survey_agg {
  derived_table: {
    sql: SELECT DATE(Timestamp) as VisitDate, Building || '-' || Door_No_ as Unit, POM_Name
      FROM ${pom_qa_walkthrough_survey.SQL_TABLE_NAME}
      Group By 1,2,3
       ;;
    datagroup_trigger: pom_checklist_default_datagroup
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${unit} || CAST(${visit_date} as STRING) ;;
  }

  dimension: visit_date {
    type: date
    datatype: date
    sql: ${TABLE}.VisitDate ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: pom_name {
    type: string
    sql: ${TABLE}.POM_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_qas_completed_percentage {
    label: "Pct QAs Completed"
    description: "Total QAs completed as a percentage of check-ins. Should be used in conjunstion with a check-in date filter"
    type: number
    sql: ${count} / NULLIF(${check_in_data.total_checkins},0) ;;
  }

  measure: total_qas_completed_score {
    label: "Total QAs Completed Score"
    type: number
    sql:  CASE WHEN ${total_qas_completed_percentage} >= ${pom_information.PctQAsCompleted_Standard} THEN 1
            ELSE ${total_qas_completed_percentage} / NULLIF(${pom_information.PctQAsCompleted_Standard},0)
          END;;
  }

  measure: total_qas_completed_score_weighted {
    label: "Total QAs Completed Score (Weighting)"
    type: number
    sql: ${total_qas_completed_score} * ${pom_information.QACompleted_Weighting} ;;
  }

  set: detail {
    fields: [visit_date, unit, pom_name]
  }
}
