view: hk_pricing_companies {
  sql_table_name: `bigquery-analytics-272822.Gsheets.hk_pricing_companies`
    ;;

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
