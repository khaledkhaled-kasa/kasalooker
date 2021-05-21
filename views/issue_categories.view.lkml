view: issue_categories {
  sql_table_name: `bigquery-analytics-272822.Gsheets.issue_categories`
    ;;

  dimension: primary_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${parent_category} || ${sub_category} ;;
  }

  dimension: access_io_tinfluenced {
    type: string
    sql: ${TABLE}.AccessIoTInfluenced ;;
  }

  dimension: external_influenced {
    type: string
    sql: ${TABLE}.ExternalInfluenced ;;
  }

  dimension: kfcinfluenced {
    type: string
    sql: ${TABLE}.KFCInfluenced ;;
  }

  dimension: kontrol_influenced {
    type: string
    sql: ${TABLE}.KontrolInfluenced ;;
  }

  dimension: parent_category {
    type: string
    sql: ${TABLE}.ParentCategory ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.SubCategory ;;
  }

  dimension: tech_influenced {
    type: string
    sql: ${TABLE}.TechInfluenced ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
