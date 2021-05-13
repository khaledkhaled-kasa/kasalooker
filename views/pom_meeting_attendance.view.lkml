view: pom_meeting_attendance {
  sql_table_name: `bigquery-analytics-272822.Gsheets.POM_Meeting_Attendance`
    ;;


  dimension: primary_key {
    type: string
    hidden: yes
    sql: ${pom} || CAST(${meeting_date} AS STRING) ;;
  }

  dimension: attendance {
    type: string
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
    sql: ${TABLE}.MeetingDate ;;
  }

  dimension: pom {
    type: string
    sql: ${TABLE}.POM ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_meetings_attended {
    type: count_distinct
    hidden: yes
    sql: ${primary_key} ;;
    filters: [attendance: "Y"]
    }

  measure: total_meetings_not_attended {
    type: count_distinct
    hidden: yes
    sql: ${primary_key} ;;
    filters: [attendance: "-Y"]
  }

  measure: meeting_attendance_rate {
    type: number
    sql: ${total_meetings_attended}/NULLIF((${total_meetings_attended} + ${total_meetings_not_attended}),0) ;;
    value_format_name: percent_2
  }

  measure: meeting_attendance_pom_score {
    label: "Meeting Attendance POM Score"
    type: number
    sql:  CASE WHEN ${meeting_attendance_rate} >= ${pom_information.MeetingAttendanceStandard} THEN 1
          ELSE ${meeting_attendance_rate}/NULLIF(${pom_information.MeetingAttendanceStandard},0)
          END;;
  }

  measure: meeting_attendance_pom_score_weighted {
    type: number
    label: "Meeting Attendance POM Score (Weighted)"
    sql: ${meeting_attendance_pom_score} * ${pom_information.Meeting_Attendance_Weighting} ;;
  }

  measure: total_meetings_held {
    type: count_distinct
    sql: ${meeting_date} ;;
  }
}
