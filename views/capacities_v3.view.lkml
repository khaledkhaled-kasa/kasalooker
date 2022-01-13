view: capacities_v3 {
  label: "Capacities"
  sql_table_name:`bigquery-analytics-272822.dbt.capacities` ;;


    dimension: primary_key {
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.primary_key ;;
    }

    dimension: _id {
      type: string
      hidden: yes
      sql: ${TABLE}._id;;
    }

    dimension_group: td_stlm {
      label: "Same Time Last Month (STLM)"
      description: "This will provide the date from the same time last MONTH as of today"
      type: time
      timeframes: [
        raw,
        date,
        day_of_month,
        week,
        month,
        day_of_week
      ]
      sql:
            CASE WHEN EXTRACT(MONTH FROM CURRENT_TIMESTAMP()) IN (1,2,4,6,8,9,11) THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 31 DAY)
            WHEN EXTRACT(MONTH FROM CURRENT_TIMESTAMP()) IN (5,7,10,12) THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 30 DAY)
            ELSE DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 28 DAY)
            END
            ;;
      convert_tz: no
    }

  dimension_group: td_stlw {
    label: "Same Time Last Week (STLW)"
    description: "This will provide the date from the same time last week as of today"
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      month,
      day_of_week
    ]
    sql:  DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL 7 DAY) ;;
    convert_tz: no
  }



    dimension_group: night {
      description: "This will return all dates for which the unit is available."
      label: "Night Available "
      type: time
      timeframes: [
        date,
        week,
        month,
        month_name,
        week_of_year,
        day_of_month,
        day_of_week,
        quarter,
        year
      ]
      sql: CAST(${TABLE}.night_available_date as TIMESTAMP) ;;
      convert_tz: no
    }

    dimension: weekend {
      type:  yesno
      sql:  ${capacities_v3.night_day_of_week} in ('Friday', 'Saturday') ;;
    }

    dimension: unit {
      type: string
      hidden: yes
      sql: ${TABLE}.internaltitle ;;
    }

    dimension: EOM {
      label: "End of Month"
      hidden: yes
      type: yesno
      sql: extract(day from date_sub(${night_date},interval -1 day)) = 1 ;;
    }

  dimension: churned_units {
    label: "Churned Units"
    hidden: yes
    type: yesno
    sql: ${night_date} = ${TABLE}.night_availability_enddate ;;
  }


    dimension: first_active_day {
      label: "First active month day"
      description: "This will pull the first day of the month after the units have been activated for the first full month"
      type: string
      hidden: yes
      sql: DATE_TRUNC(DATE_ADD(DATE(TIMESTAMP(${TABLE}.unit_availability_startdate)), INTERVAL 1 MONTH), MONTH);;
    }
  dimension: category {
    label: "Block Category"
    type: string
    sql:
    CASE WHEN ${TABLE}.category="buildingMaintenance" THEN "Building Maintenance"
    WHEN  ${TABLE}.category="carpetClean" THEN "Carpet Clean"
    WHEN  ${TABLE}.category="deepClean" THEN "Deep Clean"
    WHEN  ${TABLE}.category="deferredClean" THEN "deferred Clean"
    WHEN  ${TABLE}.category="extension" THEN "Extension"
    WHEN  ${TABLE}.category="furnitureReplacement" THEN "Furniture Replacement"
    WHEN  ${TABLE}.category="initialBuild" THEN "Initial Build"
    WHEN  ${TABLE}.category="ispIssues" THEN "ISP Issues"
    WHEN  ${TABLE}.category="kasaMaintenance" THEN "kasa Maintenance"
    WHEN  ${TABLE}.category="m" THEN "m"
    WHEN  ${TABLE}.category="missingAccessItemBrokenLocks" THEN "Missing Access Item Broken Locks"
    WHEN  ${TABLE}.category="moveOut" THEN "Move Out"
    WHEN  ${TABLE}.category="partnerRequestedBlocks" THEN "Partner Requested Blocks"
    WHEN  ${TABLE}.category="unitHold" THEN "Unit Hold"
    WHEN  ${TABLE}.category="unitSwap" THEN "Unit Swap"
    WHEN  ${TABLE}.category="a" THEN "a"
    WHEN  ${TABLE}.category="an" THEN "an"
    WHEN  ${TABLE}.category="bw" THEN "bw"
    WHEN  ${TABLE}.category="bd" THEN "bd"
    WHEN  ${TABLE}.category="badActorRemediation" THEN "Bad Actor Remediation"
    ELSE NULL
    END;;

  }
  dimension: IsBlocked {
    label: "Blocked night"
    type: yesno
    sql:${TABLE}.IsBlocked ="Blocked" ;;
  }

  dimension: status {
    label: "Block Status"
    description: "Active/Deleted"
    type: string
    sql:${TABLE}.status ;;
  }

   measure: capacity {
      label: "Total Capacity"
      description: "Number of available room nights bookable, Apply Is Night Blocked? to filter out the blocked nights"
      type: count_distinct
      sql: CASE WHEN ((${TABLE}.internaltitle LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${TABLE}.internaltitle LIKE "%-RES") OR (${TABLE}.internaltitle LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%")) THEN NULL
          ELSE CONCAT(${TABLE}.internaltitle, '-', ${night_date})
          END;;
    }

# This is the same as capacity - REQUEST MADE BY TAFT LANDLORD
    measure: days_available {
      label: "Days Available"
      description: "Number of available room nights bookable (similar to total capacity)"
      type: count_distinct
      hidden: yes
      sql: CASE WHEN ((${TABLE}.internaltitle LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${TABLE}.internaltitle LIKE "%-RES") OR (${TABLE}.internaltitle LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%")) THEN NULL
        ELSE CONCAT(${TABLE}.internaltitle, '-', ${night_date})
        END;;
    }
  measure: days_Blockd {
    label: "Days Blocked"
    description: "Number of blocked room nights "
    type: count_distinct
    sql: CASE WHEN ((${TABLE}.internaltitle LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${TABLE}.internaltitle LIKE "%-RES") OR (${TABLE}.internaltitle LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%")) THEN NULL
        ELSE CONCAT(${TABLE}.internaltitle, '-', ${night_date})
        END;;
        filters: [IsBlocked: "yes"]
  }

  measure: capacity_after_first_active_month {
    label: "Capacity after First Active Month"
    description: "Number of available room nights bookable post first active month"
    type: count_distinct
    sql: CASE WHEN ((${TABLE}.internaltitle LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${TABLE}.internaltitle LIKE "%-RES") OR (${units.internaltitle} LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%") OR (${night_date} < ${first_active_day})) THEN NULL
          ELSE CONCAT(${TABLE}.internaltitle, '-', ${night_date})
          END;;
  }

  measure: unit_count_EOM {
    label: "Total Unique Units (EOM)"
    view_label: "Units"
    description: "Pulls the total number of Unique Units by end of month. Please note that units with black-out dates at EOM would be excluded from this calculation."
    type: count_distinct
    sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${units.internaltitle} LIKE "%-RES") OR (${units.internaltitle} LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%")) THEN NULL
          ELSE ${units._id}
          END;;
    filters: [EOM: "Yes"]
    drill_fields: [units.internaltitle, units.availability_startdate_date, units.availability_enddate_date, units.unit_status]
  }

  ## This measure is used to pull one of the PS H2 KRs
  measure: churned_units_count {
    label: "Total Churned Units"
    hidden: yes
    view_label: "Units"
    description: "Pulls total number of churned units based on unit deactivation date (Col AJ of KPO)"
    type: count_distinct
    sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%XXX") OR (${units.internaltitle} LIKE "%-RES") OR (${units.internaltitle} LIKE "%-S") OR (${TABLE}.internaltitle LIKE "%GXO%")) THEN NULL
          ELSE ${units._id}
          END;;
    filters: [churned_units: "Yes"]
    drill_fields: [units.internaltitle, units.availability_startdate_date, units.availability_enddate_date, units.unit_status]
  }
}
