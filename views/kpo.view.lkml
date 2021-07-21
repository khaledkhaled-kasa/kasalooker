view: kpo {
  derived_table: {
    sql: select KPO_table.UID, KPO_table.status,units.internaltitle,ContractType
      from

               `bigquery-analytics-272822.Gsheets.kpo_overview_clean` KPO_table
             LEFT JOIN `bigquery-analytics-272822.mongo.units` units
              ON units.internaltitle =KPO_table.UID
       ;;
  }


  dimension: uid {
    label: "UID"
    type: string
    sql: ${TABLE}.UID ;;
    primary_key: yes
  }
  dimension: ContractType {
    label: "ContractType"
    type: string
    sql: ${TABLE}.ContractType ;;
  }
  dimension: internaltitle {
    hidden: no
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  set: detail {
    fields: [uid,status]
  }
  measure: countt {
    type: count_distinct
    label: "Total Unique Properties"
    description: "Count # of Units with Active,Onboarding,Expiring status "
    sql:${TABLE}.UID ;;
    filters: [status: "Active,Onboarding,Expiring"]
    drill_fields: [detail*]
  }
  measure: countMissigunitsFromUnitsMongo{
    type: count_distinct
    label: "Total Miss Properties From Units Mongo"
    sql:Case WHEN ${TABLE}.internaltitle is Null and ${TABLE}.status<>"Deactivated" and ${TABLE}.ContractType <>"Distribution Agreement" THEN ${TABLE}.UID ELSE NULL END;;
    drill_fields: [detail*]
  }
}
