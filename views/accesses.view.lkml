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
