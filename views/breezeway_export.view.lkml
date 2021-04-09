view: breezeway_export {
  derived_table: {
    sql: SELECT *
    FROM `bigquery-analytics-272822.Breezeway_Data.export_summary` ;;

    datagroup_trigger: breezeway_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
}
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
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Assigned ;;
  }

  dimension_group: assigned_date {
    view_label: "Date Dimensions"
    group_label: "BW Assigned Date"
    label: ""
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
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Assigned_Date ;;
  }

  dimension_group: completed_date {
    view_label: "Date Dimensions"
    group_label: "BW Completed Date"
    label: ""
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
    convert_tz: no
    # datatype: date
    sql: TIMESTAMP(${TABLE}.Completed) ;;
  }


  dimension: assigned_employee_ids {
    hidden: yes
    type: string
    sql: ${TABLE}.Assigned_Employee_IDs ;;
  }

  dimension: assigned_to {
    type: string
    sql: ${TABLE}.Assigned_To ;;
  }

  dimension: bill_to {
    hidden: yes
    type: string
    sql: ${TABLE}.Bill_To ;;
  }

  dimension: completed {
    hidden: yes
    type: string
    sql: ${TABLE}.Completed ;;
  }

  dimension: completed_by {
    type: string
    sql: ${TABLE}.Completed_By ;;
  }

  dimension: cost_description {
    hidden: yes
    type: string
    sql: ${TABLE}.Cost_Description ;;
  }

  dimension: scorecard_name {
    hidden: yes
    type: string
    label: "Partner Name"
    sql: ${TABLE}.Scorecard_Name ;;
  }

  dimension: hk_name {
    type: string
    label: "Housekeeper Name"
    sql: CASE WHEN ${TABLE}.Housekeeper_Name IN ("Jason Schaniel","Jason O'Connell","Karlynne Sampson","Connor Harris","Megan Bencen","Alex Molitor","Jeff Orton","Patrick Bartlett","Chaena Cage","Caitlin Amen","Allison Zogg","Gavin Smith","Jack Moes","Gina Cerra","Trey Samoline","Infiniti Lauzon-Marshall","Henning Burton","Tony Rex","Ben Shalom","Marv Sengbloh","Tara Newton","Melissa Spoth","Jack Shalvoy","Jamie Howze","Adam Kiss","Mike Marando","JD Modrak","Willie Moore","Jesse Karp") THEN "Kasa Staff"
    ELSE ${TABLE}.Housekeeper_Name
    END;;
  }

  dimension: building {
    hidden: yes
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.Created ;;
    convert_tz: no
  }

  dimension: created_by {
    hidden: yes
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
    view_label: "Metrics"
    type: count
    group_label: "BW Metrics"
    filters: {
      field: done_on_time_
      value: "On Time"
    }
  }

  measure: late {
    type: count
    view_label: "Metrics"
    group_label: "BW Metrics"
    filters: {
      field: done_on_time_
      value: "Late"
    }
  }

  measure: pct_on_time {
    type: number
    view_label: "Metrics"
    group_label: "BW Metrics"
    label: "% BW Tasks on Time"
    value_format: "0%"
    sql: ${done_on_time}/nullif(${count},0);;
  }

  dimension: estimate_time_to_complete {
    type: string
    hidden: yes
    sql: ${TABLE}.Estimate_Time_to_Complete ;;
  }

  dimension: name {
    label: "Task Name (Breezeway)"
    description: "This will pull the task name as entered on Breezeway"
    hidden: no
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: name_revised {
    label: "Task Name"
    description: "This will pull the associated task in-line with the hk cleaning pricing table"
    type: string
    sql:
    CASE WHEN lower(${TABLE}.Name) LIKE "%turnover clean (spanish)%" THEN "Turnover Clean (Spanish)"
    WHEN (lower(${TABLE}.Name) LIKE "%turnover clean %" OR lower(${TABLE}.Name) LIKE "turnover clean") THEN "Turnover Clean"
    WHEN lower(${TABLE}.Name) LIKE "%deep%clean%(spanish)%" THEN "Deep Clean (Spanish)"
    WHEN (lower(${TABLE}.Name) LIKE "deep clean" OR lower(${TABLE}.Name) LIKE "%deep clean checklist") THEN "Deep Clean"
    WHEN lower(${TABLE}.Name) LIKE "%intra-stay%" THEN "Intra-Stay Clean"
    WHEN lower(${TABLE}.Name) LIKE "%ad hoc clean%" THEN "Ad Hoc Clean (correction)"
    WHEN lower(${TABLE}.Name) LIKE "%la monarca common areas%" THEN "La Monarca Common Areas"
    WHEN lower(${TABLE}.Name) LIKE "%carpet/upholstery spot clean%" THEN "Carpet/Upholstery Spot Clean"
    WHEN lower(${TABLE}.Name) LIKE "%carpet/upholstery: full unit%" THEN "Carpet/Upholstery Full Room"
    WHEN lower(${TABLE}.Name) LIKE "%cleanliness review feedback%" THEN "Cleanliness Review Feedback"
    WHEN lower(${TABLE}.Name) LIKE "%hk touch up or vip prep%" THEN "HK Touch Up - VIP Prep"
    WHEN lower(${TABLE}.Name) LIKE "hk misc%" OR lower(${TABLE}.Name) LIKE "errand fee" THEN "HK Misc/Delayed Entry/False Arrival/Errand Fee"
    ELSE ${TABLE}.Name
    END;;
  }

  dimension: past_due_by_ {
    hidden: yes
    type: string
    sql: ${TABLE}.Past_Due_By_ ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  dimension: property_id {
    hidden: yes
    type: number
    sql: ${TABLE}.Property_ID ;;
  }

  dimension: property_internal_id {
    hidden: no
    type: string
    sql: CASE WHEN ${TABLE}.Property = 'La Monarca (Full Building)' THEN 'LMH-0'
    ELSE ${TABLE}.Property_Internal_ID
    END;;
  }

  dimension: property_marketing_id {
    hidden: yes
    type: string
    sql: ${TABLE}.Property_Marketing_ID ;;
  }

  dimension: rate_paid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.Rate_Paid ;;
  }

  dimension: rate_type {
    hidden: yes
    type: string
    sql: ${TABLE}.Rate_Type ;;
  }

  dimension: report_summary {
    hidden: yes
    type: string
    sql: ${TABLE}.Report_Summary ;;
  }

  dimension: requested_by {
    hidden: yes
    type: string
    sql: ${TABLE}.Requested_By ;;
  }

  dimension_group: started {
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
    sql: ${TABLE}.Started ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: tags {
    hidden: no
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

  dimension: completion_time_filter {
    label: "Completion Time (Minutes)"
    type: yesno
    hidden: no
    sql: ${completion_time_mins} > 30 AND ${completion_time_mins} < 240 ;;
  }

  measure: average_completion {
    view_label: "Metrics"
    group_label: "BW Metrics"
    label: "Average Completion Time (Hours)"
    type: average
    hidden: no
    value_format: "0.0"
    sql: ${completion_time_mins} / 60;;
    filters: [completion_time_filter: "yes"]
  }


  dimension: total_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.Total_Cost ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.Updated ;;
  }

  dimension: title {
    view_label: "Building and Geographic Information"
    label: "Building Title"
    type: string
    sql: CASE WHEN ${property} = 'La Monarca (Full Building)' THEN 'LaMonarcaH'
    ELSE ${complexes.title}
    END;;
  }

  dimension: propcode {
    hidden: no
    view_label: "Building and Geographic Information"
    label: "Property Code"
    type: string
    sql: CASE WHEN ${property} = 'La Monarca (Full Building)' THEN 'LMH'
    ELSE ${units.propcode}
    END;;
  }

  measure: count {
    view_label: "Metrics"
    group_label: "BW Metrics"
    label: "BW Task Count (Total)"
    description: "This will measure the total number of BW Tasks, including those with inaccurate completion times"
    hidden: no
    type: count
    drill_fields: [id, name]
  }

  measure: count_filter_count {
    view_label: "Metrics"
    group_label: "BW Metrics"
    label: "BW Task Count (Allocated)"
    hidden: no
    type: count
    filters: [completion_time_filter: "yes"]
  }

  measure: count_filter_percentage {
    view_label: "Metrics"
    group_label: "BW Metrics"
    label: "% of BW Task Count (Allocated)"
    hidden: no
    type: number
    sql: ${count_filter_count} / ${count} ;;
    value_format: "0.0%"
  }


}
