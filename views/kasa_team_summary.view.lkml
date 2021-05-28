view: kasa_team_summary {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.kasa_team_summary`
    where Email is not null
      ;;
  }


  dimension: first_name {
    type: string
    hidden: yes
    sql: ${TABLE}.First_Name ;;
  }

  dimension: last_name {
    type: string
    hidden: yes
    sql: ${TABLE}.Last_Name ;;
  }

  dimension: kasa_employee {
    type: string
    sql: CONCAT(${TABLE}.First_Name," ",${TABLE}.Last_Name) ;;
  }

  dimension: kasaversary {
    type: date
    datatype: date
    sql: ${TABLE}.Kasa_versary ;;
  }

  dimension: latest_kasaversary {
    type: date
    datatype: date
    sql:   CASE
          WHEN PARSE_DATE('%Y-%m-%d',CONCAT(CAST(EXTRACT(YEAR FROM DATE (current_date())) AS STRING),"-",CAST(EXTRACT(MONTH FROM DATE (${TABLE}.Kasa_versary)) AS STRING),"-",CAST(EXTRACT(DAY FROM DATE (${TABLE}.Kasa_versary)) AS STRING))) > current_date() THEN DATE_SUB(PARSE_DATE('%Y-%m-%d',CONCAT(CAST(EXTRACT(YEAR FROM DATE (current_date())) AS STRING),"-",CAST(EXTRACT(MONTH FROM DATE (${TABLE}.Kasa_versary)) AS STRING),"-",CAST(EXTRACT(DAY FROM DATE (${TABLE}.Kasa_versary)) AS STRING))),INTERVAL 1 YEAR)
          ELSE PARSE_DATE('%Y-%m-%d',CONCAT(CAST(EXTRACT(YEAR FROM DATE (current_date())) AS STRING),"-",CAST(EXTRACT(MONTH FROM DATE (${TABLE}.Kasa_versary)) AS STRING),"-",CAST(EXTRACT(DAY FROM DATE (${TABLE}.Kasa_versary)) AS STRING)))
          END ;;
  }

  dimension: previous_kasaversary {
    type: date
    datatype: date
    sql:  CASE
          WHEN DATE_SUB(${latest_kasaversary}, INTERVAL 1 YEAR) < ${kasaversary} THEN ${kasaversary}
          ELSE DATE_SUB(${latest_kasaversary}, INTERVAL 1 YEAR)
          END;;
  }


  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: cell__ {
    label: "Cell #"
    type: string
    sql: ${TABLE}.Cell__ ;;
  }


}
