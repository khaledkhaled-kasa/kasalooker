view: pom_qa_walkthrough_survey_agg {
  derived_table: {
    sql:

    WITH c1 AS (SELECT Timestamp, DATE(Timestamp) as VisitDate, Building, Door_No_, Building || '-' || Door_No_ as Unit, POM_Name,
      RANK() OVER (PARTITION BY CONCAT(Building,Door_No_) ORDER BY Timestamp desc) visit_recency_rank
      FROM ${pom_qa_walkthrough_survey.SQL_TABLE_NAME}
      Group By 1,2,3,4,5,6),

      MostRecentQA AS (SELECT Unit, POM_NAME MostRecentPOM, MAX(VisitDate) as MostRecentQA
      FROM c1
      WHERE visit_recency_rank = 1
      GROUP BY 1,2)

      SELECT c.*, ref.MostRecentPOM, ref.MostRecentQA
      FROM c1 c
        LEFT JOIN MostRecentQA ref
        ON c.Unit = ref.Unit
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

  dimension: most_recent_qa {
    label: "Most Recent QA Visit"
    type: date
    datatype: date
    sql: ${TABLE}.MostRecentQA ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: pom_name {
    type: string
    sql: ${TABLE}.POM_Name ;;
  }

  dimension: pom_name_most_recent {
    label: "Most Recent QA POM"
    sql: ${TABLE}.MostRecentPOM ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: [detail*]
  # }

  # measure: total_qas_completed_percentage {
  #   label: "Pct QAs Completed"
  #   description: "Total QAs completed as a percentage of check-ins. Should be used in conjunstion with a check-in date filter"
  #   type: number
  #   sql: ${count} / NULLIF(${check_in_data.total_checkins},0) ;;
  # }

  # measure: total_qas_completed_score {
  #   label: "Total QAs Completed Score"
  #   type: number
  #   sql:  CASE WHEN ${total_qas_completed_percentage} >= ${pom_information.PctQAsCompleted_Standard} THEN 1
  #           ELSE ${total_qas_completed_percentage} / NULLIF(${pom_information.PctQAsCompleted_Standard},0)
  #         END;;
  # }

  # measure: total_qas_completed_score_weighted {
  #   label: "Total QAs Completed Score (Weighting)"
  #   type: number
  #   sql: ${total_qas_completed_score} * ${pom_information.QACompleted_Weighting} ;;
  # }

  # set: detail {
  #   fields: [visit_date, unit, pom_name]
  # }
}
