  view: ximble_master {
    derived_table: {
      sql: SELECT *
        FROM `bigquery-analytics-272822.ximble.ximble_master`;;

      datagroup_trigger: ximble_default_datagroup
    }

  dimension_group: date {
    type: time
    label: ""
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }


  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: e_mail {
    type: string
    sql: ${TABLE}.E_mail ;;
  }

  dimension: employee_number {
    type: string
    sql: ${TABLE}.Employee_Number ;;
  }

  dimension: end_time {
    hidden: yes
    type: string
    sql: ${TABLE}.End_Time ;;
  }

  dimension: first_name {
    type: string
    hidden: yes
    sql: ${TABLE}.First_Name ;;
  }

  dimension: name {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.Last_Name is null THEN ${TABLE}.First_Name
    ELSE CONCAT(${TABLE}.First_Name," ",${TABLE}.Last_Name)
    END;;
  }

  dimension: name_adjusted {
    type: string
    label: "Names"
    description: "These names have been adjusted to match what's shown on Kustomer"
    sql:
    CASE
    WHEN ${name} = "Angela Gazdziak" THEN "Angie Gazdziak"
    WHEN ${name} = "Infiniti Lauzon-Marshall" THEN "Infiniti"
    WHEN ${name} = "Jeffrey Haas" THEN "Jeff Haas"
    WHEN ${name} = "Jennifer Knight" THEN "Jen Knight"
    WHEN ${name} = "Sheila Marie Cruz" THEN "Sheila Cruz"
    WHEN ${name} = "Rommel Doroteo" THEN "Mel Doroteo"
    WHEN ${name} = "Katherine Chappell" THEN "Kate Chappell"
    ELSE ${name}
    END
    ;;
  }

  dimension: job {
    type: string
    sql: ${TABLE}.Job ;;
  }

  dimension: labor_cost {
    type: number
    sql: ${TABLE}.Labor_Cost ;;
  }

  dimension: last_name {
    type: string
    hidden: yes
    sql: ${TABLE}.Last_Name ;;
  }

  dimension: location {
    type: string
    hidden: yes
    sql: ${TABLE}.Location ;;
  }

  dimension: location_code {
    type: string
    hidden: yes
    sql: ${TABLE}.Location_Code ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.Notes ;;
  }

  dimension: shift_label {
    type: string
    sql: ${TABLE}.Shift_Label ;;
  }

  dimension: shift_label_filtered {
    type: yesno
    sql:
    ${TABLE}.Shift_Label IS NULL OR
    ((LOWER(${TABLE}.Shift_Label) NOT LIKE "%project time%")
    AND (LOWER(${TABLE}.Shift_Label) NOT LIKE '%training class%')
    AND (LOWER(${TABLE}.Shift_Label) NOT LIKE "%culture amp%"))
    ;;
  }

  dimension: start_time {
    hidden: yes
    type: string
    sql: ${TABLE}.Start_Time ;;
  }

  dimension: total_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.Total_Hours ;;
  }

  measure: hours {
    label: "Total Hours"
    type: sum_distinct
    sql_distinct_key: CONCAT(${date_date},${name_adjusted},${start_time},${end_time}) ;;
    sql: ${TABLE}.Total_Hours;;
    filters: [shift_label_filtered: "yes"]
    drill_fields: [date_date, shift_label, hours]
  }


}
