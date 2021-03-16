view: survey {
  sql_table_name: `bigquery-analytics-272822.Gsheets.survey`
    ;;

  dimension: email_address {
    type: string
    sql: ${TABLE}.Email_Address ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.Timestamp ;;
    convert_tz: no
  }

  dimension: unit_number___use_number_only__246_ {
    type: string
    sql: ${TABLE}.Unit_number___Use_number_only__246_ ;;
  }

  dimension: what_building_are_you_at_ {
    type: string
    sql: ${TABLE}.What_building_are_you_at_ ;;
  }

  dimension: what_is_your_name_ {
    type: string
    sql: ${TABLE}.What_is_your_name_ ;;
  }

  dimension: which_cleaning_task_id_are_you_inspecting___for_e_g__4268030_ {
    type: number
    value_format_name: id
    sql: ${TABLE}.Which_cleaning_task_ID_are_you_inspecting___for_e_g__4268030_ ;;
  }

  dimension: unit_number {
    type: string
    sql: CONCAT(${what_building_are_you_at_},'-',${unit_number___use_number_only__246_}) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
