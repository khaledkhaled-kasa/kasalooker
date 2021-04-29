view: t_s_security_deployment {
  label: "T & S Security Deployment"
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.t_s_security_deployments`
      ;;
  }

  dimension_group: date_of_deployment {
    type: time
    datatype: date
    label: "Deployment"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date_of_Deployment;;
    convert_tz: no
  }

  dimension: property_location {
    label: "Property Code"
    type: string
    sql: ${TABLE}.Property_Location ;;
  }

  dimension: total_hours_deployed {
    type: number
    sql: ${TABLE}.Total_Hours_Deployed ;;
  }

  dimension: total_cost {
    type: number
    value_format: "$#,##0.0"
    sql: ${TABLE}.Total_Cost ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}.Vendor ;;
  }

  measure: count {
    label: "Sum of Incident Reports"
    type: count
    drill_fields: [detail*]
  }

  measure: sum_cost {
    label: "Total Costs"
    type: sum
    value_format: "$#,##0.0"
    sql: ${TABLE}.Total_Cost ;;
    drill_fields: [detail*]
  }

  measure: sum_hours {
    label: "Total Hours Deployed"
    type: sum
    sql: ${TABLE}.Total_Hours_Deployed ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [date_of_deployment_date, property_location, total_hours_deployed, total_cost, vendor]
  }
}
