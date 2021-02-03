view: geo_location {
  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.Geos.Geo_Location`
       ;;
  persist_for: "48 hours"
  }

  # dimension: active_kasa_units__city_ {
  #   type: number
  #   sql: ${TABLE}.Active_Kasa_Units__City_ ;;
  # }

  # dimension: active_kasa_units__metro_ {
  #   type: number
  #   sql: ${TABLE}.Active_Kasa_Units__Metro_ ;;
  # }

  # dimension: amzn_region {
  #   type: string
  #   sql: ${TABLE}.AMZN_Region ;;
  # }

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

  # dimension: cola {
  #   type: string
  #   sql: ${TABLE}.COLA ;;
  # }

  # dimension: country {
  #   type: string
  #   map_layer_name: countries
  #   sql: ${TABLE}.Country ;;
  # }

  # dimension: email_address {
  #   type: string
  #   sql: ${TABLE}.Email_address ;;
  # }

  dimension: metro {
    view_label: "Building and Geographic Information"
    label: "Metro Area"
    type: string
    sql: ${TABLE}.Metro ;;
  }

  # dimension: package_recipient {
  #   type: string
  #   sql: ${TABLE}.Package_Recipient ;;
  # }

  # dimension: phone_number {
  #   type: string
  #   sql: ${TABLE}.Phone_number ;;
  # }

  # dimension: pom {
  #   type: string
  #   sql: ${TABLE}.POM ;;
  # }

  # dimension: pom_status {
  #   type: string
  #   sql: ${TABLE}.POM_Status ;;
  # }

  # dimension: recipient_address {
  #   type: string
  #   sql: ${TABLE}.Recipient_Address ;;
  # }

  dimension: region {
    view_label: "Building and Geographic Information"
    type: string
    sql: ${TABLE}.Region ;;
  }

  # dimension: shipping_address_1 {
  #   type: string
  #   sql: ${TABLE}.Shipping_Address_1 ;;
  # }

  dimension: state {
    view_label: "Building and Geographic Information"
    type: string
    sql: ${TABLE}.State ;;
  }

  # dimension: taxes {
  #   type: number
  #   sql: ${TABLE}.Taxes ;;
  # }

  # dimension: time_zone {
  #   type: string
  #   sql: ${TABLE}.TimeZone ;;
  # }

}
