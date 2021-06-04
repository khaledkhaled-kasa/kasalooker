view: active_unit_counts {
  derived_table: {
      sql:
      WITH unit_dates as (SELECT  _id,
          SAFE_CAST(availability.startdate as DATE) as startdate,
          CASE WHEN EXTRACT(YEAR from SAFE_CAST(availability.enddate as DATE)) = 2099 THEN DATE_ADD(SAFE_CAST(availability.enddate as DATE), INTERVAL 18 MONTH) ELSE SAFE_CAST(availability.enddate as DATE) END as enddate
          FROM mongo.units
          where availability.startdate IS NOT NULL)

          SELECT
              available_day,
              _id,
              SAFE_CAST(available_day as STRING) || '-' || SAFE_CAST(_id as STRING) as primary_key
          FROM unit_dates, UNNEST(GENERATE_DATE_ARRAY(startdate, enddate, INTERVAL 1 day)) available_day
          WHERE available_day <= CURRENT_DATE()
          ;;
      datagroup_trigger: default_datagroup
  }

  dimension: primary_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.primary_key ;;
  }

  dimension_group: available {
    hidden: yes
    type: time
    timeframes: [date, week, month, year]
    sql: SAFE_CAST(${TABLE}.available_day as TIMESTAMP) ;;
  }

  dimension: _id {
    hidden: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  measure: total_active_units {
    view_label: "Unit Information"
    description: "Brings back the count of active units. Best practice is to use in conjunction with a date dimension"
    type: count_distinct
    sql: ${_id} ;;
  }

  set: detail {
    fields: [available_date, _id]
  }
}
