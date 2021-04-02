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
    type:  date
    label: "Unit Availability End Date"
    sql:
    CASE WHEN ${TABLE}.availability.enddate = 'Invalid date' THEN NULL
    ELSE CAST(${TABLE}.availability.enddate as TIMESTAMP)
    END;;
  }

  dimension: availability_enddate_string {
    hidden: yes
    type:  string
    label: "Unit Availability End Date"
    sql: ${TABLE}.availability.enddate;;
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
    # view_label: "Units"
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
    hidden: no
    sql: ${TABLE}.propertyexternaltitle ;;
  }

  dimension: propertyinternaltitle {
    type: string
    hidden: yes
    sql: ${TABLE}.propertyinternaltitle ;;
  }

  dimension: unit_status {
    description: "Status of Unit (Active/Deactivated/Expiring/Onboarding)"
    type: string
    sql: CASE  WHEN ${availability_enddate} IS NULL AND DATE(${availability_startdate}) < CURRENT_DATE THEN 'Active'
            WHEN CURRENT_DATE >= DATE(${availability_startdate}) AND  EXTRACT( YEAR FROM SAFE_CAST(${availability_enddate} as DATE)) = 2099 Then 'Active'
            WHEN CURRENT_DATE >= DATE(${availability_startdate}) AND CURRENT_DATE < SAFE_CAST(${availability_enddate} as DATE) AND EXTRACT( YEAR FROM SAFE_CAST(${availability_enddate}as DATE)) <> 2099 THEN 'Expiring'
            WHEN CURRENT_DATE >= SAFE_CAST(${availability_enddate} as DATE) THEN 'Deactivated'
            WHEN SAFE_CAST(${availability_startdate} AS DATE) > CURRENT_DATE THEN 'Onboarding'
      ELSE NULL
      END ;;
  }

  # dimension: routine_visit_status {
  #   type: string
  #   sql: CASE WHEN ${unit_status} = 'Deactivated' THEN 'N/A - Deactivated'
  #             WHEN ;;
  # }


  dimension: title {
    type: string
    hidden: yes
    sql: ${TABLE}.title ;;
  }


  measure: unit_count {
    label: "Total Unique Units"
    type: count_distinct
    sql: CASE WHEN ((${internaltitle} LIKE "%-XX") OR (${internaltitle} LIKE "%-RES")) THEN NULL
          ELSE ${TABLE}._id
          END;;
  }



  measure: property_count {
    label: "Total Unique Properties"
    type: count_distinct
    sql: ${TABLE}.complex ;;
  }


}
