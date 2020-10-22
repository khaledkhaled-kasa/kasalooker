view: breezeway_export {
  sql_table_name: `bigquery-analytics-272822.Breezeway_Data.export_summary`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: assigned {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Assigned ;;
  }

  dimension_group: assigned_date {
    label: "Assigned"
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
    sql: ${TABLE}.Assigned_Date ;;
  }

  dimension: assigned_employee_ids {
    type: string
    sql: ${TABLE}.Assigned_Employee_IDs ;;
  }

  dimension: assigned_to {
    type: string
    sql: ${TABLE}.Assigned_To ;;
  }

  dimension: bill_to {
    type: string
    sql: ${TABLE}.Bill_To ;;
  }

  dimension: completed {
    type: string
    sql: ${TABLE}.Completed ;;
  }

  dimension: completed_by {
    type: string
    sql: ${TABLE}.Completed_By ;;
  }

  dimension: cost_description {
    type: string
    sql: ${TABLE}.Cost_Description ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Created ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.Created_By ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: done_on_time_ {
    hidden: no
    type: string
    sql: ${TABLE}.Done_on_Time_ ;;
  }

  measure: done_on_time {
    type: count
    filters: {
      field: done_on_time_
      value: "On Time"
    }
  }

  measure: late {
    type: count
    filters: {
      field: done_on_time_
      value: "Late"
    }
  }

  measure: pct_on_time {
    type: number
    value_format: "0.0%"
    sql: ${done_on_time}/${count};;
  }

  dimension: estimate_time_to_complete {
    type: string
    hidden: yes
    sql: ${TABLE}.Estimate_Time_to_Complete ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: past_due_by_ {
    type: string
    sql: ${TABLE}.Past_Due_By_ ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: property_id {
    type: number
    sql: ${TABLE}.Property_ID ;;
  }

  dimension: property_internal_id {
    type: string
    sql: ${TABLE}.Property_Internal_ID ;;
  }

  dimension: property_marketing_id {
    type: string
    sql: ${TABLE}.Property_Marketing_ID ;;
  }

  dimension: rate_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Rate_Paid ;;
  }

  dimension: rate_type {
    type: string
    sql: ${TABLE}.Rate_Type ;;
  }

  dimension: report_summary {
    type: string
    sql: ${TABLE}.Report_Summary ;;
  }

  dimension: requested_by {
    type: string
    sql: ${TABLE}.Requested_By ;;
  }

  dimension_group: started {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Started ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.Tags ;;
  }


  dimension: time_to_complete {
    label: "Completion Duration"
    hidden: no
    sql: ${TABLE}.Time_to_Complete ;;
  }


  dimension: completion_time_mins {
    label: "Completion Time (Minutes)"
    type: number
    hidden: no
    sql: ${TABLE}.Completion_Time__Minutes_ ;;
  }

  measure: average_completion {
    label: "Average Completion Time (Hours)"
    type: average
    hidden: no
    value_format: "0.0"
    sql: ${completion_time_mins} / 60;;
  }


  dimension: total_cost {
    type: number
    sql: ${TABLE}.Total_Cost ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Updated ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
