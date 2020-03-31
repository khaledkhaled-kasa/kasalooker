view: complexes {
  sql_table_name: `bigquery-analytics-272822.mongo.complexes`
    ;;

  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension_group: _sdc_batched {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: contacts {
    hidden: yes
    sql: ${TABLE}.contacts ;;
  }

  dimension_group: createdat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdat ;;
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
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: ishighrisk {
    type: yesno
    sql: ${TABLE}.ishighrisk ;;
  }

  dimension: propertyheroimage {
    hidden: yes
    sql: ${TABLE}.propertyheroimage ;;
  }

  dimension: propertymanager {
    type: string
    sql: ${TABLE}.propertymanager ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension_group: updatedat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedat ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: complexes__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
  }

  dimension: zip {
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
