view: capacities_v3 {
  label: "Capacities"
  derived_table: {
    sql:
    SELECT capacitydenorms.*, units.internaltitle
    FROM capacitydenorms
    LEFT JOIN units ON units._id = capacitydenorms.unit
    LEFT JOIN Gsheets.blackout_dates ON (units.internaltitle = blackout_dates.Unit_InternalTitle AND DATE(capacitydenorms.night) = blackout_dates.blackout_dates)
    WHERE blackout_dates.blackout_dates is null -- THIS WILL ENSURE THAT BLACKOUT DATES ARE EXCLUDED
    AND capacitydenorms.unit is not null -- This will clean up redundant capacitydenorms rows
      ;;

      datagroup_trigger: capacities_v3_default_datagroup
      # indexes: ["night","transaction"]
      #publish_as_db_view: yes

    }

    dimension: primary_key {
      primary_key: yes
      hidden: yes
      sql: CONCAT(${TABLE}.night, ${TABLE}.unit) ;;
    }

    dimension: _id {
      type: string
      # primary_key: yes
      hidden: yes
      sql: ${TABLE}._id ;;
    }

  dimension_group: td_stlm {
    label: "Same Time Last Month (STLM)"
    description: "This will provide the date from the same time last MONTH"
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
      sql: CAST(${TABLE}.night as TIMESTAMP) ;;
    }

    dimension: weekend {
      type:  yesno
      sql:  ${capacities_v3.night_day_of_week} in ('Friday', 'Saturday') ;;
    }

    dimension: unit {
      type: string
      hidden: yes
      sql: ${TABLE}.unit ;;
    }


    dimension: first_active_day {
      label: "First active month day"
      description: "This will pull the first day of the month after the units have been activated for the first full month"
      type: string
      hidden: yes
      sql: DATE_TRUNC(DATE_ADD(DATE(TIMESTAMP(availability.startdate)), INTERVAL 1 MONTH), MONTH);;
    }


    measure: capacity {
      label: "Total Capacity"
      description: "Number of available room nights bookable"
      type: count_distinct
      sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${units.internaltitle} LIKE "%-RES")) THEN NULL
          ELSE CONCAT(${units.internaltitle}, '-', ${night_date})
          END;;
    }

# This is the same as capacity - REQUEST MADE BY TAFT LANDLORD
    measure: days_available {
      label: "Days Available"
      description: "Number of available room nights bookable"
      type: count_distinct
      sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${units.internaltitle} LIKE "%-RES")) THEN NULL
          ELSE CONCAT(${units.internaltitle}, '-', ${night_date})
          END;;
    }

    measure: capacity_after_first_active_month {
      label: "Capacity after First Active Month"
      description: "Number of available room nights bookable post first active month"
      type: count_distinct
      sql: CASE WHEN ((${units.internaltitle} LIKE "%-XX") OR (${units.internaltitle} LIKE "%-RES") OR (${night_date} < ${first_active_day})) THEN NULL
          ELSE CONCAT(${units.internaltitle}, '-', ${night_date})
          END;;
    }


  }
