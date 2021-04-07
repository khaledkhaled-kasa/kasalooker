view: hk_pricing_unit_specific {
  sql_table_name: `bigquery-analytics-272822.Gsheets.hk_pricing_unit_specific`
    ;;

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
    sql: ${TABLE}.Task ;;
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
