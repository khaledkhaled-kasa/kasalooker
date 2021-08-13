view: ST_Installation_Dates_Tracker {
  derived_table: {
    sql: SELECT
      UnitInternalTitle,
      SmartThings_Installation
      FROM `bigquery-analytics-272822.Gsheets.ST_Installation_Dates_Tracker`
      where
      UnitInternalTitle is not null
       ;;
    datagroup_trigger:ST_Installation_Dates_Tracke_datagroup

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: unit_internal_title {
    type: string
    sql: ${TABLE}.UnitInternalTitle ;;
  }

  dimension: smart_things_installation {
    type: date
    datatype: date
    sql: ${TABLE}.SmartThings_Installation ;;
  }

  set: detail {
    fields: [unit_internal_title, smart_things_installation]
  }
}
