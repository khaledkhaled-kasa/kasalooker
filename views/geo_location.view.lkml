view: geo_location {
  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.Geos.Geo_Location`
       ;;
  persist_for: "48 hours"
  }


  dimension: city {
    type: string
    view_label: "Building and Geographic Information"
    sql: CASE WHEN ${TABLE}.City = "King of Prussia" THEN "King Of Prussia"
    WHEN ${TABLE}.City = "Arlington, TX" THEN "Arlington"
    WHEN ${TABLE}.City = "Arlington, VA" THEN "Arlington"
    WHEN ${TABLE}.City = "Washington D.C." THEN "Washington D.C"
    WHEN ${TABLE}.City = "Phoenix" THEN "Phoenix "
    ELSE ${TABLE}.City
    END;;
  }


  dimension: metro {
    view_label: "Building and Geographic Information"
    label: "Metro Area"
    type: string
    sql: ${TABLE}.Metro ;;
  }


  dimension: region {
    view_label: "Building and Geographic Information"
    type: string
    sql: ${TABLE}.Region ;;
  }


  dimension: state {
    view_label: "Building and Geographic Information"
    type: string
    sql: ${TABLE}.State ;;
  }



}
