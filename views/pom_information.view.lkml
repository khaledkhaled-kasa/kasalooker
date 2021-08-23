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
                  w.QACompletedWeight
          FROM `bigquery-analytics-272822.Gsheets.pom_information` p
            LEFT JOIN ${pom_weighting_standards_final_transposed.SQL_TABLE_NAME} w
            ON p.WeightingCategory = w.WeightingCategory ;;

    persist_for: "4 hours"
  }

  dimension: Prop_Code {
    label: "Property Code"
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: PropOfficial {
    hidden: yes
    type: string
    sql: ${TABLE}.PropOfficial ;;
  }

  dimension: property_owner {
    view_label: "Building and Geographic Information"
    description: "This data point is pulled from Col I of the KPO Properties tab."
    hidden: no
    type: string
    sql: ${TABLE}.PropOwner ;;
  }


  dimension: pom {
    label: "POM"
    type: string
    sql: ${TABLE}.POM ;;
  }
  dimension: RevenueManager {
    view_label: "Building and Geographic Information"
    label: "Revenue Manager"
    description: "This data point is pulled from Col BM of the KPO Properties tab."
    type: string
    sql: ${TABLE}.RevenueManager ;;
  }

  dimension: PortfolioManager {
    view_label: "Building and Geographic Information"
    label: "Portfolio Manager"
    description: "This data point is pulled from Col BN of the KPO Properties tab."
    type: string
    sql: ${TABLE}.PortfolioManager ;;
  }

  dimension: wifi_type {
    view_label: "Building and Geographic Information"
    label: "Building WiFi (Distributed / In-Unit)"
    description: "This data point is pulled from Col BO of the KPO Properties tab."
    type: string
    sql: ${TABLE}.WifiType ;;
  }

  dimension: city_multi_pom {
    hidden: no
    label: "POM / Multi-POM City"
    description: "This data point is pulled from Col BH of the KPO Properties tab."
    type: string
    sql: CASE WHEN ${TABLE}.POM_Multi_City is NULL THEN ${pom}
    ELSE ${TABLE}.POM_Multi_City
    END;;
  }

  dimension: employment_type {
    hidden: no
    description: "This data point is pulled from Col BI of the KPO Properties tab."
    type: string
    sql: ${TABLE}.Emp_Type;;
  }

  dimension: pom_type {
    label: "POM Type"
    hidden: no
    description: "This data point is pulled from Col BJ of the KPO Properties tab."
    type: string
    sql: ${TABLE}.POM_Type;;
  }

  dimension: HK_Hybrid {
    label: "HK Hybrid?"
    hidden: no
    description: "This data point is pulled from Col BK of the KPO Properties tab."
    type: string
    sql: ${TABLE}.HK_Hybrid;;
  }

  dimension: weighting_category {
    hidden: no
    description: "This data point is pulled from Col BL of the KPO Properties tab."
    type: string
    sql: ${TABLE}.WeightingCategory;;
  }

  dimension: property {
    hidden: yes
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
    description:  "This data point is pulled from Col BG of the KPO Properties tab."
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



  dimension: CleaningScoreWeight {
    hidden: yes
    type: number
    sql: ${TABLE}.CleaningScoreWeight/100.0 ;;
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



  measure: QACompleted_Weighting {
    hidden: yes
    type: max
    sql: ${QACompletedWeight} ;;
  }


  measure: Cleaning_Score_Weighting {
    hidden: yes
    type: max
    sql: ${CleaningScoreWeight} ;;
  }

  measure: Refreshes_Weighting {
    hidden: yes
    type: max
    sql: ${Refreshes_Weight} ;;
  }


  measure: Meeting_Attendance_Weighting {
    hidden: yes
    type: max
    sql: ${MeetingAttendanceWeight} ;;
  }


  measure: BWTasksOnTime_Weighting {
    hidden: yes
    type: max
    sql: ${BWStandardWeight} ;;
  }


  measure: FreshAir_Weighting {
    hidden: yes
    type: max
    sql: ${FreshAirWeight} ;;
  }

  measure: live_partners {
    label: "Total Live Partners"
    view_label: "Building and Geographic Information"
    type: count_distinct
    sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${units.internaltitle} LIKE "%-RES")) THEN NULL
          ELSE ${property_owner}
          END ;;
    filters: [units.unit_status: "Active, Expiring"]
    drill_fields: [property_owner, live_partners]
  }


}
