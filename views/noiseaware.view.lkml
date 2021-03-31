view: noiseaware {
  sql_table_name: `bigquery-analytics-272822.Gsheets.noiseaware`
    ;;

  dimension: building_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.BuildingUnit ;;
  }

  dimension: disconnects {
    type: number
    sql: ${TABLE}.Disconnects ;;
  }

  dimension: noise_aware_status {
    type: string
    sql:  CASE  WHEN ${building_unit} IS NULL THEN 'Connected'
                ELSE CAST(${disconnects} as STRING)
          END;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
