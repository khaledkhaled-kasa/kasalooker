view: capacities_v3 {
  derived_table: {
    sql: SELECT *
        FROM capacitydenorms
          WHERE unit is not null
      ;;

    datagroup_trigger: capacities_v3_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes

  }

  dimension: __v {
    type: number
    hidden: yes
    sql: ${TABLE}.__v ;;
  }

  dimension: _id {
    type: string
    # primary_key: yes
    hidden: yes
    sql: ${TABLE}._id ;;
  }

  dimension_group: _sdc_batched {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension_group: createdat {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdat ;;
  }


  dimension_group: night {
    view_label: "Date Dimensions"
    group_label: "Occupied / Unoccupied Night"
    description: "A night at a Kasa (Occupied / Unoccupied)"
    label: ""
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

  dimension: night_only {
    hidden: yes
    view_label: "Date Dimensions"
    group_label: "Night Only"
    type: string
    sql: ${TABLE}.night ;;
  }


  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
  }

  dimension_group: updatedat {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedat ;;
  }

  dimension: capacity_dim {
    type: number
    hidden: yes
    sql: CASE WHEN
    ${night_date} >= cast(${units.availability_startdate} AS date)
    AND ${night_date} <= cast(${units.availability_enddate} AS date) THEN 1
    ELSE NULL
    END;;
  }

  measure: capacity {
    view_label: "Metrics"
    label: "Capacity"
    description: "Number of available room nights bookable"
    type: count_distinct
    sql: CONCAT(${units._id}, '-', ${night_date});;
  }


  measure: days_available {
    view_label: "Metrics"
    label: "Days Available"
    description: "Number of available room nights bookable"
    type: count_distinct
    sql: CONCAT(${units._id}, '-', ${night_date});;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.night, ${TABLE}.unit) ;;
  }



}
