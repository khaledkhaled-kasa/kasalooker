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

  dimension: marketing_property_dash_transition {
    type: string
    hidden: yes
    sql: "Click to continue ⏭️️ " ;;
    link: {
      label: "Move to next Dashboard"
      url: "https://kasaliving.looker.com/dashboards-next/439?Building%20Filter={{ _filters['complexes.title'] | url_encode }}&City%20Filter={{ _filters['geo_location.city'] | url_encode }}"
    }
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

  dimension: city_state {
    type: string
    view_label: "Building and Geographic Information"
    description: "Appends together City and State in 1 column"
    label: "City, State"
    sql: ${city} || ', ' || ${state} ;;
  }

  dimension: city_code {
    hidden: yes
    type: string
    sql: ${TABLE}.Package_Recipient ;;
  }

  dimension: city_full_uid {
    label: "UID (Full)"
    view_label: "Units"
    type: string
    sql: CONCAT(${city_code},"-",${units.internaltitle}) ;;
  }



}
