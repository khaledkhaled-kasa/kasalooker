view: adaptive_export_skinny {
  derived_table: {
    sql:
      SELECT PropShrt, PropCode, Building, Metric,
      PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")) Month,
      value, CAST(value as FLOAT64) value_float
        FROM (
        SELECT PropShrt, PropCode, Building, Metric,
          REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') column_name,
          REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
        FROM `bigquery-analytics-272822.Gsheets.adaptive_export` t,
        UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
        )
        WHERE NOT LOWER(column_name) IN ('propshrt','propcode','building', 'metric')
        AND building IS NOT NULL -- This will remove all null records to ensure value_float doesn't fail

       ;;

    datagroup_trigger: adaptive_export_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }

  dimension: composite_primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${TABLE}.PropShrt,${TABLE}.PropCode,${TABLE}.Building,${TABLE}.Metric,${TABLE}.Month) ;;
  }

  dimension: propshrt {
    label: "PropShrt"
    type: string
    sql: ${TABLE}.PropShrt ;;
  }

  dimension: PropCode {
    label: "PropCode"
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: building {
    hidden: yes
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: metric {
    type: string
    sql: ${TABLE}.Metric ;;
  }

  dimension: month {
    type: date
    datatype: date
    sql: ${TABLE}.Month ;;
  }

  dimension: value {
    hidden: yes
    type: number
    sql: ${TABLE}.value_float ;;
  }

  measure: guest_turns {
    type: sum_distinct
    sql: ${value} ;;
    filters: [metric: "Guest Turns"]
  }

  measure: income {
    label: "Top Line Revenue"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;

    filters: [metric: "Income"]
  }

  measure: owner_remittance {
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "Owner Remittance (NetSuite)"]
  }

  measure: owner_profitability {
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "Owner Profitability"]
  }

  measure: owner_profitability_percent {
    label: "Owner Profitability %"
    value_format: "0%"
    type: average_distinct
    sql: ${value} ;;
    filters: [metric: "Owner Profitability %"]
  }

  measure: bhag_margin {
    label: "BHAG Margin"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${value} ;;
    filters: [metric: "BHAG Margin"]
  }

  measure: bhag_margin_percent {
    label: "BHAG Margin %"
    value_format: "0%"
    type: average_distinct
    sql: ${value} ;;
    filters: [metric: "BHAG Margin %"]
  }

  measure: market_rent {
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "Market Rent"]
  }

  measure: lease_rent {
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "Lease Rent"]
  }

  measure: housekeeping {
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${value} ;;
    filters: [metric: "Housekeeping"]
  }

  measure: supplies {
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${value} ;;
    filters: [metric: "Supplies"]
  }

  measure: channel_fees {
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5108 - Channel Fees"]
  }

  measure: maintenance_providers {
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5103 - Maintenance Providers"]
  }

  measure: electric_gas_water_etc {
    label: "Electric/Gas/Water/ Parking/Others"
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5105 - Electric/Gas/Water/ Parking/Others"]
  }

  measure: tv_internet {
    label: "TV/Internet"
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5106 - TV/Internet"]
  }

  measure: gx_allocated_costs {
    label: "GX Allocated Costs"
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5201 - Gx - Allocated Costs"]
  }

  measure: tech_allocated_costs {
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5202 - Tech - Allocated Costs"]
  }

  measure: pom_allocated {
    label: "POM Allocated Costs"
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5205 - POM - Allocated Costs"]
  }

  measure: other_opex {
    label: "All Other OpEx"
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "All Other OpEx"]
  }

  measure: total_operating_expense {
    type: sum_distinct
    group_label: "Operating Expenses"
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "Operating Expense"]
  }

  measure: payment_processing_fees {
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${value} ;;
    filters: [metric: "5111 - Payment Processing Fees"]
  }

  measure: str_operating_cashflow {
    label: "STR Operating Cash Flow (Est.)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${value} ;;
    filters: [metric: "STR Operating Cash Flow (Est.)"]
  }

}
