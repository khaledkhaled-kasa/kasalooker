view: KPO_AUDIT {
  derived_table: {
    sql: select KPO_table.UID, KPO_table.PropCode, KPO_table.status,units.internaltitle,ContractType,FirstAvailableDate,ContractSignedDate
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
    label: "Units internaltitle "
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: PropCode {
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension_group: FirstAvailableDate
  {
    label: "First Available Date"
    type: time
    timeframes: [date, week, month, year]
    sql: cast(PARSE_DATE('%m/%d/%Y',${TABLE}.FirstAvailableDate)as TIMESTAMP) ;;
    convert_tz: no
  }
  dimension_group: ContractSignedDate
  {
    label: "Contract Signed Date"
    type: time
    timeframes: [date, week, month, year]
    sql: cast(PARSE_DATE('%m/%d/%Y',${TABLE}.ContractSignedDate) as TIMESTAMP);;
    convert_tz: no
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
set: detail {
  fields: [uid,status]}
}
