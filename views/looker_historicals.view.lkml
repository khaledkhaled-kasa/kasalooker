# This table is pulled based on an static data upload to retrieve historical looker data such as query counts, reports scheduled and user minutes
view: looker_historicals {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.looker_historicals`
      ;;

    # persist_for: "1 hour"
    datagroup_trigger: looker_historicals
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.User,${TABLE}.Date) ;;
  }

  dimension: user {
    type: string
    sql: ${TABLE}.User ;;
  }

  dimension_group: date {
    type: time
    datatype: date
    label: ""
    timeframes: [
      date,
      day_of_week,
      week,
      month,
      quarter,
      year,
    ]
    sql: ${TABLE}.Date ;;
    convert_tz: no
  }


  dimension: minutes {
    type: number
    hidden: yes
    sql: ${TABLE}.Minutes ;;
  }

  dimension: queries {
    type: number
    hidden: yes
    sql: ${TABLE}.Queries ;;
  }

  dimension: reports {
    type: number
    hidden: yes
    sql: ${TABLE}.Reports ;;
  }

  measure: usage_minutes {
    label: "Usage (Minutes)"
    type: sum
    hidden: no
    sql: ${TABLE}.Minutes ;;
  }

  measure: queries_count {
    label: "Queries"
    type: sum
    hidden: no
    sql: ${TABLE}.Queries ;;
  }

  measure: scheduled_jobs {
    type: sum
    hidden: no
    sql: ${TABLE}.Reports ;;
  }

}
