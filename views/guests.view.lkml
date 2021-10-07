view: guests {

  sql_table_name:`bigquery-analytics-272822.mongo.guests`;;
  # derived_table: {
  #   sql: SELECT *, auditlog.value.reason  AS reason FROM `bigquery-analytics-272822.mongo.guests`
  #   LEFT JOIN UNNEST(verification.idcheckstatusaudit) as auditlog
  #       ;;
  #   datagroup_trigger: kasametrics_reservations_datagroup


  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
    primary_key: yes
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

  dimension: auditlog_value_reason {
    type: string
    sql: ${TABLE}.reason ;;
    hidden: no
  }


#   dimension: isDeclined {
#     type: yesno
#     label: "Selfie/Govt ID Declined"
#     description: "Selfie/Govt ID failed or got declined"
#     sql: ${TABLE}.reason like "%id_check.declined%";;
#     drill_fields: [auditlog_value_reason]
# }


  dimension: idcheckstatus{
    type: string
    label: "ID Status"
    description: "Selfie/Govt ID Submission Status"
    sql: ${TABLE}.verification.idcheckstatus;;
  }

  dimension: backgroundCheckStatus{
    type: string
    label: "BGC Status"
    description: "Background Check Status"
    sql: ${TABLE}.verification.backgroundcheckstatus;;
  }

}
