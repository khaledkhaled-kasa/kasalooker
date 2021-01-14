view: complexes {
  label: "zBuildings"
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
    view_label: "Core Dimensions"
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

}

view: complexes__address {
  dimension: city {
    view_label: "Core Dimensions"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    view_label: "Core Dimensions"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    view_label: "Core Dimensions"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street {
    view_label: "Core Dimensions"
    type: string
    sql: ${TABLE}.street ;;
  }

  dimension: zip {
    view_label: "Core Dimensions"
    type: zipcode
    sql: ${TABLE}.zip ;;
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
