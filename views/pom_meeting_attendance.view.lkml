view: pom_meeting_attendance {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.POM_Meeting_Attendance` ;;


  datagroup_trigger: meeting_attendance_datagroup
  publish_as_db_view: yes
}

  dimension: primary_key {
    type: string
    hidden: yes
    sql: ${pom} || CAST(${meeting_date} AS STRING) ;;
  }

  dimension: attendance {
    type: number
    sql: ${TABLE}.Attendance ;;
  }

  dimension_group: meeting {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: pom {
    label: "POM"
    type: string
    sql: ${TABLE}.POM ;;
  }


  measure: total_meetings_attended {
    type: count_distinct
    hidden: yes
    sql: ${primary_key} ;;
    filters: [attendance: "1"]
    }

  measure: total_meetings_not_attended {
    type: count_distinct
    hidden: yes
    sql: ${primary_key} ;;
    filters: [attendance: "0"]
  }

  measure: meeting_attendance_rate {
    type: number
    sql: ${total_meetings_attended}/NULLIF((${total_meetings_attended} + ${total_meetings_not_attended}),0) ;;
    value_format: "0%"
  }

  measure: meeting_attendance_pom_score {
    label: "Meeting Attendance POM Score"
    view_label: "POM Scorecard"
    type: number
    sql:  CASE WHEN ${meeting_attendance_rate} >= 1 THEN 1
          ELSE ${meeting_attendance_rate}/NULLIF(1,0)
          END;;
  }

  measure: meeting_attendance_pom_score_weighted {
    type: number
    label: "Meeting Attendance POM Score (Weighted)"
    view_label: "POM Scorecard"
    sql: ${meeting_attendance_pom_score} * ${pom_information.Meeting_Attendance_Weighting} ;;
    value_format: "0.00"
  }

  measure: total_meetings_held {
    type: count_distinct
    sql: ${meeting_date} ;;
    filters: [attendance: "0,1"]
  }
}
