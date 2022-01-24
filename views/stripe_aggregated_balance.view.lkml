view: stripe_aggregated_balance {
  derived_table: {
    sql:

    SELECT TIMESTAMP(CONCAT(FORMAT_TIMESTAMP("%Y-%m", DATETIME(created)),'-01')) as month_date,
    round(sum(gross),0) gross, round(sum(fee),0) fee, round(sum(net),0) net

    FROM `bigquery-analytics-272822.Gsheets.strip_itemized_balance`
    WHERE reporting_category IN ("charge","refund")
    GROUP BY 1
    ;;
  }

  dimension_group: created {
    type: time
    hidden: yes
    timeframes: [
      time,
      week,
      month
    ]
    sql: ${TABLE}.month_date ;;
    convert_tz: no
  }

  dimension: gross {
    type: number
    hidden: yes
    sql: ${TABLE}.gross ;;
  }

  dimension: fee {
    type: number
    hidden: yes
    sql: ${TABLE}.fee ;;
  }

  dimension: net {
    type: number
    hidden: yes
    sql: ${TABLE}.net ;;
  }

  measure: gross_sum {
    label: "Charged Volume"
    type: sum_distinct
    view_label: "Disputes Tracker"
    sql_distinct_key: CONCAT(${created_month},${gross}) ;;
    value_format: "$#,##0"
    hidden: no
    sql: ${TABLE}.gross ;;
  }

  measure: fee_sum {
    type: sum_distinct
    sql_distinct_key: CONCAT(${created_month},${fee}) ;;
    value_format: "$#,##0"
    hidden: yes
    sql: ${TABLE}.fee ;;
  }

  measure: net_sum {
    type: sum_distinct
    sql_distinct_key: CONCAT(${created_month},${net}) ;;
    value_format: "$#,##0"
    hidden: yes
    sql: ${TABLE}.net ;;
  }

}
