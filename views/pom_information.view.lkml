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
    label: "Property Code"
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

  dimension: building_start_date {
    description: "Building Start Date as per KPO Properties Tab (Col R)"
    view_label: "Building and Geographic Information"
    type: date
    sql: TIMESTAMP(PARSE_DATE('%m/%d/%Y', ${TABLE}.BuildingStart)) ;;
    convert_tz: no
  }

  dimension: building_cohort {
    description: "Based on Building Start Date"
    view_label: "Building and Geographic Information"
    type: string
    sql:
    CASE WHEN extract(year from ${building_start_date}) < 2018 THEN "< 2018 Cohort"
    WHEN extract(year from ${building_start_date}) = 2018 THEN "2018 Cohort"
    WHEN extract(year from ${building_start_date}) = 2019 THEN "2019 Cohort"
    WHEN extract(year from ${building_start_date}) = 2020 THEN "2020 Cohort"
    WHEN extract(year from ${building_start_date}) = 2021 THEN "2021 Cohort"
    WHEN extract(year from ${building_start_date}) = 2022 THEN "2022 Cohort"
    END;;
  }

  dimension: property_type {
    type: string
    label: "Property Sub-Category (Property Type)"
    view_label: "Building and Geographic Information"
    sql: ${TABLE}.propertytype ;;
  }

  dimension: min_los {
    label: "Property Min LOS"
    description: "This will pull the property's minimum length of stay in days as shown in the Properties tab of the KPO"
    type: number
    view_label: "Building and Geographic Information"
    sql: ${TABLE}.Min_LOS ;;
  }

  dimension: max_los {
    label: "Property Max LOS"
    description: "This will pull the property's maximum length of stay in days as shown in the Properties tab of the KPO"
    type: number
    view_label: "Building and Geographic Information"
    sql: ${TABLE}.Max_LOS ;;
  }

  dimension: property_type_buckets {
    type: string
    label: "Property Category (Special/Core)"
    view_label: "Building and Geographic Information"
    description: "Multifamily is classified as a core property; whereas hotel & student housings are classified as special properties"
    sql: CASE
    WHEN ${TABLE}.propertytype = "Multifamily" THEN "Core Properties"
    WHEN ${TABLE}.propertytype IN ("Hotel", "Student Housing") THEN "Special Properties"
    ELSE ${TABLE}.propertytype
    END ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: weighting_category {
    hidden: yes
    type: string
    sql: ${TABLE}.weighting_category ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: employment {
    hidden: yes
    type: string
    sql: ${TABLE}.employment ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: CleaningScoreWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.CleaningScoreWeight/100.0 ;;
  }

  dimension: HOM {
    hidden: yes
    type: string
    label: "HOM"
    sql: ${TABLE}.HOM ;;
  }

  dimension: PctQAsCompleted {
    hidden: yes
    type: number
    sql: ${TABLE}.PctQAsCompleted/100.0 ;;
  }

  dimension: Refreshes {
    hidden: yes
    type: number
    sql: ${TABLE}.refreshes/100.0  ;;
  }

  dimension: BWStandardWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.BWStandardWeight/100.0 ;;
  }

  dimension: Refreshes_Weight {
    hidden: yes
    type: number
    sql: ${TABLE}.RefreshesWeight/100.0 ;;
  }

  dimension: QACompletedWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.QACompletedWeight/100.0 ;;
  }

  dimension: AvgCleaningScore {
    hidden: yes
    type: number
    sql: ${TABLE}.AvgCleaningScore*1.00 ;;
  }

  dimension: BWTasksOnTime {
    hidden: yes
    type: number
    sql: ${TABLE}.BWTasksOnTime/100.0  ;;
  }

  dimension: MeetingAttendance {
    hidden: yes
    type: number
    sql: ${TABLE}.MeetingAttendance/100.0  ;;
  }

  dimension: FreshAirMonitoring {
    hidden: yes
    type: number
    sql: ${TABLE}.FreshAirMonitoring/100.0  ;;
  }

  dimension: FreshAirWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.FreshAirWeight/100.0 ;;
  }

  dimension: MeetingAttendanceWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.MeetingAttendanceWeight/100.0 ;;
  }


  measure: PctQAsCompleted_Standard {
    hidden: yes
    description: "Pct QAs Completed to achieve to get a perfect 1."
    type: max
    sql: ${PctQAsCompleted} ;;
  }

  measure: QACompleted_Weighting {
    hidden: yes
    type: max
    sql: ${QACompletedWeight} ;;
  }

  measure: Cleaning_Score_Standard {
    hidden: yes
    description: "Avg Cleaning Score to Achieve To Get a Perfect 1"
    type: max
    sql: ${AvgCleaningScore} ;;
  }

  measure: Cleaning_Score_Weighting {
    hidden: yes
    type: max
    sql: ${CleaningScoreWeight} ;;
  }

  measure: Refreshes_Standard {
    hidden: yes
    type: max
    sql: ${Refreshes} ;;
  }

  measure: Refreshes_Weighting {
    hidden: yes
    type: max
    sql: ${Refreshes_Weight} ;;
  }

  measure: MeetingAttendanceStandard {
    hidden: yes
    type: max
    sql: ${MeetingAttendance} ;;
  }

  measure: Meeting_Attendance_Weighting {
    hidden: yes
    type: max
    sql: ${MeetingAttendanceWeight} ;;
  }

  measure: BWTasksOnTimeStandard {
    hidden: yes
    type: max
    sql: ${BWTasksOnTime} ;;
  }

  measure: BWTasksOnTime_Weighting {
    hidden: yes
    type: max
    sql: ${BWStandardWeight} ;;
  }

  measure: FreshAirStandard {
    hidden: yes
    type: max
    sql: ${FreshAirMonitoring} ;;
  }

  measure: FreshAir_Weighting {
    hidden: yes
    type: max
    sql: ${FreshAirWeight} ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
