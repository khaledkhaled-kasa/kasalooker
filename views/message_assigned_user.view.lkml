view: message_assigned_user {
  sql_table_name: `kustomer.message_assigned_user`
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

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [user.display_name, user.name, user.id, message.first_company_name, message.id]
  }
}
