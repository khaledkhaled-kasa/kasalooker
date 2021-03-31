view: noiseaware {
  sql_table_name: `bigquery-analytics-272822.Gsheets.noiseaware`
    ;;

  dimension: building_unit {
    type: string
    sql: ${TABLE}.BuildingUnit ;;
  }

  dimension: disconnects {
    type: number
    sql: ${TABLE}.Disconnects ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
