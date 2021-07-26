view: complexes {
  sql_table_name: `bigquery-analytics-272822.mongo.complexes`
    ;;

  dimension: _id {
    hidden:  yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: contacts {
    hidden: yes
    sql: ${TABLE}.contacts ;;
  }

  dimension: externaltitle {
    hidden: yes
    sql: ${TABLE}.externaltitle ;;
  }

  dimension: flags {
    hidden: yes
    sql: ${TABLE}.flags ;;
  }

  dimension: internaltitle {
    hidden:  yes
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: ishighrisk {
    hidden:  yes
    type: yesno
    sql: ${TABLE}.ishighrisk ;;
  }

  dimension: propertyheroimage {
    hidden: yes
    sql: ${TABLE}.propertyheroimage ;;
  }

  dimension: propertymanager {
    hidden:  yes
    type: string
    sql: ${TABLE}.propertymanager ;;
  }

  dimension: propertyowner {
    hidden:  yes
    type: string
    sql: ${TABLE}.propertyowner ;;
  }

  dimension: timezone {
    hidden:  yes
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: title {
    view_label: "Building and Geographic Information"
    label: "Building Title"
    type: string
    primary_key: yes
    sql: ${TABLE}.title ;;

  }

  dimension: city {
    hidden: yes
    type:  string
    sql:  ${TABLE}.address.city ;;
  }

  dimension: externalrefs_stripepayoutaccountid {
    view_label: "Building and Geographic Information"
    label: "Expected Stripe Account"
    type: string
    sql: ${TABLE}.externalrefs.stripepayoutaccountid ;;
  }
}

view: complexes__address {
  derived_table: {
    sql: SELECT address, _id, internaltitle, title
        FROM complexes
      ;;
    datagroup_trigger: units_kpo_overview_default_datagroup
  }

  dimension: title {
    view_label: "Building and Geographic Information"
    label: "Building Title"
    description: "The building title in the reviews model will pull building information from the property field under the reservations table for reservations not tied to any unit IDs"
    type: string
    primary_key: yes
    sql: CASE WHEN ${complexes.title} IS NULL THEN ${TABLE}.title
          ELSE ${complexes.title}
          END;;
  }

  dimension: internaltitle {
    hidden:  yes
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: address_city {
    hidden: yes
    view_label: "Core Dimensions"
    label: "City from C2"
    sql: CASE WHEN ${TABLE}.address.city = "" THEN NULL
          ELSE ${TABLE}.address.city
          END;;
  }

  dimension: address_state {
    hidden: yes
    view_label: "Core Dimensions"
    label: "State from C2"
    sql: CASE WHEN ${TABLE}.address.state = "" THEN NULL
          ELSE ${TABLE}.address.state
          END;;
  }

  dimension: address_city_revised {
    hidden: yes
    view_label: "Core Dimensions"
    label: "City (Incl. Complexes)"
    description: "This will pull the city from complexes if the unit is returning null values"
    sql: CASE WHEN ${units.address_city} IS NULL THEN ${complexes__address.address_city}
          ELSE ${units.address_city}
          END;;
  }

  dimension: address_state_revised {
    hidden: yes
    label: "State"
    description: "This will pull the State from complexes if the unit is returning null values"
    sql: CASE WHEN ${units.address_state} IS NULL THEN ${complexes__address.address_state}
          ELSE ${units.address_state}
          END;;
  }

  dimension: propcode_revised {
    hidden: no
    view_label: "Building and Geographic Information"
    label: "Property Code"
    description: "The Property Code in the reviews model will pull building information from the property field under the reservations table for reservations not tied to any unit IDs"
    type: string
    sql: CASE WHEN ${units.propcode} IS NULL THEN ${complexes__address.internaltitle}
          ELSE ${units.propcode}
          END
          ;;
  }

  dimension: region_revised {
    hidden: yes
    label: "Region"
    sql: CASE
          WHEN ${address_state_revised} IN ("TX") THEN "Texas"
          WHEN ${address_state_revised} IN ("WA","CA","UT","CO") THEN "West"
          WHEN ${address_state_revised} IN ("FL","DC","PA","CT","NJ","SC","NC","GA","VA","TN") THEN "East"
          WHEN ${address_state_revised} IN ("IL","IA","WI","MO","MN","AZ") THEN "Central"
          ELSE "Other"
          END ;;
  }

  dimension: _id {
    hidden:  yes
    type: string
    sql: ${TABLE}._id ;;
  }

}

view: complexes__externaltitle {
  dimension: airbnb {
    type: string
    sql: ${TABLE}.airbnb ;;
  }

  dimension: bookingcom {
    type: string
    sql: ${TABLE}.bookingcom ;;
  }

  dimension: default {
    type: string
    sql: ${TABLE}.`default` ;;
  }

  dimension: expedia {
    type: string
    sql: ${TABLE}.expedia ;;
  }

  dimension: homeaway {
    type: string
    sql: ${TABLE}.homeaway ;;
  }

  dimension: hotelcom {
    type: string
    sql: ${TABLE}.hotelcom ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }
}

view: complexes__flags {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: complexes__propertyheroimage {
  dimension: bytes {
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: height {
    type: number
    sql: ${TABLE}.height ;;
  }

  dimension: publicid {
    type: string
    sql: ${TABLE}.publicid ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: width {
    type: number
    sql: ${TABLE}.width ;;
  }
}

view: complexes__contacts__value__emails {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: complexes__contacts__value__reports {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: complexes__contacts__value {
  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: emails {
    hidden: yes
    sql: ${TABLE}.emails ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: reports {
    hidden: yes
    sql: ${TABLE}.reports ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: complexes__contacts {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}
