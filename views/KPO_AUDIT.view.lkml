view: KPO_AUDIT {
  derived_table: {
    sql:

    SELECT KPO_table.UID, KPO_table.PropCode, KPO_table.PropShrt, KPO_table.PropOwner, KPO_table.status,KPO_table.newpartner,
      units.internaltitle, ContractType, FirstAvailableDate, ContractSignedDate, pom_information.PropertyClass,
      CASE WHEN complexes.title IS NOT NULL THEN complexes.title
      ELSE KPO_table.PropShrt
      END title

      FROM `bigquery-analytics-272822.Gsheets.kpo_overview_clean` KPO_table
      LEFT JOIN `bigquery-analytics-272822.mongo.units` units
        ON units.internaltitle =KPO_table.UID
      LEFT JOIN `bigquery-analytics-272822.mongo.complexes` complexes
        ON KPO_table.PropCode = complexes.internaltitle -- This join ensures that all units are tagged to building titles including newly signed ones (that haven't been onboarded on Guesty)
      LEFT JOIN `bigquery-analytics-272822.Gsheets.pom_information` pom_information
        ON pom_information.PropCode = KPO_table.PropCode

      WHERE ContractType != 'Distribution Agreement'
       ;;

      persist_for: "1 hours"
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

  dimension: PropOwner {
    type: string
    sql: ${TABLE}.PropOwner ;;
  }

  dimension: building_title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: new_partner {
    label: "Partner (New/Existing)"
    description: "This will pull the value from Column BE of the KPO"
    type: string
    sql: ${TABLE}.NewPartner ;;
  }

  dimension: property_class {
    type: string
    sql: ${TABLE}.PropertyClass ;;
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
    description: "This will pull the contract signed date from Col BK of the Kasa Portfolio Overview"
    type: time
    timeframes: [date, week, month, year]
    sql: cast(PARSE_DATE('%m/%d/%Y',${TABLE}.ContractSignedDate) as TIMESTAMP);;
    convert_tz: no
  }


  measure: countt {
    type: count_distinct
    label: "Total Unique Units"
    hidden: yes
    description: "Count # of Units with Active,Onboarding,Expiring status "
    sql:${TABLE}.UID ;;
    filters: [status: "Active,Onboarding,Expiring"]
    drill_fields: [detail*]
  }
  measure: count_partners {
    type: count_distinct
    label: "Total Unique Property Owners"
    description: "Count # of Partners with Active,Onboarding,Expiring status "
    sql:${TABLE}.PropOwner ;;
    hidden: yes
    filters: [status: "Active,Onboarding,Expiring"]
    drill_fields: [detail*]
  }
  measure: count {
    type: count_distinct
    label: "Total Unique Units"
    sql:${TABLE}.UID ;;
    drill_fields: [detail*]
  }
  measure: count_partners2 {
    type: count_distinct
    label: "Total Unique Property Owners"
    sql:${TABLE}.PropOwner ;;
    drill_fields: [detail*]
  }





  measure: countMissigunitsFromUnitsMongo{
    type: count_distinct
    label: "Total Miss Units From Units Mongo"
    sql:Case WHEN ${TABLE}.internaltitle is Null and ${TABLE}.status<>"Deactivated" and ${TABLE}.ContractType <>"Distribution Agreement" THEN ${TABLE}.UID ELSE NULL END;;
    drill_fields: [detail*]
  }
set: detail {
  fields: [uid,status]}
}
