view: freshair_data {
  sql_table_name: `bigquery-analytics-272822.Gsheets.freshair_data`
    ;;

  dimension: disconnection_timestamp {
    type: string
    sql: ${TABLE}.DisconnectionTimestamp ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: uid {
    primary_key: yes
    description: "This is same as Unit #"
    hidden: yes
    type: string
    sql: ${TABLE}.UID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: count_units_with_monitoring_status {
    type: count_distinct
    description: "Returns a count of all distinct units who's FreshAir device has a status of Monitoring"
    sql: CASE WHEN ${status} = 'Monitoring' THEN ${uid} ELSE NULL END ;;
  }

  measure: pct_units_with_monitoring_status {
    label: "Percent Units with Monitoring Status"
    type: number
    description: "Returns the percentage of units who's FreshAir device has a status of Monitoring"
    sql: ${count_units_with_monitoring_status}/NULLIF(${count},0) ;;
    value_format_name: percent_2
  }

  measure: fresh_air_score {
    type: number
    sql:  CASE WHEN ${pct_units_with_monitoring_status} >= ${pom_information.FreshAirStandard} THEN 1
          ELSE ${pct_units_with_monitoring_status} / NULLIF(${pom_information.FreshAirStandard},0)
          END;;
    value_format_name: percent_2
  }

  measure: fresh_air_score_weighted {
    label: "Fresh Air Score (Weighted)"
    type: number
    sql: ${fresh_air_score} * ${pom_information.FreshAir_Weighting} ;;
    value_format_name: percent_2
  }
}
