view: guests {
  sql_table_name: `bigquery-analytics-272822.mongo.guests`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: additional_info {
    hidden: yes
    sql: ${TABLE}.additional_info ;;
  }

  dimension: additionalinfo {
    hidden: yes
    sql: ${TABLE}.additionalinfo ;;
  }

  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.address.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.address.state ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.address.city ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.address.zip ;;
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

  dimension_group: dateofbirth {
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
    sql: ${TABLE}.dateofbirth ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: emailmarketingaccepted {
    type: yesno
    sql: ${TABLE}.emailmarketingaccepted ;;
  }

  dimension: externalrefs {
    hidden: yes
    sql: ${TABLE}.externalrefs ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
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

  dimension: verification {
    hidden: yes
    sql: ${TABLE}.verification ;;
  }

  dimension: is_verified {
    sql:  ${TABLE}.verification.isverified ;;
  }

  measure: count_guests {
    type: count
    drill_fields: [firstname, lastname]
  }
}

view: guests__address {
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

  dimension: street1 {
    type: string
    sql: ${TABLE}.street1 ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
}

view: guests__additionalinfo__emails {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: guests__additionalinfo__phones {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: guests__additionalinfo__survey__value {
  dimension: bookingsource {
    type: string
    sql: ${TABLE}.bookingsource ;;
  }

  dimension: reasonforstay {
    type: string
    sql: ${TABLE}.reasonforstay ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }
}

view: guests__additional_info__emails {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: guests__additional_info__phones {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: guests__additional_info__survey__value {
  dimension: bookingsource {
    type: string
    sql: ${TABLE}.bookingsource ;;
  }

  dimension: reasonforstay {
    type: string
    sql: ${TABLE}.reasonforstay ;;
  }
}

view: guests__externalrefs {
  dimension: airbnbid {
    type: number
    value_format_name: id
    sql: ${TABLE}.airbnbid ;;
  }

  dimension: airbnbid__fl {
    type: number
    sql: ${TABLE}.airbnbid__fl ;;
  }

  dimension: airbnbthreadid {
    type: number
    value_format_name: id
    sql: ${TABLE}.airbnbthreadid ;;
  }

  dimension: guesty_id {
    type: string
    sql: ${TABLE}.guesty_id ;;
  }

  dimension: kustomerconversationid {
    type: string
    sql: ${TABLE}.kustomerconversationid ;;
  }

  dimension: stripecustomerid {
    type: string
    sql: ${TABLE}.stripecustomerid ;;
  }
}

view: guests__verification__selfie {
  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: lng {
    type: number
    sql: ${TABLE}.lng ;;
  }
}

view: guests__verification {
  dimension: isverified {
    type: yesno
    sql: ${TABLE}.isverified ;;
  }

  dimension: selfie {
    hidden: yes
    sql: ${TABLE}.selfie ;;
  }

  dimension: verifiedat {
    type: number
    sql: ${TABLE}.verifiedat ;;
  }

  dimension_group: verifiedat__ts {
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
    sql: ${TABLE}.verifiedat__ts ;;
  }
}

view: guests__additionalinfo {
  dimension: emails {
    hidden: yes
    sql: ${TABLE}.emails ;;
  }

  dimension: phones {
    hidden: yes
    sql: ${TABLE}.phones ;;
  }

  dimension: survey {
    hidden: yes
    sql: ${TABLE}.survey ;;
  }
}

view: guests__additionalinfo__survey {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: guests__additional_info {
  dimension: emails {
    hidden: yes
    sql: ${TABLE}.emails ;;
  }

  dimension: phones {
    hidden: yes
    sql: ${TABLE}.phones ;;
  }

  dimension: survey {
    hidden: yes
    sql: ${TABLE}.survey ;;
  }
}

view: guests__additional_info__survey {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}
