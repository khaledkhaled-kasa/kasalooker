view: hk_pricing_unit_specific {
  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.Gsheets.hk_pricing_unit_specific`
       ;;
    persist_for: "1 hours"
  }

  dimension: building_title {
    type: string
    sql: ${TABLE}.Building_Title ;;
  }

  dimension: pricing {
    type: number
    sql: ${TABLE}.Pricing ;;
  }

  dimension: property_code {
    type: string
    sql: ${TABLE}.Property_Code ;;
  }

  dimension: task {
    type: string
    sql: TRIM(${TABLE}.Task) ;;
  }

  dimension: door {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: unit {
    type: string
    sql: CONCAT(${TABLE}.Property_Code,"-",${TABLE}.Unit) ;;
  }
}
