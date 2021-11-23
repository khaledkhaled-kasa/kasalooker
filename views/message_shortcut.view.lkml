view: message_shortcut {
  sql_table_name: `kustomer.message_shortcut`
    ;;

  dimension_group: _fivetran_synced {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: message_id {
    type: string
    hidden: yes
    sql: ${TABLE}.message_id ;;
  }

  dimension: shortcut_id {
    type: string
    hidden: yes
    sql: ${TABLE}.shortcut_id ;;
  }

}
