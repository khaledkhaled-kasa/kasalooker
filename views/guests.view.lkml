view: guests {
  sql_table_name: `bigquery-analytics-272822.mongo.guests`
    ;;

  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
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


  dimension_group: dateofbirth {
    label: "Birth"
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


  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }


}
