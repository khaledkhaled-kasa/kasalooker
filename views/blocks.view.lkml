view: blocks {
  sql_table_name: `bigquery-analytics-272822.mongo.blocks`
    ;;


  dimension: category {
    label: "Category"
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: createdat {
    label: "Created"
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
    sql: ${TABLE}.createdat ;;
  }

  dimension: createdby {
    label: "Created By"
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension: enddatelocal {
    label: "End Date"
    type: date
    sql: DATE(${TABLE}.enddatelocal) ;;
    convert_tz: no
  }

  dimension: startdatelocal {
    label: "Start Date"
    type: date
    sql: DATE(${TABLE}.startdatelocal) ;;
    convert_tz: no
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: property {
    hidden: yes
    type: string
    sql: ${TABLE}.property ;;
  }

  dimension: reservation {
    hidden: yes
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: unit {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }


}
