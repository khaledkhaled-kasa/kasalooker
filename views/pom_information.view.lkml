view: pom_information {
  derived_table: {
    sql:  SELECT *
          FROM `bigquery-analytics-272822.Gsheets.pom_information` ;;
  datagroup_trigger: pom_checklist_default_datagroup
  }

  dimension: Prop_Code {
    type: string
    sql: ${TABLE}.PropCode ;;
  }

  dimension: PropOfficial {
    type: string
    sql: ${TABLE}.PropOfficial ;;
  }

  dimension: pom {
    type: string
    sql: ${TABLE}.POM ;;
  }

  dimension: property {
    type: string
    sql: ${TABLE}.Property ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
