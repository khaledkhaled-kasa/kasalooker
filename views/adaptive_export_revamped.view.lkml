view: adaptive_export_revamped {
  derived_table: {
    sql:

    -- This table will convert the original wide adaptive_export to a narrow table (month as a new column)
      WITH t as (SELECT PropShrt, PropCode, Building, Metric,
            LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH) Month,
            CASE WHEN current_date() >= DATE_ADD(LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH), INTERVAL 15 DAY) THEN "Audited Month"
            ELSE "Forecast Month" END Forecast_Month,
            value, SAFE_CAST(value as FLOAT64) value_float
              FROM (
              SELECT PropShrt, PropCode, Building, Metric,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') column_name,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
              FROM `bigquery-analytics-272822.Gsheets.adaptive_export` t,
              UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
              )
              WHERE NOT LOWER(column_name) IN ('propshrt','propcode','building', 'metric')
              AND building IS NOT NULL -- This will remove all null records to ensure value_float doesn't fail
      )

      -- Pivoting the table! Any additioanl metrics need to be included here!
      SELECT PropShrt, PropCode, Building, Month, Forecast_Month,
      ANY_VALUE(if(Metric = 'ADR',value_float,null)) AS ADR,
      ANY_VALUE(if(Metric = 'RevPAR',value_float,null)) AS RevPAR,
      ANY_VALUE(if(Metric = 'Occupancy %',value_float,null)) AS Occupancy,
      ANY_VALUE(if(Metric = 'Units Available',value_float,null)) AS Units_Available, -- This is originally sourced from Looker
      ANY_VALUE(if(Metric = 'Guest Turns',value_float,null)) AS Guest_Turns, -- This is originally sourced from Looker (historicals)
      ANY_VALUE(if(Metric = 'Length of Stay',value_float,null)) AS LOS, -- This is originally sourced from Looker (historicals)
      ANY_VALUE(if(Metric = 'Occupied Nights',value_float,null)) AS Occupied_Nights, -- This is originally sourced from Looker (historicals)
      ANY_VALUE(if(Metric = 'Room Nights Available',value_float,null)) AS Room_Nights_Available, -- This is originally sourced from Looker
      ANY_VALUE(if(Metric = 'Income',value_float,null)) AS Income,
      ANY_VALUE(if(Metric = 'Owner Remittance (NetSuite)',value_float,null)) AS Owner_Remittance,
      ANY_VALUE(if(Metric = 'Owner Profitability',value_float,null)) AS Owner_Profitability,
      ANY_VALUE(if(Metric = 'Owner Profitability %',value_float,null)) AS Owner_Profitability_Percent,
      ANY_VALUE(if(Metric = 'BHAG Margin',value_float,null)) AS BHAG_Margin,
      ANY_VALUE(if(Metric = 'BHAG Margin %',value_float,null)) AS BHAG_Margin_Percent,
      ANY_VALUE(if(Metric = 'Market Rent',value_float,null)) AS Market_Rent,
      ANY_VALUE(if(Metric = 'Lease Rent',value_float,null)) AS Lease_Rent,
      ANY_VALUE(if(Metric = 'Housekeeping',value_float,null)) AS Housekeeping,
      ANY_VALUE(if(Metric = 'Supplies',value_float,null)) AS Supplies,
      ANY_VALUE(if(Metric = '5108 - Channel Fees',value_float,null)) AS Channel_Fees,
      ANY_VALUE(if(Metric = '5103 - Maintenance Providers',value_float,null)) AS Maintenance_Providers,
      ANY_VALUE(if(Metric = '5105 - Electric/Gas/Water/ Parking/Others',value_float,null)) AS Electric_Gas_Water_Parking_Others,
      ANY_VALUE(if(Metric = '5106 - TV/Internet',value_float,null)) AS TV_Internet,
      ANY_VALUE(if(Metric = '5201 - Gx - Allocated Costs',value_float,null)) AS Allocated_GX_Costs,
      ANY_VALUE(if(Metric = '5202 - Tech - Allocated Costs',value_float,null)) AS Allocated_Tech_Costs,
      ANY_VALUE(if(Metric = '5205 - POM - Allocated Costs',value_float,null)) AS Allocated_POM_Costs,
      ANY_VALUE(if(Metric = 'All Other OpEx',value_float,null)) AS All_Other_OPEX,
      ANY_VALUE(if(Metric = 'Operating Expense',value_float,null)) AS Operating_Expense,
      ANY_VALUE(if(Metric = '5111 - Payment Processing Fees',value_float,null)) AS Payment_Processing_Fees,
      ANY_VALUE(if(Metric = 'STR Operating Cash Flow (Est.)',value_float,null)) AS STR_Operating_Cash_Flow,

      FROM t
      GROUP BY 1,2,3,4,5
       ;;

    datagroup_trigger: adaptive_export_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }

  dimension: composite_primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${TABLE}.Building,${TABLE}.Month) ;;
  }


  dimension: prop_shrt {
    label: "PropShrt"
    hidden: yes
    type: string
    sql: ${TABLE}.PropShrt ;;
  }

  dimension: building {
    description: "This will pull the building name as displayed in the adaptive export."
    hidden: no
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: prop_code {
    label: "PropCode"
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: month {
    label: "Financial Month (Adaptive)"
    description: "This date should be used instead of 'Night Available Month' in cases where units retrieve income outside of their active dates."
    type: date_month
    datatype: date
    sql: ${TABLE}.Month;;
  }

  dimension: forecast_month {
    label: "Month (Audited / Forecast)?"
    description: "A month is considered 'Audited' if we have surpassed 15 days into the subsequent month (i.e. July-2021 month is automatically classified as audited on 15-Aug-2021)"
    type: string
    sql: ${TABLE}.Forecast_Month ;;
  }

  dimension: occupancy {
    hidden: yes
    label: "Occupancy (Adaptive)"
    type: number
    value_format: "0.00%"
    sql: ${TABLE}.Occupancy ;;
  }


  dimension: occupied_nights {
    hidden: yes
    label: "Occupied Nights (Adaptive)"
    type: number
    sql: ${TABLE}.Occupied_Nights ;;
  }

  dimension: adr {
    hidden: yes
    value_format: "$#,##0.00"
    label: "ADR (Adaptive)"
    type: number
    sql: ${TABLE}.ADR ;;
  }

  dimension: revpar {
    hidden: yes
    value_format: "$#,##0.00"
    label: "RevPAR (Adaptive)"
    type: number
    sql: ${TABLE}.RevPAR ;;
  }


  dimension: income {
    hidden: yes
    value_format: "$#,##0.00"
    label: "Income (Adaptive)"
    type: number
    sql: ${TABLE}.Income ;;
  }

  measure: occupancy_forecast {
    label: "Monthly Forecast Occupancy (Adaptive)"
    description: "This will pull the monthly forecast from Adaptive for unaudited months. Live occupancy can be retrieved from the 'Occupancy' measure under the Reservations view."
    type: average_distinct
    value_format: "0.00%"
    sql: ${TABLE}.Occupancy ;;
    filters: [forecast_month: "Forecast Month"]
  }

  measure: guest_turns_hidden {
    label: "Monthly Forecast Guest Turns (Adaptive)"
    description: "This will pull the monthly forecast from Adaptive. Live Guest Turns can be retrieved from the 'Number of Checkouts' measure under the Reservations view."
    hidden: yes
    type: sum_distinct
    sql: ${TABLE}.Guest_Turns ;;
    filters: [forecast_month: "Forecast Month"]
  }

  # This field is meant to convert all coalesced 0s in guest_turns_hidden to nulls
  measure: guest_turns_exposed {
    label: "Monthly Forecast Guest Turns (Adaptive)"
    description: "This will pull the monthly forecast from Adaptive. Live Guest Turns can be retrieved from the 'Number of Checkouts' measure under the Reservations view."
    type: number
    sql: CASE WHEN (${guest_turns_hidden} = 0) THEN NULL ELSE ${guest_turns_hidden} END;;
  }

  measure: income_audited_hidden {
    label: "Monthly Audited Top Line Revenue (Adaptive)"
    hidden: yes
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Income;;
    filters: [forecast_month: "Audited Month"]
  }

  measure: income_audited_exposed {
    label: "Monthly Audited Top Line Revenue (Adaptive)"
    description: "This will pull income statements from Adaptive for only audited months. This will essentially retrieve the 'Amount' measure under the Financials view after financial auditing."
    type: number
    value_format: "$#,##0"
    sql: CASE WHEN ${income_audited_hidden} = 0 THEN NULL ELSE ${income_audited_hidden} END;;
  }

  measure: income_forecast_hidden {
    label: "Monthly Forecast Top Line Revenue (Adaptive)"
    hidden: yes
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Income;;
    filters: [forecast_month: "Forecast Month"]
  }

  measure: income_forecast_exposed {
    label: "Monthly Forecast Top Line Revenue (Adaptive)"
    description: "This will pull income statements from Adaptive for only forecast months. Live revenues can be captured from the 'Amount' measure under the Financials view."
    type: number
    value_format: "$#,##0"
    sql: CASE WHEN ${income_forecast_hidden} = 0 THEN NULL ELSE ${income_forecast_hidden} END;;
  }

  measure: adr_revamped {
    label: " Monthly Audited ADR (Adaptive)"
    description: "This will pull ADR based on finalized income statements from Adaptive, for audited months, divided by the total number of reservation nights from Looker. This will essentially retrieve the 'ADR' measure under the Financials view after financial auditing."
    type: number
    value_format: "$#,##0.00"
    sql: ${income_audited_exposed} / NULLIF(${reservations_v3.reservation_night}, 0);;
    drill_fields: [reservations_v3.reservation_night, reservations_v3.num_reservations, income]
  }

  measure: revpar_revamped {
    label: "Monthly Audited RevPAR (Adaptive)"
    description: "This will pull RevPAR based on finalized income statements from Adaptive, for audited months, divided by the total number of nights available from Looker. This will essentially retrieve the 'RevPAR' measure under the Financials view after financial auditing."
    type: number
    value_format: "$#,##0.00"
    sql: ${income_audited_exposed} / NULLIF(${capacities_v3.capacity}, 0);;
    drill_fields: [reservations_v3.reservation_night, reservations_v3.num_reservations, income, capacities_v3.capacity]
  }


  measure: forecast_adr {
    label: "Monthly Forecast ADR (Adaptive)"
    description: "This will pull the monthly forecast from Adaptive for unaudited months. Live ADR can be retrieved from the 'ADR' measure under the Financials view."
    value_format: "$#,##0.00"
    type: average_distinct
    sql: ${TABLE}.ADR ;;
    filters: [forecast_month: "Forecast Month"]
    drill_fields: [month, prop_code, occupied_nights, income, adr]
  }

  measure: forecast_revpar {
    value_format: "$#,##0.00"
    label: "Monthly Forecast RevPAR (Adaptive)"
    description: "This will pull the monthly forecast from Adaptive for unaudited months. Live RevPAR can be retrieved from the 'RevPAR' measure under the Financials view."
    type: average_distinct
    sql: ${TABLE}.RevPAR ;;
    filters: [forecast_month: "Forecast Month"]
    drill_fields: [month, prop_code, occupied_nights, income, adr, occupancy, revpar]
  }

  measure: monthly_owner_remittance {
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Owner_Remittance ;;
  }

  measure: monthly_owner_profitability {
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Owner_Profitability ;;
  }

  measure: owner_profitability_percent {
    description: "This data is pulled from an Adaptive export"
    label: "Monthly Owner Profitability %"
    value_format: "0%"
    type: average_distinct
    sql: ${TABLE}.Owner_Profitability_Percent ;;
  }

  measure: bhag_margin {
    description: "This data is pulled from an Adaptive export"
    label: "Monthly BHAG Margin"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.BHAG_Margin ;;
  }

  measure: monthly_bhag_margin_percent {
    description: "This data is pulled from an Adaptive export"
    label: "Monthly BHAG Margin %"
    value_format: "0%"
    type: average_distinct
    sql: ${TABLE}.BHAG_Margin_Percent ;;
  }

  measure: market_rent {
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Market_Rent ;;
  }

  measure: lease_rent {
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Lease_Rent ;;
  }

  measure: housekeeping {
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Housekeeping ;;
  }

  measure: supplies {
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Supplies ;;
  }

  measure: channel_fees {
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Channel_Fees ;;
  }

  measure: maintenance_providers {
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Maintenance_Providers ;;
  }

  measure: electric_gas_water_parking_others {
    label: "Electric/Gas/Water/ Parking/Others"
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Electric_Gas_Water_Parking_Others ;;
  }

  measure: tv_internet {
    label: "TV/Internet"
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.TV_Internet ;;
  }

  measure: allocated_gx_costs {
    label: "Allocated GX Costs"
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_GX_Costs ;;
  }

  measure: allocated_tech_costs {
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_Tech_Costs ;;
  }

  measure: allocated_pom_costs {
    label: "Allocated POM Costs"
    group_label: "Monthly Operating Expenses"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_POM_Costs ;;
  }

  measure: all_other_opex {
    group_label: "Monthly Operating Expenses"
    label: "All Other OPEX Costs"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.All_Other_OPEX ;;
  }

  measure: monthly_total_operating_expenses {
    description: "This will pull the total operating expenses on a monthly basis from Adaptive. For a breakdown, you can either click on the drill-down option or navigate to the 'Monthly Operating Expenses' group label"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Operating_Expense ;;
    drill_fields: [month, prop_code, housekeeping, supplies, channel_fees, maintenance_providers, electric_gas_water_parking_others, tv_internet, allocated_gx_costs, allocated_tech_costs, allocated_pom_costs, all_other_opex]
  }

  measure: monthly_payment_processing_fees {
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Payment_Processing_Fees ;;
  }

  measure: str_operating_cash_flow {
    label: "Monthly STR Operating Cash Flow (Est.)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.STR_Operating_Cash_Flow ;;
  }




}
