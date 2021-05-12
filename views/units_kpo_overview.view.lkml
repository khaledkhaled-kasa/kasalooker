view: units_kpo_overview {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.kpo_overview_clean`
    ;;

    datagroup_trigger: units_kpo_overview_default_datagroup
  }

  dimension: uid {
    label: "Unit ID"
    primary_key: yes
    type: string
    sql: ${TABLE}.UID ;;
  }

  dimension: prop_code {
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension_group: initial_contract {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.InitialContract) ;;
    convert_tz: no
  }

  dimension: contract_type {
    type: string
    sql: ${TABLE}.ContractType ;;
  }


  dimension_group: first_available {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.FirstAvailableDate) ;;
    convert_tz: no
  }

  dimension_group: deactivated {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.DeactivatedDate) ;;
    convert_tz: no
  }


  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension_group: current_contract_start {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.CurrentContractStartDate) ;;
    convert_tz: no
  }

  dimension: new_building {
    type: string
    sql: ${TABLE}.NewBuilding ;;
  }

  dimension: new_partner {
    type: string
    sql: ${TABLE}.NewPartner ;;
  }


  dimension_group: contract_signed {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.ContractSignedDate) ;;
    convert_tz: no
  }

  dimension: jan_21 {
    type: string
    sql:
    CASE
    WHEN (${first_available_date} <= '2021-01-31' AND (${deactivated_date} > "2021-01-31" OR ${deactivated_date} is NULL)) THEN "Jan_21"
    WHEN (${first_available_date} <= '2021-02-28' AND (${deactivated_date} > "2021-02-28" OR ${deactivated_date} is NULL)) THEN "Feb_21"
    WHEN (${first_available_date} <= '2021-03-31' AND (${deactivated_date} > "2021-03-31" OR ${deactivated_date} is NULL)) THEN "Mar_21"
    WHEN (${first_available_date} <= '2021-04-30' AND (${deactivated_date} > "2021-04-30" OR ${deactivated_date} is NULL)) THEN "Apr_21"
    WHEN (${first_available_date} <= '2021-05-31' AND (${deactivated_date} > "2021-05-31" OR ${deactivated_date} is NULL)) THEN "May_21"
    WHEN (${first_available_date} <= '2021-06-30' AND (${deactivated_date} > "2021-06-30" OR ${deactivated_date} is NULL)) THEN "June_21"
    WHEN (${first_available_date} <= '2021-07-31' AND (${deactivated_date} > "2021-07-31" OR ${deactivated_date} is NULL)) THEN "Jul_21"
    WHEN (${first_available_date} <= '2021-08-31' AND (${deactivated_date} > "2021-08-31" OR ${deactivated_date} is NULL)) THEN "Aug_21"
    WHEN (${first_available_date} <= '2021-09-30' AND (${deactivated_date} > "2021-09-30" OR ${deactivated_date} is NULL)) THEN "Sep_21"
    WHEN (${first_available_date} <= '2021-10-31' AND (${deactivated_date} > "2021-10-31" OR ${deactivated_date} is NULL)) THEN "Nov_21"
    WHEN (${first_available_date} <= '2021-11-30' AND (${deactivated_date} > "2021-11-30" OR ${deactivated_date} is NULL)) THEN "Dec_21"
    ELSE "Other Months"
    END;;
  }

  measure: count {
    label: "# of Units"
    type: count_distinct
    sql: ${jan_21} ;;
  }



}
