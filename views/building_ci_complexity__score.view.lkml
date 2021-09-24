view: building_ci_complexity__score {
  derived_table: {
    sql: select * from
      `bigquery-analytics-272822.Gsheets.Building_CI_Complexity _Score`
       ;;
      persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: building_code {
    type: string
    sql: ${TABLE}.BuildingCode ;;
    hidden: yes
  }

  dimension: complexity_score {
    label: "CI Complexity Score"
    view_label: "Building and Geographic Information"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.ComplexityScore ;;
  }

  set: detail {
    fields: [building_code, complexity_score]
  }
}
