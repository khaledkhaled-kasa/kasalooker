view: pom_weighting_standards_final {

  derived_table: {
    sql:  SELECT *
          FROM `bigquery-analytics-272822.POM_Standards.POM_Weighting_Standards_Final`;;
  }

  dimension: standard_type {
    type: string
    sql: ${TABLE}.StandardType ;;

    action: {
      label: "Add New"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_new_weight_writeback"

      form_param: {
        name: "WeightingCategory"
        type: string
        label: "Weighting Category"
        description: "Enter weighting category"
        required: yes
      }

      form_param: {
        name: "StandardType"
        type: string
        label: "Enter New Standard Type"
        description: "Enter the New Standard for the Weighting Category"
        required: yes
      }

      form_param: {
        name: "NewWeight"
        type: string
        label: "Enter New Weight"
        description: "Enter the New Weighting"
        required: yes
      }

    }
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.Weight ;;

    action: {
      label: "Update"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_weight_writeback"
      param: {
        name: "WeightingCategory"
        value: "{{pom_weighting_standards_final.weighting_category._value}}"
      }
      param: {
        name: "UpdateType"
        value: "{{pom_weighting_standards_final.standard_type._value}}"
      }
      form_param: {
        name: "Update"
        type: string
        label: "New Weight"
        description: "Enter new weighting"
        required: yes
      }
    }
  }

  dimension: weighting_category {
    type: string
    sql: ${TABLE}.WeightingCategory ;;

    action: {
      label: "Add New"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_new_weight_writeback"

      form_param: {
        name: "WeightingCategory"
        type: string
        label: "Weighting Category"
        description: "Enter weighting category"
        required: yes
      }

      form_param: {
        name: "StandardType"
        type: string
        label: "Enter New Standard Type"
        description: "Enter the New Standard for the Weighting Category"
        required: yes
      }

      form_param: {
        name: "NewWeight"
        type: string
        label: "Enter New Weight"
        description: "Enter the New Weighting"
        required: yes
      }

    }
  }

}

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


}
