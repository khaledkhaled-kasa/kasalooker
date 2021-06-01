view: conversation_channel {
  sql_table_name: `kustomer.conversation_channel`
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

  dimension: index {
    type: number
    hidden: yes
    sql: ${TABLE}.index ;;
  }

  dimension: name {
    type: string
    hidden: yes
    sql: ${TABLE}.name ;;
  }



}
