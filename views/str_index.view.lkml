view: str_index {
  sql_table_name: `bigquery-analytics-272822.market_data.str_index`
    ;;


  dimension_group: str_night {
    view_label: "Date Dimensions"
    group_label: "STR Night"
    label: ""
    type: time
    timeframes: [
      date,
      week,
      month,
      month_name,
      week_of_year,
      day_of_month,
      day_of_week,
      quarter,
      year
    ]
    sql: ${TABLE}.Month_Night ;;
  }



  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: ari_dim {
    type: number
    hidden: yes
    sql: ${TABLE}.ARI ;;
  }

  dimension: mpi_dim {
    type: number
    hidden: yes
    sql: ${TABLE}.MPI ;;
  }

  dimension: rpi_dim {
    type: number
    hidden: yes
    sql: ${TABLE}.RPI ;;
  }

  measure: ari {
    type: sum_distinct
    sql_distinct_key: ${ari_dim};;
    sql: ${ari_dim} ;;
  }

  measure: mpi {
    type: sum_distinct
    sql_distinct_key: ${mpi_dim} ;;
    sql: ${mpi_dim} ;;
  }

  measure: rpi {
    type: sum_distinct
    sql_distinct_key: ${rpi_dim} ;;
    sql: ${rpi_dim} ;;
  }


}
