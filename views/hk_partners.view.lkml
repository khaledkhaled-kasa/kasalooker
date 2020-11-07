view: hk_partners {
  sql_table_name: `bigquery-analytics-272822.Breezeway_Data.hk_partners`
    ;;

  dimension: buildings {
    type: string
    sql: ${TABLE}.Buildings ;;
  }

  dimension: comm_preferred {
    type: string
    sql: ${TABLE}.Comm_Preferred ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.Company_Name ;;
  }

  dimension: daily_occupancy_report_set_up {
    type: yesno
    sql: ${TABLE}.Daily_Occupancy_Report_set_up ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: home_address {
    type: string
    sql: ${TABLE}.Home_Address ;;
  }

  dimension: housekeeper {
    type: string
    sql: ${TABLE}.Housekeeper ;;
  }

  dimension: kasa_manager {
    type: string
    sql: ${TABLE}.Kasa_Manager ;;
  }

  dimension: kasa_region {
    type: string
    sql: ${TABLE}.Kasa_Region ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.Metro ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.Phone ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}
