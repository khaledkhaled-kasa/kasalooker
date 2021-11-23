view: compliance_tracker {
  sql_table_name: `bigquery-analytics-272822.portfolio_compliance.compliance_tracker`
    ;;

  dimension: additional_requirements {
    type: string
    sql: ${TABLE}.Additional_Requirements ;;
  }

  dimension: bus_lic {
    type: string
    sql: ${TABLE}.Bus_Lic ;;
  }

  dimension: bus_lic_days_left {
    type: number
    sql: safe_cast(${TABLE}.Bus_Lic_Days_Left as float64) ;;
  }

  dimension: bus_lic_drive_location {
    type: string
    sql: ${TABLE}.Bus_Lic_Drive_Location ;;
  }

  dimension: bus_lic_expiration {
    type: string
    sql: ${TABLE}.Bus_Lic_Expiration ;;
  }

  dimension: bus_lic_renewal_deadline {
    type: string
    sql: ${TABLE}.Bus_Lic_Renewal_Deadline ;;
  }

  dimension: c_of_o {
    type: string
    sql: ${TABLE}.C_of_O ;;
  }

  dimension: c_of_o_days_left {
    type: number
    sql: safe_cast(${TABLE}.C_of_O_Days_Left as float64) ;;
  }

  measure: c_of_o_days_left_measure {
    type: sum
    sql: ${c_of_o_days_left} ;;
  }

  dimension: c_of_o_drive_location {
    type: string
    sql: ${TABLE}.C_of_O_Drive_Location ;;
  }

  dimension: c_of_o_expiration {
    type: string
    sql: ${TABLE}.C_of_O_Expiration ;;
  }

  dimension: c_of_o_renewal_deadline {
    type: string
    sql: ${TABLE}.C_of_O_Renewal_Deadline ;;
  }

  dimension: deactivated {
    type: string
    sql: ${TABLE}.Deactivated ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: municipality {
    type: string
    sql: ${TABLE}.Municipality ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.Owner ;;
  }

  dimension: prop_uid {
    type: string
    sql: ${TABLE}.Prop_UID ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: property_name {
    type: string
    sql: ${TABLE}.Property_Name ;;
  }

  dimension: risk {
    type: number
    sql: ${TABLE}.Risk ;;
  }

  dimension: str_hotel_lic {
    type: string
    sql: ${TABLE}.STR_Hotel_Lic ;;
  }

  dimension: str_hotel_lic_days_left {
    type: number
    sql: safe_cast(${TABLE}.STR_Hotel_Lic_Days_Left as float64) ;;
  }

  dimension: str_hotel_lic_drive_location {
    type: string
    sql: ${TABLE}.STR_Hotel_Lic_Drive_Location ;;
  }

  dimension: str_hotel_lic_expiration {
    type: string
    sql: ${TABLE}.STR_Hotel_Lic_Expiration ;;
  }

  dimension: str_hotel_lic_renewal_deadline {
    type: string
    sql: ${TABLE}.STR_Hotel_Lic_Renewal_Deadline ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  measure: count {
    type: count
    drill_fields: [property_name]
  }
}
