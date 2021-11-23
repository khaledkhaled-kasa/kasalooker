view: adaptive_export_revamped {
  derived_table: {
    sql:

WITH all_tables AS (WITH capacity_table AS (SELECT
    (FORMAT_TIMESTAMP('%Y-%m', CAST(capacities_v3.night_available_date as TIMESTAMP) )) AS capacities_v3_night_month,
    substr(units.internaltitle, 1, 3) AS units_propcode,
        COUNT(DISTINCT CASE WHEN ((DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) < (DATE(CAST(reservations_v3.checkoutdate as TIMESTAMP), 'America/Los_Angeles')) and
        (DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) >= (DATE(TIMESTAMP(reservations_v3.checkindate), 'America/Los_Angeles'))) AND (reservations_v3.status_revised LIKE 'checked_in' OR reservations_v3.status_revised = 'confirmed') THEN CONCAT( reservations_v3.confirmationcode  , '-', ( DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) ) )) ELSE NULL END) / NULLIF(COUNT(DISTINCT CASE WHEN ((capacities_v3.internaltitle LIKE "%-XX") OR (capacities_v3.internaltitle LIKE "%XXX") OR (capacities_v3.internaltitle LIKE "%-RES") OR (capacities_v3.internaltitle LIKE "%-S") OR (capacities_v3.internaltitle LIKE "%GXO%")) THEN NULL
          ELSE CONCAT(capacities_v3.internaltitle, '-', ( DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) ) ))
          END), 0) AS reservations_v3_occupancy,
    COUNT(DISTINCT CASE WHEN ((DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) < (DATE(CAST(reservations_v3.checkoutdate as TIMESTAMP), 'America/Los_Angeles')) and
        (DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) >= (DATE(TIMESTAMP(reservations_v3.checkindate), 'America/Los_Angeles'))) AND (reservations_v3.status_revised LIKE 'checked_in' OR reservations_v3.status_revised = 'confirmed') THEN reservations_v3.confirmationcode  ELSE NULL END) AS reservations_v3_num_reservations,
    COUNT(DISTINCT CASE WHEN ((DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) < (DATE(CAST(reservations_v3.checkoutdate as TIMESTAMP), 'America/Los_Angeles')) and
        (DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) >= (DATE(TIMESTAMP(reservations_v3.checkindate), 'America/Los_Angeles'))) AND (reservations_v3.status_revised LIKE 'checked_in' OR reservations_v3.status_revised = 'confirmed') THEN CONCAT( reservations_v3.confirmationcode  , '-', ( DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) ) )) ELSE NULL END) AS reservations_v3_reservation_night,
    COUNT(DISTINCT CASE WHEN ((capacities_v3.internaltitle LIKE "%-XX") OR (capacities_v3.internaltitle LIKE "%XXX") OR (capacities_v3.internaltitle LIKE "%-RES") OR (capacities_v3.internaltitle LIKE "%-S") OR (capacities_v3.internaltitle LIKE "%GXO%")) THEN NULL
        ELSE CONCAT(capacities_v3.internaltitle, '-', ( DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) ) ))
        END) AS capacities_v3_days_available,
    COUNT(DISTINCT CASE WHEN ((DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) = (DATE(CAST(reservations_v3.checkoutdate as TIMESTAMP), 'America/Los_Angeles'))) AND (NOT COALESCE(reservations_v3.initial_booking = 1 , FALSE)) AND (reservations_v3.status_revised LIKE 'checked_in' OR reservations_v3.status_revised = 'confirmed') THEN CONCAT( units.internaltitle , reservations_v3.confirmationcode  )  ELSE NULL END) AS reservations_v3_number_of_checkouts,
    COUNT(DISTINCT CASE WHEN ((DATE(CAST(capacities_v3.night_available_date as TIMESTAMP) )) = (DATE(TIMESTAMP(reservations_v3.checkindate), 'America/Los_Angeles'))) AND (NOT COALESCE(reservations_v3.extended_booking = 1 , FALSE)) AND (reservations_v3.status_revised LIKE 'checked_in' OR reservations_v3.status_revised = 'confirmed') THEN CONCAT( reservations_v3._id , reservations_v3.confirmationcode  )  ELSE NULL END) AS reservations_v3_number_of_checkins
