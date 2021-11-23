view: issue_categories {

  derived_table: {
    sql:   SELECT *
          FROM `bigquery-analytics-272822.Gsheets.issue_categories`
       ;;
    persist_for: "24 hours"
  }


  dimension: primary_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${parent_category} || ${sub_category} ;;
  }

  dimension: kustomer_issue_label {
    label: "Issue Category (API Name)"
    description: "This will pull the issue category in the same name format shown from Kustomer's API"
    hidden: yes
    type: string
    sql: ${TABLE}.Kustomer_Issue_Label ;;
  }

  dimension: access_io_tinfluenced {
    label: "Access/IOT Influenced"
    type: yesno
    sql: ${TABLE}.Access___IoT_Influenced  ;;
  }


  dimension: tech_influenced {
    type: yesno
    sql: ${TABLE}.Tech_Influenced  ;;
  }

  dimension: external_influenced {
    type: yesno
    sql: ${TABLE}.External_Influenced ;;
  }

  dimension: kfcinfluenced {
    label: "KFC Influenced"
    type: yesno
    sql: ${TABLE}.KFC_Influenced   ;;
  }

  dimension: kontrol_influenced {
    type: yesno
    sql: ${TABLE}.Kontrol_Influenced ;;
  }
  dimension: Reservations_Influenced {
    type: yesno
    sql: ${TABLE}.Reservations_Influenced ;;
  }
  dimension: parent_category {
    type: string
    sql: ${TABLE}.Parent ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub ;;
  }

  dimension: airbnb_subcategory {
    type: string
    label: "Airbnb Subcategory"
    sql: ${TABLE}.Airbnb_Subcategory ;;
  }


  measure: unique_conversations {
    label: "Unique Conversations (All)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "#,##0"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date, reservations_kustomer.confirmationcode]
  }

  measure: unique_conversations_kfc {
    label: "Unique Conversations (KFC Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "#,##0"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [kfcinfluenced: "yes",message.conversation_id: "-NULL"]
  }

  measure: unique_conversations_iot {
    label: "Unique Conversations (Access & IoT Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "###"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [access_io_tinfluenced: "yes" ,message.conversation_id: "-NULL",sub_category: "-Unit Lock: Dead Battery,-Unit Lock: User Error,-Building System: Non Responsive/No Power,-Building System: User Error"]
  }

  measure: unique_conversations_external {
    label: "Unique Conversations (External Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "###"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [external_influenced: "yes",message.conversation_id: "-NULL"]
  }

  measure: unique_conversations_kontrol {
    label: "Unique Conversations (Kontrol Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "###"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [kontrol_influenced: "yes",message.conversation_id: "-NULL"]
  }

  measure: unique_conversations_tech {
    label: "Unique Conversations (Tech Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "#,##0"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [tech_influenced: "yes",message.conversation_id: "-NULL"]
  }
  measure: unique_conversations_Res {
    label: "Unique Conversations (Reservations Influenced)"
    description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
    type: count_distinct
    sql: ${conversation.id} ;;
    value_format: "#,##0"
    drill_fields: [conversation.customer_id, conversation.id, conversation.created_date, message.created_date]
    filters: [Reservations_Influenced: "yes",message.conversation_id: "-NULL"]
  }

}
