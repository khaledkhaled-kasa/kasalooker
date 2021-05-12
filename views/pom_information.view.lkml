view: pom_information {
  derived_table: {
    sql:  SELECT  p.*,
                  w.FreshAirWeight,
                  w.RefreshesWeight,
                  w.BWStandardWeight,
                  w.LockHealthWeight,
                  w.NoiseHealthWeight,
                  w.UnitsVisitedWeight,
                  w. CleaningScoreWeight,
                  w.MeetingAttendanceWeight,
                  w.QACompletedWeight,
                  s.*
          FROM `bigquery-analytics-272822.Gsheets.pom_information` p
            LEFT JOIN ${pom_weighting_standards_final_transposed.SQL_TABLE_NAME} w
            ON p.WeightingCategory = w.WeightingCategory
            CROSS JOIN `bigquery-analytics-272822.Gsheets.pom_wide_standards` s ;;
    datagroup_trigger: pom_checklist_default_datagroup
  }

  dimension: Prop_Code {
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: PropOfficial {
    type: string
    sql: ${TABLE}.PropOfficial ;;
  }

  dimension: pom {
    label: "POM"
    type: string
    sql: ${TABLE}.POM ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: property_type {
    type: string
    group_label: "Building and Geographic Information"
    sql: ${TABLE}.property_type ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: weighting_category {
    type: string
    sql: ${TABLE}.weighting_category ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: employment {
    type: string
    sql: ${TABLE}.employment ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: CleaningScoreWeight {
    type: number
    sql: ${TABLE}.CleaningScoreWeight/100.0 ;;
  }

  dimension: HOM {
    type: string
    label: "HOM"
    sql: ${TABLE}.HOM ;;
  }

  dimension: PctQAsCompleted {
    type: number
    sql: ${TABLE}.PctQAsCompleted/100.0 ;;
  }

  dimension: Refreshes {
    type: number
    sql: ${TABLE}.refreshes/100.0  ;;
  }

  dimension: BWStandardWeight {
    type: number
    sql: ${TABLE}.BWStandardWeight/100.0 ;;
  }

  dimension: Refreshes_Weight {
    type: number
    sql: ${TABLE}.RefreshesWeight/100.0 ;;
  }

  dimension: QACompletedWeight {
    type: number
    sql: ${TABLE}.QACompletedWeight/100.0 ;;
  }

  dimension: AvgCleaningScore {
    type: number
    sql: ${TABLE}.AvgCleaningScore*1.00 ;;
  }

  dimension: BWTasksOnTime {
    type: number
    sql: ${TABLE}.BWTasksOnTime/100.0  ;;
  }

  dimension: MeetingAttendance {
    type: number
    sql: ${TABLE}.MeetingAttendance/100.0  ;;
  }

  dimension: FreshAirMonitoring {
    type: number
    sql: ${TABLE}.FreshAirMonitoring/100.0  ;;
  }

  dimension: FreshAirWeight {
    type: number
    sql: ${TABLE}.FreshAirWeight/100.0 ;;
  }

  dimension: MeetingAttendanceWeight {
    type: number
    sql: ${TABLE}.MeetingAttendanceWeight/100.0 ;;
  }


  measure: PctQAsCompleted_Standard {
    description: "Pct QAs Completed to achieve to get a perfect 1."
    type: max
    sql: ${PctQAsCompleted} ;;
  }

  measure: QACompleted_Weighting {
    type: max
    sql: ${QACompletedWeight} ;;
  }

  measure: Cleaning_Score_Standard {
    description: "Avg Cleaning Score to Achieve To Get a Perfect 1"
    type: max
    sql: ${AvgCleaningScore} ;;
  }

  measure: Cleaning_Score_Weighting {
    type: max
    sql: ${CleaningScoreWeight} ;;
  }

  measure: Refreshes_Standard {
    type: max
    sql: ${Refreshes} ;;
  }

  measure: Refreshes_Weighting {
    type: max
    sql: ${Refreshes_Weight} ;;
  }

  measure: MeetingAttendanceStandard {
    type: max
    sql: ${MeetingAttendance} ;;
  }

  measure: Meeting_Attendance_Weighting {
    type: max
    sql: ${MeetingAttendanceWeight} ;;
  }

  measure: BWTasksOnTimeStandard {
    type: max
    sql: ${BWTasksOnTime} ;;
  }

  measure: BWTasksOnTime_Weighting {
    type: max
    sql: ${BWStandardWeight} ;;
  }

  measure: FreshAirStandard {
    type: max
    sql: ${FreshAirMonitoring} ;;
  }

  measure: FreshAir_Weighting {
    type: max
    sql: ${FreshAirWeight} ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
