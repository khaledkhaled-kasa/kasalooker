view: hk_pricing_companies {
  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.Gsheets.hk_pricing_companies`
       ;;
    persist_for: "1 hours"
  }

  dimension: property_code {
    hidden: yes
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }


}
