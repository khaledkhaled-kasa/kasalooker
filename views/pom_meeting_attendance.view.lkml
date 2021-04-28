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

  measure: total_meetings_held {
    type: count_distinct
    sql: ${meeting_date} ;;
  }
}
