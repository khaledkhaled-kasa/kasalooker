view: units {
  sql_table_name: `bigquery-analytics-272822.mongo.units`
    ;;

  dimension: _id {
    hidden:  yes
    primary_key: yes
    type: string
    sql: ${TABLE}._id ;;
  }


# City, States and Region are getting pulled from Geo Location
  dimension: address_city {
    hidden: yes
    label: "City"
    sql: CASE WHEN ${TABLE}.address.city = "" THEN NULL
    ELSE ${TABLE}.address.city
    END;;
  }

  dimension: address_state {
    hidden: yes
    label: "State"
    sql: CASE WHEN ${TABLE}.address.state = "" THEN NULL
    ELSE ${TABLE}.address.state
    END;;
  }

  dimension: region {
    hidden: yes
    label: "Region"
    sql: CASE
          WHEN ${TABLE}.address.state IN ("TX") THEN "Texas"
          WHEN ${TABLE}.address.state IN ("WA","CA","UT","CO") THEN "West"
          WHEN ${TABLE}.address.state IN ("FL","DC","PA","CT","NJ","SC","NC","GA","VA","TN") THEN "East"
          WHEN ${TABLE}.address.state IN ("IL","IA","WI","MO","MN","AZ") THEN "Central"
          ELSE "Other"
          END ;;
  }



  dimension: availability_startdate {
    label: "Unit Availability Start Date"
    type: date
    sql: TIMESTAMP(${TABLE}.availability.startdate);;
  }



  dimension: availability_startdate_45day_mark {
    hidden: no
    type: date
    sql: TIMESTAMP_ADD(TIMESTAMP(${TABLE}.availability.startdate), INTERVAL 45 DAY);;
  }

  dimension: availability_enddate {
    label: "Unit Availability End Date"
    type: date
    sql: TIMESTAMP(${TABLE}.availability.enddate);;
  }


  dimension: bathrooms {
    type: number
    sql: CASE WHEN ${TABLE}.bathrooms__fl IS NULL THEN ${TABLE}.bathrooms
          ELSE ${TABLE}.bathrooms__fl
          END;;
  }

  dimension: bedrooms {
    type: number
    sql: ${TABLE}.roomtype.bedroomcount ;;
  }

  dimension: complex {
    type: string
    sql: ${TABLE}.complex ;;
  }


  dimension: buildinginternaltitle {
    label: "Building Internal Title"
    type: string
    hidden: no
    sql: ${TABLE}.buildinginternaltitle ;;
  }


  dimension: door {
    hidden: no
    sql: ${TABLE}.door ;;
  }



  dimension: floor {
    type: string
    sql: ${TABLE}.floor ;;
  }

  dimension: floor__it {
    type: number
    sql: ${TABLE}.floor__it ;;
  }

  dimension: hashighriskneighbor {
    label: "Has High Risk Neighbor?"
    type: yesno
    sql: ${TABLE}.hashighriskneighbor ;;
  }

  dimension: hassmartlock {
    label: "Has Smart Lock?"
    type: yesno
    sql: ${TABLE}.hassmartlock ;;
  }


  dimension: internaltitle {
    view_label: "Units"
    label: "Unit #"
    type: string
    sql: ${TABLE}.internaltitle ;;
  }


  dimension: propcode {
    hidden: no
    view_label: "Building and Geographic Information"
    label: "Property Code"
    type: string
    sql: substr(${TABLE}.internaltitle, 1, 3);;
  }


  dimension: lock_id {
    type: string
    sql: ${TABLE}.lock_id ;;
  }

  dimension: nexiaid {
    type: string
    sql: ${TABLE}.nexiaid ;;
  }


  dimension: petsallowed {
    label: "Pets Allowed?"
    type: yesno
    sql: ${TABLE}.petsallowed ;;
  }


  dimension: propertyexternaltitle {
    type: string
    hidden: yes
    sql: ${TABLE}.propertyexternaltitle ;;
  }

  dimension: propertyinternaltitle {
    type: string
    hidden: yes
    sql: ${TABLE}.propertyinternaltitle ;;
  }


  dimension: title {
    type: string
    hidden: yes
    sql: ${TABLE}.title ;;
  }


  measure: unit_count {
    label: "Total Unique Units"
    type: count_distinct
    sql: ${TABLE}._id ;;
  }

  measure: property_count {
    label: "Total Unique Properties"
    type: count_distinct
    sql: ${TABLE}.complex ;;
  }


}
