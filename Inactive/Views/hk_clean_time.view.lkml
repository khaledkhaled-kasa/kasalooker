view: hk_clean_time {
  derived_table: {
    sql: Select timestamp_diff(cleaning.date_cleaned, cleaning.createdat, MINUTE) as clean_time, HK,
         cleaning.confCode
          from ${hk_cleanings_with_confcode.SQL_TABLE_NAME} as cleaning
          where date(cleaning.date_cleaned) = date(cleaning.createdat) and
          time(cleaning.date_cleaned) >= time(cleaning.createdat) and
          HK is not null ;;
  }

  dimension: clean_time {
    type: number
    sql: ${TABLE}.clean_time ;;
  }

  dimension: HK {
    type: string
    sql: ${TABLE}.HK ;;
  }

  dimension: conf_code {
    type: string
    sql: ${TABLE}.confCode ;;
  }

  measure: avg_clean_time {
    description: "Avg Time spent Cleaning (hrs)"
    type: average
    sql: ${clean_time}/60 ;;
    value_format: "#.0"
  }

  measure: count {
    type: count
  }

 }