FROM `bigquery-analytics-272822.dbt.capacities`  AS capacities_v3
INNER JOIN `bigquery-analytics-272822.dbt.units`  AS units ON capacities_v3._id = units._id
LEFT JOIN `bigquery-analytics-272822.dbt.reservations_v3`   AS reservations_v3 ON units._id = reservations_v3.unit
WHERE (((( CAST(capacities_v3.night_available_date as TIMESTAMP)  )) >= TIMESTAMP('2020-01-01 00:00:00')))
GROUP BY
    1,2),

t as (WITH skinny_table AS (SELECT PropShrt, PropCode, Building, Metric,
            LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH) Month,
            FORMAT_TIMESTAMP('%Y-%m', CAST(LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH) as TIMESTAMP)) Month_Year,
            CASE WHEN LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH) < '2021-09-30' THEN 'Audited Month' -- This is where to adjust audited month
            WHEN LAST_DAY(PARSE_DATE('%Y %b %d', CONCAT(RIGHT(column_name,4),LEFT(column_name,3),"01")),MONTH) = '2021-09-30' THEN 'Audited Month (Latest)' -- This is where to adjust audited month latest
            ELSE 'Forecast Month' END Forecast_Month,
            value, SAFE_CAST(value as FLOAT64) value_float
              FROM (
              SELECT PropShrt, PropCode, Building, Metric,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') column_name,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
              FROM `bigquery-analytics-272822.Gsheets.adaptive_export` t,
              UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
              )
              WHERE NOT LOWER(column_name) IN ('propshrt','propcode','building', 'metric')
              AND PropShrt IS NOT NULL) -- This will remove all null records to ensure value_float doesn't fail

              -- Table t is created to sum metrics for properties with different building names (for e.g. Whitley / Whitley PMA)
              SELECT PropShrt, PropCode, Metric, Month, Month_Year, Forecast_Month, sum(value_float) value_float
              FROM skinny_table
              GROUP BY 1,2,3,4,5,6)

      -- Pivoting the table! Any additional metrics need to be included here!
      SELECT PropShrt, PropCode, Month, Forecast_Month,
      ANY_VALUE(if(Metric = 'Guest Turns',value_float,null)) AS Guest_Turns, -- This is originally sourced from Looker (historicals)
      ANY_VALUE(if(Metric = 'Occupied Nights',value_float,null)) AS Occupied_Nights, -- This is originally sourced from Looker (historicals)
      ANY_VALUE(if(Metric = 'Room Nights Available',value_float,null)) AS Room_Nights_Available, -- This is originally sourced from Looker
      ANY_VALUE(if(Metric = 'Income',value_float,null)) AS Income,
      ANY_VALUE(if(Metric = 'Owner Remittance (NetSuite)',value_float,null)) AS Owner_Remittance,
      ANY_VALUE(if(Metric = 'Owner Profitability',value_float,null)) AS Owner_Profitability,
      ANY_VALUE(if(Metric = 'Kasa Profitability',value_float,null)) AS Kasa_Profitability,
      ANY_VALUE(if(Metric = 'BHAG Margin',value_float,null)) AS BHAG_Margin,
      ANY_VALUE(if(Metric = 'Market Rent',value_float,null)) AS Market_Rent,
      ANY_VALUE(if(Metric = 'Lease Rent',value_float,null)) AS Lease_Rent,
      ANY_VALUE(if(Metric = 'Housekeeping',value_float,null)) AS Housekeeping,
      ANY_VALUE(if(Metric = 'Supplies',value_float,null)) AS Supplies,
      ANY_VALUE(if(Metric = '4002 - Cancellation Fee',value_float,null)) AS Cancellation_Fees,
      ANY_VALUE(if(Metric = '4003 - Cleaning Fee',value_float,null)) AS Cleaning_Fees,
      ANY_VALUE(if(Metric = '4009 - Other Fees',value_float,null)) AS Other_Fees,
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
      MAX(capacity_table.reservations_v3_reservation_night) reservation_nights,
      MAX(capacity_table.capacities_v3_days_available) days_available,
      MAX(capacity_table.reservations_v3_number_of_checkouts) num_checkouts,

      FROM t LEFT JOIN capacity_table
      ON t.PropCode = capacity_table.units_propcode
      AND (t.Month_Year = capacity_table.capacities_v3_night_month)


      GROUP BY 1,2,3,4)

      SELECT all_tables.*,
      CASE WHEN Forecast_Month IN ("Audited Month","Audited Month (Latest)") THEN Guest_Turns
      ELSE Guest_Turns
      END Guest_Turns_Mod,
      CASE WHEN Forecast_Month IN ("Audited Month","Audited Month (Latest)") THEN Room_Nights_Available
      ELSE Room_Nights_Available
      END Room_Nights_Available_Mod,
      CASE WHEN Forecast_Month IN ("Audited Month","Audited Month (Latest)") THEN Occupied_Nights
      ELSE Occupied_Nights
      END Occupied_Nights_Mod,
      p.PropOwner, p.POM, p.RevenueManager, p.PortfolioManager, DATE(Month) partition_date
      FROM all_tables
      LEFT JOIN -- JOIN UNIQUE POM BUILDINGS
      (SELECT PropCode, PropOwner, POM, RevenueManager, PortfolioManager
      FROM `bigquery-analytics-272822.Gsheets.pom_information` p
      GROUP BY 1,2,3,4,5) p
      ON all_tables.PropCode = p.PropCode
       ;;

    datagroup_trigger: adaptive_export_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
    partition_keys: ["partition_date"]
  }

  dimension: composite_primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${TABLE}.PropCode,${TABLE}.Month) ;;
  }


  dimension: property_owner {
    description: "This data point is pulled from Col I of the KPO Properties tab."
    hidden: no
    type: string
    sql: ${TABLE}.PropOwner ;;
  }

  dimension: pom {
    label: "POM"
    type: string
    sql: ${TABLE}.POM ;;
  }

  dimension: RevenueManager {
    label: "Revenue Manager"
    description: "This data point is pulled from Col BM of the KPO Properties tab."
    type: string
    sql: ${TABLE}.RevenueManager ;;
  }

  dimension: PortfolioManager {
    label: "Portfolio Manager"
    description: "This data point is pulled from Col BN of the KPO Properties tab."
    type: string
    sql: ${TABLE}.PortfolioManager ;;
  }

  dimension: prop_shrt {
    label: "PropShrt"
    hidden: yes
    type: string
    sql: ${TABLE}.PropShrt ;;
  }


  dimension: prop_code {
    label: "PropCode"
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: month {
    hidden: no
    label: "Financial Month (Adaptive)"
    description: "This date should be used instead of 'Night Available Month' in cases where units retrieve income outside of their active dates."
    type: date_month
    datatype: date
    sql: ${TABLE}.Month;;
  }


  dimension: month_finance_audit {
    label: "Financial Month (Adaptive) / Night Available Month"
    description: "This date will select from 'Night Available Month' or 'Financial Month (Adaptive)', whichever of them is available."
    type: date_month
    datatype: date
    sql:  case
    when ${TABLE}.Month is not NULL then ${TABLE}.Month
    when date(${financials_audit.night_date}) is not null and date(${TABLE}.Month) is null then date(${financials_audit.night_date})
    else NULL
    end;;
  }



  dimension: forecast_month {
    label: "Month (Audited / Forecast)?"
    description: "A month is usually 'Audited' after we have surpassed 15-25 days into the subsequent month. This is updated on a monthly basis in coordination with the Finance team."
    type: string
    sql: ${TABLE}.Forecast_Month ;;
  }


  dimension: occupied_nights {
    hidden: yes
    label: "Occupied Nights (Adaptive)"
    type: number
    sql: ${TABLE}.Occupied_Nights_Mod ;;
  }

  dimension: room_nights_available {
    hidden: yes
    label: "Room Nights Available (Adaptive)"
    type: number
    sql: ${TABLE}.Room_Nights_Available_Mod ;;
  }


  dimension: income {
    hidden: yes
    value_format: "$#,##0.00"
    label: "Income (Adaptive)"
    type: number
    sql: ${TABLE}.Income ;;
  }

  measure: income_measure {
    hidden: yes
    value_format: "$#,##0.00"
    label: "Income (Adaptive)"
    type: sum_distinct
    sql: ${TABLE}.Income ;;
  }

  measure: income_audited_hidden {
    label: "Audited Top Line Revenue (Monthly)"
    hidden: yes
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Income;;
    filters: [forecast_month: "Audited Month, Audited Month (Latest)"]
  }

  measure: income_audited_exposed {
    label: "Audited Top Line Revenue (Monthly)"
    description: "This will pull income statements from Adaptive for only audited months. This is a revised measure of the 'Amount' measure under the Financials view after financial auditing."
    type: number
    value_format: "$#,##0"
    sql: NULLIF(${income_audited_hidden},0);;
  }

  measure: income_forecast_hidden {
    label: "Forecast Top Line Revenue (Monthly)"
    hidden: yes
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Income;;
    filters: [forecast_month: "Forecast Month, Audited Month (Latest)"]
  }

  measure: income_forecast_exposed {
    label: "Forecast Top Line Revenue (Monthly)"
    description: "This will pull income statements from Adaptive for only forecast months. Live revenues can be captured from the 'Amount' measure under the Financials view."
    type: number
    value_format: "$#,##0"
    sql: NULLIF(${income_forecast_hidden},0) ;;
  }


  measure: occupied_nights_forecast_hidden {
    hidden: yes
    label: "Forecast Occupied Nights (Monthly)"
    type: sum_distinct
    sql: ${TABLE}.Occupied_Nights_Mod ;;
    filters: [forecast_month: "Forecast Month, Audited Month (Latest)"]
  }

  measure: occupied_nights_forecast_exposed {
    description: "This will pull the occupied nights from Adaptive for only forecast months. Live occupied nights can be retrieved from the 'NumReservationNights' measure under the Reservations view."
    hidden: no
    label: "Forecast Occupied Nights (Monthly)"
    type: number
    sql: NULLIF(${occupied_nights_forecast_hidden},0) ;;
  }

  measure: occupied_nights_audited_hidden {
    hidden: yes
    label: "Audited Occupied Nights (Monthly)"
    type: sum_distinct
    sql: ${TABLE}.Occupied_Nights_Mod ;;
    filters: [forecast_month: "Audited Month, Audited Month (Latest)"]
  }

  measure: occupied_nights_audited_exposed {
    description: "This will pull the occupied nights from the time of entry in Adaptive, for only audited months. Live Occupied Nights can be retrieved from the 'NumReservationNights' measure under the Reservations view."
    hidden: no
    label: "Audited Occupied Nights (Monthly)"
    type: number
    sql: NULLIF(${occupied_nights_audited_hidden},0) ;;
  }


  measure: room_nights_available_audited {
    description: "This will pull the room nights available from the time of entry in Adaptive, for only audited months. Live room nights available can be retrieved from the 'Capacity' measure under the Capacities view."
    hidden: no
    label: "Audited Room Nights Available (Adaptive)"
    type: sum_distinct
    sql: ${TABLE}.Room_Nights_Available_Mod ;;
    filters: [forecast_month: "Audited Month, Audited Month (Latest)"]
  }

  measure: room_nights_available_forecast{
    hidden: no
    label: "Forecast Room Nights Available (Adaptive)"
    type: sum_distinct
    sql: ${TABLE}.Room_Nights_Available_Mod ;;
    filters: [forecast_month: "Forecast Month, Audited Month (Latest)"]
  }


  measure: occupancy_forecast {
    label: "Forecast Occupancy (Monthly)"
    description: "This will pull the monthly forecast occupied nights divided by the monthly forecast room nights available from adaptive, for only forecast months. Live occupancy can be retrieved from the 'Occupancy' measure under the Reservations view."
    type: number
    value_format: "0.0%"
    sql: ${occupied_nights_forecast_exposed} / nullif(${room_nights_available_forecast},0) ;;
  }

  measure: occupancy_audited {
    description: "This will pull the monthly audited occupied nights divided by the monthly audited room nights available from the time of entry in Adaptive, for only audited months. Live occupancy can be retrieved from the 'Occupancy' measure under the Reservations view."
    hidden: no
    label: "Audited Occupancy (Monthly)"
    type: number
    value_format: "0.0%"
    sql: ${occupied_nights_audited_exposed} / nullif(${room_nights_available_audited},0) ;;

  }

  measure: guest_turns_audited_hidden {
    hidden: yes
    label: "Audited Guest Turns (Monthly)"
    type: sum_distinct
    sql: ${TABLE}.Guest_Turns_Mod ;;
    filters: [forecast_month: "Audited Month, Audited Month (Latest)"]
  }

  measure: guest_turns_audited_exposed {
    description: "This will pull the monthly audited guest turns from the time of entry in Adaptive, for only audited months. Live Guest Turns can be retrieved from the 'Number of Checkouts' measure under the Reservations view."
    hidden: no
    label: "Audited Guest Turns (Monthly)"
    type: number
    sql: NULLIF(${guest_turns_audited_hidden},0);;
  }


  measure: guest_turns_forecast_hidden {
    label: "Forecast Guest Turns (Monthly)"
    hidden: yes
    type: sum_distinct
    sql: ${TABLE}.Guest_Turns_Mod ;;
    filters: [forecast_month: "Forecast Month, Audited Month (Latest)"]
  }

  measure: guest_turns_forecast_exposed {
    label: "Forecast Guest Turns (Monthly)"
    description: "This will pull the monthly forecast guest turns from Adaptive, for only forecast months. Live Guest Turns can be retrieved from the 'Number of Checkouts' measure under the Reservations view."
    type: number
    sql: NULLIF(${guest_turns_forecast_hidden},0) ;;
  }


  measure: adr_revamped {
    label: "Audited ADR (Monthly)"
    description: "This will pull ADR based on finalized income statements from Adaptive, for audited months, divided by the total number of occupied nights from Adaptive."
    type: number
    value_format: "$#,##0.00"
    sql: ${income_audited_exposed} / NULLIF(${occupied_nights_audited_exposed}, 0);;
    drill_fields: [month, prop_code, income, occupied_nights]
  }


  measure: forecast_adr {
    label: "Forecast ADR (Monthly)"
    description: "This will pull ADR based on the forecast income statements from adaptive, for forecast months, divided by the forecast occupied room nights from adaptive. Live ADR can be retrieved from the 'ADR' measure under the Financials view."
    value_format: "$#,##0.00"
    type: number
    sql: ${income_forecast_exposed} / NULLIF(${occupied_nights_forecast_exposed},0) ;;
    drill_fields: [month, prop_code, income, occupied_nights]
  }

  measure: revpar_revamped {
    label: "Audited RevPAR (Monthly)"
    description: "This will pull RevPAR based on finalized income statements from Adaptive, for audited months, divided by the total number of nights available from Adaptive."
    type: number
    value_format: "$#,##0.00"
    sql: ${income_audited_exposed} / NULLIF(${room_nights_available_audited}, 0);;
    drill_fields: [month, prop_code, occupied_nights, income, room_nights_available]
  }


  measure: forecast_revpar {
    value_format: "$#,##0.00"
    label: "Forecast RevPAR (Monthly)"
    description: "This will pull RevPAR based on forecast income statements from Adaptive, for forecast months, divided by the forecast room nights available from Adaptive. Live RevPAR can be retrieved from the 'RevPAR' measure under the Financials view."
    type: number
    sql: ${income_forecast_exposed} / NULLIF(${room_nights_available_forecast},0) ;;
    drill_fields: [month, prop_code, occupied_nights, income, room_nights_available]
    }


  measure: monthly_owner_remittance {
    label: "Owner Remittance (Monthly)"
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Owner_Remittance ;;
  }

  measure: monthly_owner_profitability {
    label: "Owner Profitability (Monthly)"
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Owner_Profitability ;;
  }

  measure: monthly_kasa_profitability {
    label: "Kasa Profitability (Monthly)"
    description: "This data is pulled from an Adaptive export"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Kasa_Profitability ;;
  }

  measure: owner_profitability_percent {
    description: "This data is pulled from an Adaptive export"
    label: "Owner Profitability % (Monthly)"
    value_format: "0%"
    type: number
    sql: ${monthly_owner_profitability} / nullif(${income_measure},0) ;;
  }

  measure: kasa_profitability_percent {
    description: "This data is pulled from an Adaptive export"
    label: "Kasa Profitability % (Monthly)"
    value_format: "0%"
    type: number
    sql: ${monthly_kasa_profitability} / nullif(${income_measure},0) ;;
  }

  measure: monthly_bhag_margin {
    description: "This data is pulled from an Adaptive export"
    label: "BHAG Margin (Monthly)"
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.BHAG_Margin ;;
  }

  measure: monthly_bhag_margin_percent {
    description: "This data is pulled from an Adaptive export"
    label: "BHAG Margin % (Monthly)"
    value_format: "0%"
    type: number
    sql: ${monthly_bhag_margin} / nullif(${income_measure},0) ;;
  }

  measure: market_rent {
    description: "This data is pulled from CoStar on a quarterly basis by Real Estate. This gives us a real time view into the health of the market."
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Market_Rent ;;
  }

  measure: lease_rent {
    description: "This data is pulled from the time of entry in adaptive based on the KPO (static per lease agreement)."
    type: sum_distinct
    value_format: "$#,##0"
    sql: ${TABLE}.Lease_Rent ;;
  }

  measure: housekeeping {
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Housekeeping ;;
  }

  measure: supplies {
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Supplies ;;
  }

  measure: channel_fees {
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Channel_Fees ;;
  }

  measure: maintenance_providers {
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Maintenance_Providers ;;
  }

  measure: electric_gas_water_parking_others {
    label: "Electric/Gas/Water/ Parking/Others"
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Electric_Gas_Water_Parking_Others ;;
  }

  measure: tv_internet {
    label: "TV/Internet"
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.TV_Internet ;;
  }

  measure: allocated_gx_costs {
    label: "Allocated GX Costs"
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_GX_Costs ;;
  }

  measure: allocated_tech_costs {
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_Tech_Costs ;;
  }

  measure: allocated_pom_costs {
    label: "Allocated POM Costs"
    group_label: "Operating Expenses (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Allocated_POM_Costs ;;
  }

  measure: all_other_opex {
    group_label: "Operating Expenses (Monthly)"
    label: "All Other OPEX Costs"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.All_Other_OPEX ;;
  }

  measure: monthly_total_operating_expenses {
    label: "Total Operating Expenses (Monthly)"
    description: "This will pull the total operating expenses on a monthly basis from Adaptive. For a breakdown, you can either click on the drill-down option or navigate to the 'Operating Expenses (Monthly)' group label"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Operating_Expense ;;
    drill_fields: [month, prop_code, housekeeping, supplies, channel_fees, maintenance_providers, electric_gas_water_parking_others, tv_internet, allocated_gx_costs, allocated_tech_costs, allocated_pom_costs, all_other_opex]
  }

  measure: monthly_payment_processing_fees {
    group_label: "Fees (Monthly)"
    label: "Payment Processing Fees (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Payment_Processing_Fees ;;
  }

  measure: cancellation_fees {
    group_label: "Fees (Monthly)"
    label: "Cancellation Fees (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Cancellation_Fees ;;
  }

  measure: cleaning_fees {
    group_label: "Fees (Monthly)"
    label: "Cleaning Fees (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Cleaning_Fees ;;
  }

  measure: other_fees {
    group_label: "Fees (Monthly)"
    label: "Other Fees (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.Other_Fees ;;
  }


  measure: str_operating_cash_flow {
    label: "STR Operating Cash Flow Est. (Monthly)"
    value_format: "$#,##0"
    type: sum_distinct
    sql: ${TABLE}.STR_Operating_Cash_Flow ;;
  }

  measure: str_operating_cash_flow_percent {
    label: "STR Operating Cash Flow Est. % (Monthly)"
    value_format: "0%"
    type: number
    sql: ${str_operating_cash_flow} / nullif(${income_measure},0) ;;
  }




}
