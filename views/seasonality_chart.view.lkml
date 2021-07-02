view: seasonality_chart {
  derived_table: {
    sql: SELECT *
        FROM (
        SELECT Metro_Area,Seasonality_Type,
          REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') Month,
          REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
        FROM Gsheets.seasonality_chart t,
        UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
        )
        WHERE NOT LOWER(Month) IN ('metro_area', 'seasonality_type')
       ;;
  }


  dimension: metro_area {
    type: string
    sql: ${TABLE}.Metro_Area ;;
  }

  dimension: seasonality_type {
    hidden: yes
    type: string
    sql: ${TABLE}.Seasonality_Type ;;
  }

  dimension: month {
    hidden: yes
    type: string
    sql: ${TABLE}.Month ;;
  }

  dimension: month_number {
    hidden: yes
    type: number
    sql: CASE
    WHEN ${TABLE}.Month = "January" THEN 1
    WHEN ${TABLE}.Month = "February" THEN 2
    WHEN ${TABLE}.Month = "March" THEN 3
    WHEN ${TABLE}.Month = "April" THEN 4
    WHEN ${TABLE}.Month = "May" THEN 5
    WHEN ${TABLE}.Month = "June" THEN 6
    WHEN ${TABLE}.Month = "July" THEN 7
    WHEN ${TABLE}.Month = "August" THEN 8
    WHEN ${TABLE}.Month = "September" THEN 9
    WHEN ${TABLE}.Month = "October" THEN 10
    WHEN ${TABLE}.Month = "November" THEN 11
    WHEN ${TABLE}.Month = "December" THEN 12
    END;;
  }


  dimension: value {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.value AS BIGNUMERIC) ;;
  }

  measure: ADR {
    type: average_distinct
    value_format: "0.00%"
    sql_distinct_key: ${value} ;;
    sql: ${value} ;;
    filters: [seasonality_type: "ADR"]
  }

  measure: RevPAR {
    type: average_distinct
    sql_distinct_key: ${value} ;;
    value_format: "0.00%"
    sql: ${value} ;;
    filters: [seasonality_type: "RevPAR"]
  }

  measure: Occupancy {
    type: average_distinct
    value_format: "0.00%"
    sql_distinct_key: ${value} ;;
    sql: ${value} ;;
    filters: [seasonality_type: "Occ"]

  }

}
