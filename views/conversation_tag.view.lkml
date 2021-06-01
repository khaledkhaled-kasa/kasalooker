view: conversation_tag {
  sql_table_name: `kustomer.conversation_tag`
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

  dimension: conversation_id {
    type: string
    hidden: yes
    sql: ${TABLE}.conversation_id ;;
  }

  dimension: tag_id {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_id ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: [conversation.id, conversation.first_company_name, conversation.name, tag.name, tag.id]
  # }
}
