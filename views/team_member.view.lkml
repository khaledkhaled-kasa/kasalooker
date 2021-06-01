view: team_member {
  sql_table_name: `kustomer.team_member`
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

  dimension: team_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.team_id ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user.display_name,
      user.name,
      user.id,
      team.display_name,
      team.name,
      team.id
    ]
  }
}
