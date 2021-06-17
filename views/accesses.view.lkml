view: accesses {
  derived_table: {
    sql: SELECT  a.checkoutdatelocal as checkoutdate,
        a.unitid,
        a.timezone,
        a.guestid,
        a.confirmationcode,
        a.accesstype,
        auditlog.value,
        a.confirmationcode || auditlog.value as primary_key
        FROM `bigquery-analytics-272822.mongo.accesses` a
          LEFT JOIN UNNEST(auditlog) as auditlog
         ;;
    datagroup_trigger: kasametrics_reservations_datagroup
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.primary_key ;;
  }

  dimension: checkoutdate {
    type: string
    sql: ${TABLE}.checkoutdate ;;
  }

  dimension: unitid {
    type: string
    sql: ${TABLE}.unitid ;;
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
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_backup_code_used {
    label: "Total Times Backup Code Used"
    description: "Returns the count of the total number of times a backup code was used for a Nexia device."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [value: "%Backup%"]
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

# Test
# view: accesses {
#   derived_table: {
#     sql: SELECT  a.checkoutdatelocal as checkoutdate,d.devicetype,
#         a.unitid,
#         a.timezone,
#         a.guestid,
#         a.confirmationcode,
#         a.accesstype,
#         auditlog.value,
#         a.confirmationcode || auditlog.value as primary_key
#         FROM `bigquery-analytics-272822.mongo.accesses` a
#         LEFT JOIN UNNEST(auditlog) as auditlog
#         LEFT JOIN devices d
#         ON a.unitid=d.unit
#         ;;
#     datagroup_trigger: kasametrics_reservations_datagroup
#   }

#   dimension: primary_key {
#     type: string
#     primary_key: yes
#     hidden: yes
#     sql: ${TABLE}.primary_key ;;
#   }

#   dimension: checkoutdate {
#     type: string
#     sql: ${TABLE}.checkoutdate ;;
#   }

#   dimension: unitid {
#     type: string
#     sql: ${TABLE}.unitid ;;
#   }

#   dimension: timezone {
#     type: string
#     sql: ${TABLE}.timezone ;;
#   }

#   dimension: guestid {
#     type: string
#     sql: ${TABLE}.guestid ;;
#   }

#   dimension: confirmationcode {
#     type: string
#     sql: ${TABLE}.confirmationcode ;;
#   }

#   dimension: accesstype {
#     type: string
#     sql: ${TABLE}.accesstype ;;
#   }

#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
#   dimension: devicetype {
#     type: string
#     sql: ${TABLE}.devicetype ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

#   measure: total_backup_code_used_naxie {
#     label: "Total Times Backup Code Used (Nexia)"
#     description: "Returns the count of the total number of times a backup code was used for a Nexia device."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     filters: [value: "%Backup%", devicetype: "Nexia_v1"]
#   }

#   measure: total_backup_code_used_smartthings {
#     label: "Total Times Backup Code Used (SmartThings)"
#     description: "Returns the count of the total number of times a backup code was used for a Smarttings device."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     filters: [value: "%Backup%", devicetype: "Smartthings_v1"]
#   }

#   measure: total_backup_code_used_naxie_automatic {
#     label: "Total Times Backup Code Assigned by CSS (Nexia)"
#     description: "Returns the count of the total number of times Backup code auto assigned by CSS (Nexia)."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     # sql:Case WHEN ${TABLE}.value LIKE "%Backup%"  AND   ${TABLE}.value LIKE "%requested by CSS%" AND ${TABLE}.devicetype LIKE "%Nexia_v1%"
#     #   Then ${primary_key} ELSE NULL END;;
#     filters: [value:"%Backup%" , value:"%requested by CSS%",devicetype:"Nexia_v1" ]
#   }

#   measure: total_backup_code_used_naxie_manual {
#     label: "Total Times Backup Code Assigned by Person (Nexia)"
#     description: "Returns the count of the total number of times a backup code manually assaigned (Nexia)."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     # sql: Case WHEN ${TABLE}.value LIKE "%Backup%"  AND   ${TABLE}.value LIKE "%@kasa.com%" AND ${TABLE}.devicetype LIKE "%Nexia_v1%"
#     #   Then ${primary_key} ELSE NULL END ;;
#     filters: [value:"%Backup%" , value:"%kasa.com%",devicetype:"Nexia_v1" ]
#       }

#   measure: total_backup_code_used_smartthings_manual {
#     label: "Total Times Backup Code Assigned by Person (ST)"
#     description: "Returns the count of the total number of times a backup code manually assaigned (SmartThings)."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     # sql: sql: Case WHEN ${TABLE}.value LIKE "%Backup%"  AND   ${TABLE}.value LIKE "%@kasa.com%" AND ${TABLE}.devicetype LIKE "Smartthings_v1"
#     #   Then ${primary_key} ELSE NULL END ;;
#     filters: [value:"%Backup%" , value:"%kasa.com%",devicetype:"Smartthings_v1" ]
#   }

#   measure: total_backup_code_used_smartthings_automatic {
#     label: "Total Times Backup Code Assigned by CSS (ST)"
#     description: "Returns the count of the total number of times Backup code auto assigned by CSS (SmartThings)."
#     type: count_distinct
#     sql: ${primary_key} ;;
#     filters: [value: "%Backup%" , value: "%requested by CSS%",devicetype: "Smartthings_v1" ]
#   }


#   set: detail {
#     fields: [
#       checkoutdate,
#       unitid,
#       timezone,
#       guestid,
#       confirmationcode,
#       accesstype,
#       value
#     ]
#   }


# }
