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



  dimension_group: availability_startdate {
    label: "Unit Availability Start Date"
    type: time
    timeframes: [date, week, month, year]
    sql: TIMESTAMP(${TABLE}.availability.startdate);;
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

  dimension: breezeway_id {
    label: "Breezeway ID"
    type: string
    sql: ${TABLE}.externalrefs.breezewayid;;
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
    sql: ${TABLE}.externalrefs.nexiaid ;;
  }


  dimension: petsallowed {
    label: "Pets Allowed?"
    type: yesno
    sql: ${TABLE}.petsallowed ;;
  }


  dimension: airbnbid {
    label: "Airbnb ID"
    description: "This airbnbid may be dedicated for a single listing or a parent listing (group of units)"
    type: number
    value_format: "0"
    sql: ${TABLE}.externalrefs.airbnbid ;;
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
    sql: CASE  WHEN ${availability_enddate} IS NULL AND DATE(${availability_startdate_date}) < CURRENT_DATE THEN 'Active'
            WHEN CURRENT_DATE >= DATE(${availability_startdate_date}) AND  EXTRACT( YEAR FROM SAFE_CAST(${availability_enddate} as DATE)) = 2099 Then 'Active'
            WHEN CURRENT_DATE >= DATE(${availability_startdate_date}) AND CURRENT_DATE < SAFE_CAST(${availability_enddate} as DATE) AND EXTRACT( YEAR FROM SAFE_CAST(${availability_enddate}as DATE)) <> 2099 THEN 'Expiring'
            WHEN CURRENT_DATE >= SAFE_CAST(${availability_enddate} as DATE) THEN 'Deactivated'
            WHEN SAFE_CAST(${availability_startdate_date} AS DATE) > CURRENT_DATE THEN 'Onboarding'
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

  measure: active_unit_count {
    label: "Total Active Unique Units"
    type: count_distinct
    sql: CASE WHEN ((${internaltitle} LIKE "%-XX") OR (${internaltitle} LIKE "%-RES")) THEN NULL
          ELSE ${TABLE}._id
          END ;;
    filters: [unit_status: "Active, Expiring"]
  }



  measure: property_count {
    label: "Total Unique Properties"
    type: count_distinct
    sql: ${TABLE}.complex ;;
  }


}

## Test one
# view: units {
#   derived_table: {
#     sql:  SELECt *,KPO_table.Status as statuskpo,
#           CASE WHEN SAFE.PARSE_DATE('%m/%d/%Y',KPO_table.FirstAvailableDate) IS NULL THEN DATE(units.availability.startdate)
#           ELSE SAFE.PARSE_DATE('%m/%d/%Y',KPO_table.FirstAvailableDate) END as unit_availability_startdate,

#           CASE WHEN SAFE.PARSE_DATE('%m/%d/%Y',KPO_table.DeactivatedDate) is NULL
#             AND (DATE(units.availability.enddate) is  NULL OR (EXTRACT(YEAR from SAFE_CAST(availability.enddate as DATE)) = 2099))
#             THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL -18 MONTH)
#           WHEN SAFE.PARSE_DATE('%m/%d/%Y',KPO_table.DeactivatedDate) is NOT null THEN SAFE.PARSE_DATE('%m/%d/%Y',KPO_table.DeactivatedDate)
#           ELSE DATE(units.availability.enddate) END AS unit_availability_enddate
#           FROM
#         `bigquery-analytics-272822.mongo.units` units
#         LEFT JOIN  `bigquery-analytics-272822.Gsheets.kpo_overview_clean` KPO_table
#         ON units.internaltitle =KPO_table.UID WHERE units.internaltitle is NOT NULL AND units.internaltitle NOT LIKE "%TST-%"
#             ;;

#     }

#     dimension: _id {
#       hidden:  yes
#       primary_key: yes
#       type: string
#       sql: ${TABLE}._id ;;
#     }

#     dimension: UID {
#       hidden:  no # yes
#       type: string
#       sql: ${TABLE}.UID ;;
#     }

# # City, States and Region are getting pulled from Geo Location
#     dimension: address_city {
#       hidden: yes
#       label: "City"
#       sql: CASE WHEN ${TABLE}.address.city = "" THEN NULL
#           ELSE ${TABLE}.address.city
#           END;;
#     }

#     dimension: address_state {
#       hidden: yes
#       label: "State"
#       sql: CASE WHEN ${TABLE}.address.state = "" THEN NULL
#           ELSE ${TABLE}.address.state
#           END;;
#     }

#     dimension: region {
#       hidden: yes
#       label: "Region"
#       sql: CASE
#           WHEN ${TABLE}.address.state IN ("TX") THEN "Texas"
#           WHEN ${TABLE}.address.state IN ("WA","CA","UT","CO") THEN "West"
#           WHEN ${TABLE}.address.state IN ("FL","DC","PA","CT","NJ","SC","NC","GA","VA","TN","NY") THEN "East"
#           WHEN ${TABLE}.address.state IN ("IL","IA","WI","MO","MN","AZ") THEN "Central"
#           ELSE "Other"
#           END ;;
#     }


#     dimension_group: mongo_availability_startdate {
#       label: "Unit Availability Start Date (mongo)"
#       type: time
#       timeframes: [date, week, month, year]
#       sql: TIMESTAMP(${TABLE}.availability.startdate);;
#     }
#     dimension: mongo_availability_enddate {
#       type:  date
#       hidden: no
#       label: "Unit Table  Availability End Date (mongo)"
#       sql:
#           CASE WHEN ${TABLE}.availability.enddate = 'Invalid date' THEN NULL
#           ELSE CAST(${TABLE}.availability.enddate as TIMESTAMP)
#           END;;
#       convert_tz: no
#     }

#     dimension_group: KPO_firstAvailableDate {
#       type: time
#       hidden: no
#       datatype: date
#       timeframes: [
#         date,
#         week,
#         week_of_year,
#         month,
#         month_name,
#         quarter,
#         year
#       ]
#       sql: PARSE_DATE('%m/%d/%Y',${TABLE}.FirstAvailableDate) ;;
#       convert_tz: no
#     }
#     dimension_group: KPO_deactivatedDate {
#       type: time
#       datatype: date
#       timeframes: [
#         date,
#         week,
#         week_of_year,
#         month,
#         month_name,
#         quarter,
#         year
#       ]
#       sql: PARSE_DATE('%m/%d/%Y',${TABLE}.DeactivatedDate) ;;
#       convert_tz: no
#       hidden: no
#     }
#     dimension_group: KPO_revised_deactivatedDate {
#       type: time
#       datatype: date
#       timeframes: [
#         date,
#         week,
#         week_of_year,
#         month,
#         month_name,
#         quarter,
#         year
#       ]
#       #sql: PARSE_DATE('%m/%d/%Y',${TABLE}.DeactivatedDate) ;;
#       sql: CASE WHEN safe.parse_date('%m/%d/%Y',${TABLE}.DeactivatedDate) IS NULL
#           THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL -18 MONTH)
#           ELSE safe.parse_date('%m/%d/%Y',${TABLE}.DeactivatedDate)
#           END ;;
#       convert_tz: no
#       hidden: no
#     }

#     dimension: availability_enddate {
#       type:  date
#       label: "Unit Availability End Date"
#       sql:${TABLE}.unit_availability_enddate;;
#       convert_tz: no
#     }

#     dimension: availability_startdate
#     {
#       label: "Unit Availability Start Date"
#       type:  date
#       sql: ${TABLE}.unit_availability_startdate ;;
#       convert_tz: no
#     }

#     dimension: status_matched{
#       description: "Return No if unit's status does'not match with status in KPO  "
#       type: string
#       sql:  CASE WHEN ${TABLE}.statuskpo IS NULL Then NULL
#       WHEN ${unit_status} =${TABLE}.statuskpo Then "✅ "
#       ELSE "❌ "
#       END;;
#       hidden: no
#     }

#     dimension: KPO_status {
#       type: string
#       sql: ${TABLE}.statuskpo ;;
#       hidden: no
#     }

#     dimension: unit_status {
#       description: "Status of Unit (Active/Deactivated/Expiring/Onboarding)"
#       type: string
#       sql: CASE

#             WHEN CURRENT_DATE < DATE(${TABLE}.unit_availability_enddate) AND (DATE_DIFF(DATE(${TABLE}.unit_availability_enddate), CURRENT_DATE ,DAY) BETWEEN 1 AND 30 ) THEN 'Expiring'
#             WHEN CURRENT_DATE >= SAFE_CAST(${availability_enddate} as DATE) THEN 'Deactivated'
#             WHEN SAFE_CAST(${availability_startdate} AS DATE) > CURRENT_DATE THEN 'Onboarding'
#       ELSE 'Active'
#       END ;;
#     }
#     dimension: availability_enddate_string {
#       hidden: yes
#       type:  string
#       label: "Unit Availability End Date"
#       sql: ${TABLE}.availability.enddate;;
#     }

#     dimension: bathrooms {
#       type: number
#       sql: CASE WHEN ${TABLE}.bathrooms__fl IS NULL THEN ${TABLE}.bathrooms
#           ELSE ${TABLE}.bathrooms__fl
#           END;;
#     }

#     dimension: bedrooms {
#       type: number
#       sql: ${TABLE}.roomtype.bedroomcount ;;
#     }

#     dimension: complex {
#       type: string
#       sql: ${TABLE}.complex ;;
#     }

#     dimension: buildinginternaltitle {
#       label: "Building Internal Title"
#       type: string
#       hidden: no
#       sql: ${TABLE}.buildinginternaltitle ;;
#     }

#     dimension: breezeway_id {
#       label: "Breezeway ID"
#       type: string
#       sql: ${TABLE}.externalrefs.breezewayid;;
#     }

#     dimension: door {
#       hidden: no
#       sql: ${TABLE}.door ;;
#     }

#     dimension: floor {
#       type: string
#       sql: ${TABLE}.floor ;;
#     }

#     dimension: floor__it {
#       type: number
#       sql: ${TABLE}.floor__it ;;
#     }

#     dimension: hashighriskneighbor {
#       label: "Has High Risk Neighbor?"
#       type: yesno
#       sql: ${TABLE}.hashighriskneighbor ;;
#     }

#     dimension: hassmartlock {
#       label: "Has Smart Lock?"
#       type: yesno
#       sql: ${TABLE}.hassmartlock ;;
#     }

#     dimension: internaltitle {
#       # view_label: "Units"
#       label: "Unit #"
#       type: string
#       sql: ${TABLE}.internaltitle ;;
#     }

#     dimension: propcode {
#       hidden: no
#       view_label: "Building and Geographic Information"
#       label: "Property Code"
#       type: string
#       sql: substr(${TABLE}.internaltitle, 1, 3);;
#     }

#     dimension: lock_id {
#       type: string
#       sql: ${TABLE}.lock_id ;;
#     }

#     dimension: nexiaid {
#       type: string
#       sql: ${TABLE}.externalrefs.nexiaid ;;
#     }

#     dimension: petsallowed {
#       label: "Pets Allowed?"
#       type: yesno
#       sql: ${TABLE}.petsallowed ;;
#     }

#     dimension: airbnbid {
#       label: "Airbnb ID"
#       description: "This airbnbid may be dedicated for a single listing or a parent listing (group of units)"
#       type: number
#       value_format: "0"
#       sql: ${TABLE}.externalrefs.airbnbid ;;
#     }

#     dimension: propertyexternaltitle {
#       type: string
#       hidden: no
#       sql: ${TABLE}.propertyexternaltitle ;;
#     }

#     dimension: propertyinternaltitle {
#       type: string
#       hidden: yes
#       sql: ${TABLE}.propertyinternaltitle ;;
#     }

#     # dimension: routine_visit_status {
#     #   type: string
#     #   sql: CASE WHEN ${unit_status} = 'Deactivated' THEN 'N/A - Deactivated'
#     #             WHEN ;;
#     # }

#     dimension: title {
#       type: string
#       hidden: yes
#       sql: ${TABLE}.title ;;
#     }

#     measure: unit_count {
#       label: "Total Unique Units"
#       type: count_distinct
#       sql: CASE WHEN ((${TABLE}.internaltitle LIKE "%-XX") OR (${TABLE}.internaltitle LIKE "%-RES") OR (${TABLE}.internaltitle LIKE "%-S")) THEN NULL
#           ELSE ${TABLE}._id
#           END;;
#     }

#     measure: property_count {
#       label: "Total Unique Properties"
#       type: count_distinct
#       sql: ${TABLE}.complex ;;
#     }

#   }
