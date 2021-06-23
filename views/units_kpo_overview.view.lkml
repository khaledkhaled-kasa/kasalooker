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



}
