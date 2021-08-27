view: kustomer_notes {
  sql_table_name:  `bigquery-analytics-272822.kustomer.note` ;;


  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: body {
    label: "Note"
    type: string
    sql: ${TABLE}.body ;;
  }

  set: detail {
    fields: [id, conversation_id, customer_id, body]
  }
}
