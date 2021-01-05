view: units {
  sql_table_name: `bigquery-analytics-272822.mongo.units`
    ;;

  dimension: _id {
    hidden:  yes
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: accomodates {
    type: number
    sql: ${TABLE}.accomodates ;;
  }

  dimension: address_city {
    hidden: no
    sql: CASE WHEN ${TABLE}.address.city = "" THEN NULL
    ELSE ${TABLE}.address.city
    END;;
  }

  dimension: address_state {
    hidden: no
    sql: CASE WHEN ${TABLE}.address.state = "" THEN NULL
    ELSE ${TABLE}.address.state
    END;;
  }

  dimension: region {
    hidden: no
    sql: CASE
    WHEN ${TABLE}.address.state IN ("TX") THEN "Texas"
    WHEN ${TABLE}.address.state IN ("WA","CA","UT","CO") THEN "West"
    WHEN ${TABLE}.address.state IN ("FL","DC","PA","CT","NJ","SC","NC","GA","VA","TN") THEN "East"
    WHEN ${TABLE}.address.state IN ("IL","IA","WI","MO","MN","AZ") THEN "Central"
    ELSE "Other"
    END ;;
  }

  dimension: amenities {
    hidden: yes
    sql: ${TABLE}.amenities ;;
  }

  dimension: askadditionalguests {
    type: yesno
    sql: ${TABLE}.askadditionalguests ;;
  }

  dimension: availability {
    hidden: yes
    sql: ${TABLE}.availability ;;
  }

  dimension: availability_startdate {
    hidden: no
    type: date
    sql: TIMESTAMP(${TABLE}.availability.startdate);;
  }

  dimension: availability_periods  {
    hidden: no
    type: string
    sql: CASE WHEN
    --TIMESTAMP(${TABLE}.availability.startdate)
    (((TIMESTAMP(units.availability.startdate)) >=
    ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS DATE), INTERVAL -5 MONTH) AS STRING)
    , ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS TIMESTAMP)) AS STRING)))))
    AND (TIMESTAMP(units.availability.startdate)) <
    ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS DATE), INTERVAL -5 MONTH) AS STRING)
    , ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 6 MONTH) AS STRING)
    , ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS DATE), INTERVAL -5 MONTH) AS STRING)
    , ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), MONTH) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))))))) THEN "Last 6 Months"
    ELSE "Before 6 Months Ago"
    END;;
  }



  dimension: availability_startdate_45day_mark {
    hidden: no
    type: date
    sql: TIMESTAMP_ADD(TIMESTAMP(${TABLE}.availability.startdate), INTERVAL 45 DAY);;
  }

  dimension: availability_enddate {
    hidden: no
    type: date
    sql: TIMESTAMP(${TABLE}.availability.enddate);;
  }

  dimension: backupsmartlockcodes {
    hidden: yes
    sql: ${TABLE}.backupsmartlockcodes ;;
  }

  dimension: baseprice {
    type: number
    sql: ${TABLE}.baseprice ;;
  }

  dimension: bathrooms_old {
    type: number
    hidden: yes
    sql: ${TABLE}.bathrooms ;;
  }

  dimension: bathrooms__fl {
    type: number
    sql: ${TABLE}.bathrooms__fl ;;
  }

  dimension: bathrooms {
    type: number
    sql: CASE WHEN ${TABLE}.bathrooms__fl IS NULL THEN ${TABLE}.bathrooms
          ELSE ${TABLE}.bathrooms__fl
          END;;
  }

  dimension: bedrooms {
    type: number
    primary_key: yes
    sql: ${TABLE}.roomtype.bedroomcount ;;
  }


  dimension: building {
    type: string
    sql: ${TABLE}.building ;;
  }

  dimension: buildingexternaltitle {
    type: string
    sql: ${TABLE}.buildingexternaltitle ;;
  }

  dimension: buildinginternaltitle {
    type: string
    sql: ${TABLE}.buildinginternaltitle ;;
  }

  dimension: callbox {
    hidden: yes
    sql: ${TABLE}.callbox ;;
  }

  dimension: checkindetails {
    hidden: yes
    sql: ${TABLE}.checkindetails ;;
  }

  dimension: cleaningstatus {
    type: string
    sql: ${TABLE}.cleaningstatus ;;
  }

  dimension: complex {
    type: string
    sql: ${TABLE}.complex ;;
  }

  dimension: defaultcheckin {
    type: string
    sql: ${TABLE}.defaultcheckin ;;
  }

  dimension: defaultcheckintime {
    type: string
    sql: ${TABLE}.defaultcheckintime ;;
  }

  dimension: defaultcheckout {
    type: string
    sql: ${TABLE}.defaultcheckout ;;
  }

  dimension: defaultcheckouttime {
    type: string
    sql: ${TABLE}.defaultcheckouttime ;;
  }

  dimension: door {
    type: string
    sql: ${TABLE}.door ;;
  }

  dimension: externalrefs {
    hidden: yes
    sql: ${TABLE}.externalrefs ;;
  }

  dimension: externalrefs_property_id {
    label: "Guesty Id"
    sql: ${TABLE}.externalrefs.guesty_id ;;
  }

  dimension: facilities {
    hidden: yes
    sql: ${TABLE}.facilities ;;
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
    type: yesno
    sql: ${TABLE}.hashighriskneighbor ;;
  }

  dimension: hassmartlock {
    type: yesno
    sql: ${TABLE}.hassmartlock ;;
  }

  dimension: housekeepers {
    hidden: yes
    sql: ${TABLE}.housekeepers ;;
  }

  dimension: internaltitle {
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: propcode {
    type: string
    sql: substr(${TABLE}.internaltitle, 1, 3) ;;
  }

  dimension: islisted {
    type: yesno
    sql: ${TABLE}.islisted ;;
  }

  dimension: keycafe {
    hidden: yes
    sql: ${TABLE}.keycafe ;;
  }

  dimension: lock_id {
    type: string
    sql: ${TABLE}.lock_id ;;
  }

  dimension: maps {
    hidden: yes
    sql: ${TABLE}.maps ;;
  }

  dimension: nexiaid {
    type: string
    sql: ${TABLE}.nexiaid ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.nickname ;;
  }

  dimension: parkingtype {
    type: string
    sql: ${TABLE}.parkingtype ;;
  }

  dimension: petsallowed {
    type: yesno
    sql: ${TABLE}.petsallowed ;;
  }

  dimension: photos {
    hidden: yes
    sql: ${TABLE}.photos ;;
  }

  dimension: propertyexternaltitle {
    type: string
    sql: ${TABLE}.propertyexternaltitle ;;
  }

  dimension: propertyheroimage {
    hidden: yes
    sql: ${TABLE}.propertyheroimage ;;
  }

  dimension: propertyinternaltitle {
    type: string
    sql: ${TABLE}.propertyinternaltitle ;;
  }

  dimension: rooms {
    hidden: yes
    sql: ${TABLE}.rooms ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tags {
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: wifi {
    hidden: yes
    sql: ${TABLE}.wifi ;;
  }

  measure: count {
    type: count
    drill_fields: [nickname]
  }

}


view: units__rooms__value {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: beds {
    hidden: yes
    sql: ${TABLE}.beds ;;
  }

  dimension: roomnumber {
    type: number
    sql: ${TABLE}.roomnumber ;;
  }
}

# view: units__rooms__value__beds__value {
#   dimension: _id {
#     type: string
#     sql: ${TABLE}._id ;;
#   }
#
#   dimension: quantity {
#     type: number
#     sql: ${TABLE}.quantity ;;
#   }
#
#   dimension: type {
#     type: string
#     sql: ${TABLE}.type ;;
#   }
# }
#
# view: units__photos {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__checkindetails {
#   dimension: buildingcode {
#     type: number
#     sql: ${TABLE}.buildingcode ;;
#   }
#
#   dimension: buildingcode__st {
#     type: string
#     sql: ${TABLE}.buildingcode__st ;;
#   }
#
#   dimension: isremote {
#     type: yesno
#     sql: ${TABLE}.isremote ;;
#   }
#
#   dimension: lockboxcode {
#     type: string
#     sql: ${TABLE}.lockboxcode ;;
#   }
#
#   dimension: lockboxcode__it {
#     type: number
#     sql: ${TABLE}.lockboxcode__it ;;
#   }
#
#   dimension: lockboxnumber {
#     type: string
#     sql: ${TABLE}.lockboxnumber ;;
#   }
#
#   dimension: lockboxnumber__it {
#     type: number
#     sql: ${TABLE}.lockboxnumber__it ;;
#   }
#
#   dimension: mailboxnumber {
#     type: string
#     sql: ${TABLE}.mailboxnumber ;;
#   }
#
#   dimension: parkingnumber {
#     type: string
#     sql: ${TABLE}.parkingnumber ;;
#   }
#
#   dimension: parkingtagnumber {
#     type: string
#     sql: ${TABLE}.parkingtagnumber ;;
#   }
#
#   dimension: wifipassword {
#     type: string
#     sql: ${TABLE}.wifipassword ;;
#   }
#
#   dimension: wifiusername {
#     type: string
#     sql: ${TABLE}.wifiusername ;;
#   }
# }
#
# view: units__keycafe {
#   drill_fields: [id]
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.id ;;
#   }
#
#   dimension: active {
#     type: yesno
#     sql: ${TABLE}.active ;;
#   }
# }
#
# view: units__callbox__value {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: enabled {
#     type: yesno
#     sql: ${TABLE}.enabled ;;
#   }
#
#   dimension: entry {
#     type: string
#     sql: ${TABLE}.entry ;;
#   }
#
#   dimension: phonenumber {
#     type: string
#     sql: ${TABLE}.phonenumber ;;
#   }
#
#   dimension: type {
#     type: string
#     sql: ${TABLE}.type ;;
#   }
# }
#
# view: units__wifi {
#   dimension: password {
#     type: string
#     sql: ${TABLE}.password ;;
#   }
#
#   dimension: ssid {
#     type: string
#     sql: ${TABLE}.ssid ;;
#   }
# }
#
# view: units__maps__facilitymap {
#   dimension: bytes {
#     type: number
#     sql: ${TABLE}.bytes ;;
#   }
#
#   dimension: height {
#     type: number
#     sql: ${TABLE}.height ;;
#   }
#
#   dimension: publicid {
#     type: string
#     sql: ${TABLE}.publicid ;;
#   }
#
#   dimension: url {
#     type: string
#     sql: ${TABLE}.url ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
#
#   dimension: width {
#     type: number
#     sql: ${TABLE}.width ;;
#   }
# }
#
# view: units__tags {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__amenities {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__backupsmartlockcodes {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__propertyheroimage {
#   dimension: bytes {
#     type: number
#     sql: ${TABLE}.bytes ;;
#   }
#
#   dimension: height {
#     type: number
#     sql: ${TABLE}.height ;;
#   }
#
#   dimension: publicid {
#     type: string
#     sql: ${TABLE}.publicid ;;
#   }
#
#   dimension: url {
#     type: string
#     sql: ${TABLE}.url ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
#
#   dimension: width {
#     type: number
#     sql: ${TABLE}.width ;;
#   }
# }
#
# view: units__availability {
#   dimension: enddate {
#     type: string
#     sql: ${TABLE}.enddate ;;
#   }
#
#   dimension: startdate {
#     type: string
#     sql: ${TABLE}.startdate ;;
#   }
# }
#

#
#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension: lat {
#     type: number
#     sql: ${TABLE}.lat ;;
#   }
#
#   dimension: lon {
#     type: number
#     sql: ${TABLE}.lon ;;
#   }
#
#
#   dimension: street {
#     type: string
#     sql: ${TABLE}.street ;;
#   }
#
#   dimension: zip {
#     type: zipcode
#     sql: ${TABLE}.zip ;;
#   }
# }
#
# view: units__housekeepers {
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__externalrefs {
#   dimension: airbnbid {
#     type: number
#     value_format_name: id
#     sql: ${TABLE}.airbnbid ;;
#   }
#
#   dimension: guesty_id {
#     type: string
#     sql: ${TABLE}.guesty_id ;;
#   }
#
#   dimension: nexiaid {
#     type: number
#     value_format_name: id
#     sql: ${TABLE}.nexiaid ;;
#   }
#
#   dimension: nexiaid__st {
#     type: string
#     sql: ${TABLE}.nexiaid__st ;;
#   }
#
#   dimension: rentalsunitedid {
#     type: number
#     value_format_name: id
#     sql: ${TABLE}.rentalsunitedid ;;
#   }
# }
#
# view: units__facilities__value {
#   dimension: ref {
#     type: string
#     sql: ${TABLE}.ref ;;
#   }
#
#   dimension: type {
#     type: string
#     sql: ${TABLE}.type ;;
#   }
# }
#
# view: units__rooms {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__rooms__value__beds {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__callbox {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: units__maps {
#   dimension: facilitymap {
#     hidden: yes
#     sql: ${TABLE}.facilitymap ;;
#   }
# }
#
# view: units__facilities {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
