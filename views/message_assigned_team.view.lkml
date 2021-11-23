view: message_assigned_team {
  sql_table_name: `kustomer.message_assigned_team`
    ;;

  dimension_group: _fivetran_synced {
    type: time
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
    # hidden: yes
    sql: ${TABLE}.message_id ;;
  }

  dimension: team_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.team_id ;;
  }

  measure: count {
    type: count
    drill_fields: [message.first_company_name, message.id, team.display_name, team.name, team.id]
  }
}
