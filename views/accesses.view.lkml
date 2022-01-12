view: accesses {
  label: "Accesses"
  sql_table_name: `bigquery-analytics-272822.dbt.accesses`   ;;


  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.primary_key ;;
  }

  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }
  dimension: devicetype {
    type: string
    sql: ${TABLE}.devicetype ;;
  }

  dimension: checkoutdate {
    type: string
    sql: ${TABLE}.checkoutdate ;;
  }

  dimension: unitid {
    type: string
    sql: ${TABLE}.unitid ;;
    hidden: yes
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: guestid {
    type: string
    sql: ${TABLE}.guestid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: accesstype {
    type: string
    sql: ${TABLE}.accesstype ;;
    hidden: yes
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }


  dimension_group: smartThingsInstalled{
    type: time
    timeframes: [date, week, month, year]
    sql: PARSE_TIMESTAMP('%Y/%d/%m', ${TABLE}.smartThingsInstalled);;
    convert_tz: no
    hidden: yes
  }
  measure: total_code{
    label: "Totale Accesses"
    type: count_distinct
    sql: ${_id} ;;
  }

  measure: total_backup_code_used {
    label: "Total Times Backup Code Used"
    description: "Returns the count of the total number of times a backup code was used."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [value: "%Backup%"]
    drill_fields: [value,confirmationcode]
  }

  measure: total_backup_code_used_nexia {
    label: "Total Backup Codes Used (Nexia)"
    description: "Returns the count of the total number of times a backup code was used for Nexia."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [value: "%Backup%", value:"%was used for nexia%"]
    drill_fields: [value,confirmationcode]
  }
  measure: total_backup_code_used_smartthings {
    label: "Total Backup Codes Used (ST)"
    description: "Returns the count of the total number of times a backup code was used for SmartThings."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [value: "%Backup%", value:"%was used for smartthings%"]
    drill_fields: [value,confirmationcode]
  }


  measure: total_backup_code_used_nexia_person {
    label: "Total Backup Codes Assigned by Person (Nexia)"
    description: "Returns the count of the total number of times a backup code manually assaigned."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [value: "%kasa.com%,-%smartthings%"]
    drill_fields: [value,confirmationcode]
  }

  measure: total_backup_code_used_smartthings_person {
    label: "Total Backup Codes Assigned by Person (ST)"
    description: "Returns the count of the total number of times a backup code manually assaigned."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [value: "%kasa.com%,-%nexia%"]
    drill_fields: [value,confirmationcode]
  }
  measure: total_backup_code_used_nexia_css {
    label: "Total Backup Codes Assigned by CSS (Nexia)"
    description:"Returns the count of the total number of times Backup code auto assigned by CSS."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [ value:"%was used for nexia (requested by CSS)%"]
    drill_fields: [value,confirmationcode]
  }
  measure: total_backup_code_used_smartthings_css {
    label: "Total Backup Codes Assigned by CSS (ST)"
    description:"Returns the count of the total number of times Backup code auto assigned by CSS."
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [ value:"%was used for smartthings (requested by CSS)%"]
    drill_fields: [value,confirmationcode]
  }




  measure: total_backup_code_used_naxie_manual {
    label: "Total Times Backup Code Assigned by Person"
    description: "Returns the count of the total number of times a backup code manually assaigned."
    type: count_distinct
    sql: ${primary_key} ;;

    filters: [value:"%Backup%" , value:"%kasa.com%", ]
    drill_fields: [value,confirmationcode]
      }

  measure: total_backup_code_used_naxie_automatic {
    label: "Total Times Backup Code Assigned by CSS"
    description: "Returns the count of the total number of times Backup code auto assigned by CSS."
    type: count_distinct
    sql: ${primary_key} ;;
    # sql:Case WHEN ${TABLE}.value LIKE "%Backup%"  AND   ${TABLE}.value LIKE "%requested by CSS%" AND ${TABLE}.devicetype LIKE "%Nexia_v1%"
    #   Then ${primary_key} ELSE NULL END;;
    filters: [value:"%Backup%" , value:"%requested by CSS%" ]
    drill_fields: [value,confirmationcode]
  }


  set: detail {
    fields: [
      checkoutdate,
      unitid,
      timezone,
      guestid,
      confirmationcode,
      accesstype,
      value
    ]
  }
}
