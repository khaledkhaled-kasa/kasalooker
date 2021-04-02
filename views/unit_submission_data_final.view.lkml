view: unit_submission_data_final {
  derived_table: {
    sql: WITH c1 as (SELECT
          CASE  WHEN LENGTH(VisitTime) > 9 THEN DATE(PARSE_DATETIME('%m/%d/%Y %H:%M:%S',  VisitTime))
                WHEN LENGTH(VisitTime) <= 9 THEN DATE(PARSE_DATETIME('%m/%d/%Y', VisitTime))
          END as VisitDate,
          Name,
          Email,
          Building,
          Unit,
          VisitType
        FROM `bigquery-analytics-272822.Gsheets.unit_submission_data_raw`
      ),

      MostRecentRefr as (SELECT Building, Unit, MAX(VisitDate) as MostRecentRefresh
      FROM c1
      Where VisitType = 'Unit Refresh'
      Group By 1,2),

      MostRecentRoutine as (SELECT Building, Unit, MAX(VisitDate) as MostRecentRoutineVisit
      FROM c1
      Where visitType = 'Routine Visit'
      Group By 1,2)

      SELECT c.*, ref.MostRecentRefresh, rout.MostRecentRoutineVisit
      FROM c1 c
        LEFT JOIN MostRecentRefr ref
        ON c.Building = ref.Building and c.Unit = ref.Unit
        LEFT JOIN MostRecentRoutine rout
        ON c.Building = rout.Building and c.Unit = rout.Unit
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: visit_date {
    type: date
    datatype: date
    sql: ${TABLE}.VisitDate ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: building {
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: buildingunit {
    type: string
    sql: CONCAT(${building}, '-', ${unit}) ;;
  }

  dimension: visit_type {
    type: string
    sql: ${TABLE}.VisitType ;;
  }

  dimension: most_recent_refresh {
    type: date
    datatype: date
    sql: ${TABLE}.MostRecentRefresh ;;
  }

  dimension: most_recent_routine_visit {
    type: date
    datatype: date
    sql: ${TABLE}.MostRecentRoutineVisit ;;
  }

  dimension: next_refresh {
    type: date
    datatype: date
    sql: CASE WHEN ${units_buildings_information.availability_startdate} > ${most_recent_refresh} AND ${most_recent_refresh} IS NOT NULL THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 90 DAY)
              WHEN ${most_recent_refresh} > ${units_buildings_information.availability_startdate} AND ${most_recent_refresh} IS NOT NULL THEN DATE_ADD(${most_recent_refresh}, INTERVAL 90 DAY)
              WHEN ${most_recent_refresh} IS NULL THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 90 DAY)
          END;;
  }

  dimension: next_visit {
    type: date
    datatype: date
    sql: CASE
          WHEN ${units_buildings_information.availability_startdate} > ${most_recent_refresh} AND ${units_buildings_information.availability_startdate} > ${most_recent_routine_visit} THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} > ${units_buildings_information.availability_startdate} AND ${most_recent_refresh} > ${most_recent_routine_visit} THEN DATE_ADD(${most_recent_refresh}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} = ${most_recent_routine_visit} AND ${most_recent_refresh} > ${units_buildings_information.availability_startdate} THEN DATE_ADD(${most_recent_refresh}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} IS NULL AND ${most_recent_routine_visit} IS NOT NULL AND ${most_recent_routine_visit} > ${units_buildings_information.availability_startdate} THEN DATE_ADD(${most_recent_routine_visit}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} IS NULL AND ${most_recent_routine_visit} IS NOT NULL AND ${units_buildings_information.availability_startdate} > ${most_recent_routine_visit} THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} IS NULL AND ${most_recent_routine_visit} IS NULL THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 30 DAY)

          WHEN ${most_recent_refresh} IS NOT NULL AND ${most_recent_routine_visit} IS NULL AND ${most_recent_refresh} > ${units_buildings_information.availability_startdate} THEN DATE_ADD(${most_recent_refresh}, INTERVAL 30 DAY)
          WHEN ${most_recent_refresh} IS NOT NULL AND ${most_recent_routine_visit} IS NULL AND ${units_buildings_information.availability_startdate} > ${most_recent_refresh} THEN DATE_ADD(${units_buildings_information.availability_startdate}, INTERVAL 30 DAY)
          WHEN ${most_recent_routine_visit} >= ${most_recent_refresh} AND ${most_recent_routine_visit} > ${units_buildings_information.availability_startdate} THEN DATE_ADD(${most_recent_refresh}, INTERVAL 30 DAY)

        END;;
  }

  dimension: routine_visit_status {
    type: string
    sql: CASE WHEN ${units_buildings_information.unit_status} = 'Deactivated' THEN 'N/A - Deactivated'
              WHEN ${next_visit} > CURRENT_DATE THEN 'All Good'
              ELSE CONCAT(CAST(DATE_DIFF(CURRENT_DATE, ${next_visit}, DAY) as STRING), ' Days Overdue')
          END;;
  }

  dimension: unit_refresh_status {
    type: string
    sql: CASE WHEN ${units_buildings_information.unit_status} = 'Deactivated' THEN 'N/A - Deactivated'
              WHEN ${next_refresh} > CURRENT_DATE THEN 'All Good'
              ELSE CONCAT(CAST(DATE_DIFF(CURRENT_DATE, ${next_refresh}, DAY) as STRING), ' Days Overdue')
          END;;
  }

  dimension: pom_status {
    type: string
    sql: CASE WHEN ${units_buildings_information.unit_status} = 'Deactivated' THEN 'Decativated'
              WHEN ${next_refresh} > CURRENT_DATE
                    AND ${nexia_data.connection_status} IN ('Connected','No Nexia')
                    AND ${freshair_data.status} NOT IN ('Sensor Issues', 'Offline')
                    AND (${nexia_data.battery_level} IS NOT NULL OR ${nexia_data.battery_level} > 0.35)
                    AND ${noiseaware.noise_aware_status} = 'Connected'
                    THEN 'All Good'
              ELSE 'Needs Attention'
          END
                    ;;
  }

  set: detail {
    fields: [
      visit_date,
      name,
      email,
      building,
      unit,
      visit_type,
      most_recent_refresh,
      most_recent_routine_visit
    ]
  }
}
