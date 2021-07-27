view: pom_weighting_standards_final_transposed {
  derived_table: {
    sql:  SELECT  WeightingCategory,
             MAX(CASE WHEN StandardType = 'FreshAir' THEN Weight END) AS FreshAirWeight,
             MAX(CASE WHEN StandardType = 'Refreshes' THEN Weight END) AS RefreshesWeight,
             MAX(CASE WHEN StandardType = 'BW Standard' THEN Weight END) AS BWStandardWeight,
             MAX(CASE WHEN StandardType = 'Lock Health' THEN Weight END) AS LockHealthWeight,
             MAX(CASE WHEN StandardType = 'Noise Health' THEN Weight END) AS NoiseHealthWeight,
             MAX(CASE WHEN StandardType = 'Units Visited' THEN Weight END) AS UnitsVisitedWeight,
             MAX(CASE WHEN StandardType = 'Cleaning Score' THEN Weight END) AS CleaningScoreWeight,
             MAX(CASE WHEN StandardType = 'MeetingAttendance' THEN Weight END) as MeetingAttendanceWeight,
            MAX(CASE WHEN StandardType = 'QACompleted' THEN Weight END) as QACompletedWeight

          FROM `bigquery-analytics-272822.POM_Standards.POM_Weighting_Standards_Final`
          Group By 1 ;;
  }

  dimension: Weighting_Category {
    type: string
    sql: ${TABLE}.WeightingCategory ;;
  }

  dimension: FreshAir {
    label: "FreshAir"
    type: string
    sql: ${TABLE}.FreshAirWeight ;;
  }

  dimension: Refreshes {
    label: "Refreshes"
    type: string
    sql: ${TABLE}.RefreshesWeight ;;
  }

  dimension: BWStandard {
    label: "BWStandard"
    type: string
    sql: ${TABLE}.BWStandardWeight ;;
  }

  dimension: LockHealth {
    label: "LockHealth"
    type: string
    sql: ${TABLE}.LockHealthWeight ;;
  }

  dimension: NoiseHealth {
    label: "NoiseHealth"
    type: string
    sql: ${TABLE}.NoiseHealthWeight ;;
  }

  dimension: UnitsVisited {
    label: "UnitsVisited"
    type: string
    sql: ${TABLE}.UnitsVisitedWeight ;;
  }

  dimension: CleaningScore {
    label: "CleaningScore"
    type: string
    sql: ${TABLE}.CleaningScoreWeight ;;
  }

  dimension: MeetingAttendanceWeight {
    label: "Meeting Attendance"
    type: string
    sql: ${TABLE}.MeetingAttendanceWeight ;;
  }

  dimension: QACompletedWeight {
    label: "QA Completed"
    type: string
    sql: ${TABLE}.QACompletedWeight ;;
  }




  # measure: total_qas_completed_score {
  #   label: "Total QAs Completed Score"
  #   type: number
  #   sql:  CASE WHEN ${pom_qa_walkthrough_survey.total_qas_completed_percentage} >= ${pom_information.PctQAsCompleted_Standard} THEN 1
  #         ELSE ${pom_qa_walkthrough_survey.total_qas_completed_percentage} / NULLIF(${pom_information.PctQAsCompleted_Standard},0)
  #         END;;
  # }

  # measure: total_qas_completed_score_weighted {
  #   label: "Total QAs Completed Score (Weighting)"
  #   type: number
  #   sql: ${total_qas_completed_score} * ${pom_information.QACompleted_Weighting} ;;
  # }

}
