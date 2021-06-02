view: units_test {
  derived_table: {
    sql:  SELECT *  FROM
          `bigquery-analytics-272822.mongo.units`
          LEFT JOIN  `bigquery-analytics-272822.Gsheets.kpo_overview_clean` KPO_table
          ON internaltitle =KPO_table.UID
       ;;
  }

  dimension: _id {
    hidden:  yes
    primary_key: yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: UID {
    hidden:  no # yes
    type: string
    sql: ${TABLE}.UID ;;
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
          WHEN ${TABLE}.address.state IN ("FL","DC","PA","CT","NJ","SC","NC","GA","VA","TN","NY") THEN "East"
          WHEN ${TABLE}.address.state IN ("IL","IA","WI","MO","MN","AZ") THEN "Central"
          ELSE "Other"
          END ;;
  }

  dimension: unit_availability_startdate
  {
    label: "Unit Availability Start Date"
    type: date
    sql:CASE WHEN TIMESTAMP(${KPO_firstAvailableDate_date}) IS NULL THEN TIMESTAMP(${TABLE}.availability.startdate)
    ELSE TIMESTAMP(${KPO_firstAvailableDate_date}) END ;;
    convert_tz: no
  }
  dimension: unit_availability_enddate {
    type:  date
    label: "Unit Availability End Date"
    sql:
    CASE WHEN TIMESTAMP(${KPO_revised_deactivatedDate_date}) IS NULL THEN TIMESTAMP(${TABLE}.availability.enddate)
    ELSE TIMESTAMP(${KPO_revised_deactivatedDate_date})END;;
    convert_tz: no
  }

  dimension: unitTable_availability_startdate
  {
    label: "Unit Table Availability Start Date"
    hidden: yes
    type: date
    sql: TIMESTAMP(${TABLE}.availability.startdate);;
    convert_tz: no
  }
  dimension: unitTable_availability_enddate {
    type:  date
    hidden: yes
    label: "Unit Table  Availability End Date"
    sql:
    CASE WHEN ${TABLE}.availability.enddate = 'Invalid date' THEN NULL
    ELSE CAST(${TABLE}.availability.enddate as TIMESTAMP)
    END;;
    convert_tz: no
  }

  dimension_group: KPO_firstAvailableDate {
    type: time
    hidden: yes
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.FirstAvailableDate) ;;
    convert_tz: no
  }

  dimension_group: KPO_revised_deactivatedDate {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    #sql: PARSE_DATE('%m/%d/%Y',${TABLE}.DeactivatedDate) ;;
    sql: CASE WHEN safe.parse_date('%m/%d/%Y',${TABLE}.DeactivatedDate) IS NULL
    THEN DATE_SUB(DATE(DATETIME(CURRENT_TIMESTAMP(),'America/Los_Angeles')), INTERVAL -18 MONTH)
    ELSE safe.parse_date('%m/%d/%Y',deactivateddate)
    END ;;
    convert_tz: no
    hidden: yes
  }

  dimension_group: KPO_deactivatedDate {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    sql: PARSE_DATE('%m/%d/%Y',${TABLE}.DeactivatedDate) ;;
    convert_tz: no
    hidden: yes
  }

  dimension: start_date_matched{
    description: "start date KPO match Unit table"
    type: string
    sql: CASE WHEN TIMESTAMP(${KPO_firstAvailableDate_date}) = TIMESTAMP(${unitTable_availability_startdate}) THEN 'Yes' ELSE 'No'
      END ;;
    hidden: yes
  }

  dimension: KPO_status {
    type: string
    sql: ${TABLE}.Status ;;
    hidden: yes
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
    sql: CASE  WHEN ${unit_availability_enddate} IS NULL AND DATE(${unit_availability_startdate}) < CURRENT_DATE THEN 'Active'
            WHEN CURRENT_DATE >= DATE(${unit_availability_startdate}) AND  EXTRACT( YEAR FROM SAFE_CAST(${unit_availability_enddate} as DATE)) = 2099 Then 'Active'
            WHEN CURRENT_DATE >= DATE(${unit_availability_startdate}) AND CURRENT_DATE < SAFE_CAST(${unit_availability_enddate} as DATE) AND EXTRACT( YEAR FROM SAFE_CAST(${unit_availability_enddate}as DATE)) <> 2099 THEN 'Expiring'
            WHEN CURRENT_DATE >= SAFE_CAST(${unit_availability_startdate} as DATE) THEN 'Deactivated'
            WHEN SAFE_CAST(${unit_availability_startdate} AS DATE) > CURRENT_DATE THEN 'Onboarding'
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

  measure: night_available {
    label: "Total available nights for specific unit"
    type: number
    sql: DATE_DIFF(${unit_availability_enddate},${unit_availability_startdate}, DAY) ;;
  }


}
