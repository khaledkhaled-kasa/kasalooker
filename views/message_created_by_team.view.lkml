view: message_created_by_team {
  sql_table_name: `kustomer.message_created_by_team`
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

  dimension: team_id {
    type: string
    hidden: yes
    sql: ${TABLE}.team_id ;;
  }

}
