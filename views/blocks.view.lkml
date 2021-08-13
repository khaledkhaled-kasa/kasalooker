view: blocks {
  sql_table_name: `bigquery-analytics-272822.mongo.blocks`
    ;;


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: createdat {
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
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension: enddatelocal {
    type: date
    sql: DATE(${TABLE}.enddatelocal) ;;
    convert_tz: no
  }


  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
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

  dimension: startdatelocal {
    type: date
    sql: DATE(${TABLE}.startdatelocal) ;;
    convert_tz: no
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }


  dimension: unit {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }


}
