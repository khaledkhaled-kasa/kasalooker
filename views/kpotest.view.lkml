view: kpotest {
  derived_table: {
    sql: select KPO_table.UID, KPO_table.status
      from

              `bigquery-analytics-272822.mongo.units` units
              right JOIN  `bigquery-analytics-272822.Gsheets.kpo_overview_clean` KPO_table
              ON units.internaltitle =KPO_table.UID WHERE units.internaltitle is null
       ;;
  }


  dimension: uid {
    label: "UID"
    type: string
    sql: ${TABLE}.UID ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  set: detail {
    fields: [uid, status]
  }
  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }
}
