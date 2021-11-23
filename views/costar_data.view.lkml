view: costar_data {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.costar_data`
      ;;

    persist_for: "24 hours"

  }

  dimension: primary_key {
    sql: CONCAT(${TABLE}.Hotel_Chain_Scale, ${TABLE}.Property_Type, ${TABLE}.Metro_Area, ${TABLE}.State, ${TABLE}.Month___Night_Available_Date) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: hotel_chain_scale {
    type: string
    sql: ${TABLE}.Hotel_Chain_Scale ;;
  }

  dimension: property_type {
    type: string
    sql: ${TABLE}.Property_Type ;;
  }

  dimension: metro_area {
    label: "Metro"
    type: string
    sql: ${TABLE}.Metro_Area ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: month {
    label: "Month"
    type: date_month
    datatype: date
    sql: ${TABLE}.Month___Night_Available_Date ;;
    convert_tz: no
  }

  dimension: occupancy_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.Occupancy ;;
  }

  dimension: adr_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.ADR ;;
  }

  dimension: rev_par_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.RevPAR ;;
  }

  measure: occupancy {
    type: average_distinct
    sql_distinct_key: ${primary_key} ;;
    label: "Occupancy (CoStar)"
    value_format: "0.00%"
    sql: ${TABLE}.Occupancy ;;
  }

  measure: adr {
    label: "ADR (CoStar)"
    type: average_distinct
    sql_distinct_key: ${primary_key} ;;
    value_format: "$#,##0.00"
    sql: ${TABLE}.ADR ;;
  }

  measure: rev_par {
    label: "RevPAR (CoStar)"
    type: average_distinct
    sql_distinct_key: ${primary_key} ;;
    value_format: "$#,##0.00"
    sql: ${TABLE}.RevPAR ;;
  }

}
