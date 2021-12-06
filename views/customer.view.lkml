view: customer {
  sql_table_name: `kustomer.customer`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: customer_url {
    type: string
    sql: CONCAT("https://kasa.kustomerapp.com/app/customers/",${TABLE}.id) ;;
    link: {
      label: "Navigate to Kustomer"
      url: "{{ value }}"
    }
  }

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

  dimension: company_id {
    type: string
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: conversation_counts_all {
    type: number
    sql: ${TABLE}.conversation_counts_all ;;
  }

  dimension: conversation_counts_done {
    type: number
    sql: ${TABLE}.conversation_counts_done ;;
  }

  dimension: conversation_counts_open {
    type: number
    sql: ${TABLE}.conversation_counts_open ;;
  }

  dimension: conversation_counts_snoozed {
    type: number
    sql: ${TABLE}.conversation_counts_snoozed ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: custom_air_bn_buser_id_num {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.custom_air_bn_buser_id_num ;;
  }

  dimension: custom_airbnb_thread_id_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_airbnb_thread_id_str ;;
  }

  dimension: custom_airbnb_thread_ids_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_airbnb_thread_ids_str ;;
  }

  dimension: custom_background_check_status_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_background_check_status_str ;;
  }

  dimension_group: custom_background_checked_at {
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
    sql: ${TABLE}.custom_background_checked_at_at ;;
  }

  dimension: custom_guesty_ids_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_guesty_ids_str ;;
  }

  dimension: custom_housekeeping_partner_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_housekeeping_partner_str ;;
  }

  dimension: custom_housekeeping_partners_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_housekeeping_partners_bool ;;
  }

  dimension: custom_id_check_status_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_id_check_status_str ;;
  }

  dimension_group: custom_id_checked_at {
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
    sql: ${TABLE}.custom_id_checked_at_at ;;
  }

  dimension_group: custom_last_missed_call_text {
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
    sql: ${TABLE}.custom_last_missed_call_text_at ;;
  }

  dimension_group: custom_latest_check_in_date {
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
    sql: ${TABLE}.custom_latest_check_in_date_at ;;
  }

  dimension_group: custom_latest_check_out_date {
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
    sql: ${TABLE}.custom_latest_check_out_date_at ;;
  }

  dimension: custom_notes_txt {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_notes_txt ;;
  }

  dimension: custom_some_other_thing_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_some_other_thing_str ;;
  }

  dimension: custom_spammer_bool {
    type: yesno
    hidden: yes
    sql: ${TABLE}.custom_spammer_bool ;;
  }

  dimension: custom_vip_str {
    type: string
    sql: ${TABLE}.custom_vip_str ;;
  }

  dimension: custom_zd_external_id_str {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_zd_external_id_str ;;
  }

  dimension: default_lang {
    type: string
    hidden: yes
    sql: ${TABLE}.default_lang ;;
  }

  dimension: deleted {
    type: yesno
    hidden: yes
    sql: ${TABLE}.deleted ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: deleted_by {
    type: string
    hidden: yes
    sql: ${TABLE}.deleted_by ;;
  }

  dimension: display_name {
    label: "Customer"
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension_group: last_activity {
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
    sql: ${TABLE}.last_activity_at ;;
  }

  dimension: last_conversation_id {
    type: string
    hidden: yes
    sql: ${TABLE}.last_conversation_id ;;
  }

  dimension_group: last_message {
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
    sql: ${TABLE}.last_message_at ;;
  }

  dimension_group: last_message_out_sent {
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
    sql: ${TABLE}.last_message_out_sent_at ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: modified {
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
    sql: ${TABLE}.modified_at ;;
  }

  dimension: modified_by {
    type: string
    hidden: yes
    sql: ${TABLE}.modified_by ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: org_id {
    type: string
    hidden: yes
    sql: ${TABLE}.org_id ;;
  }

  dimension: progressive_status {
    type: string
    hidden: yes
    sql: ${TABLE}.progressive_status ;;
  }

  dimension: sentiment_confidence {
    type: number
    sql: ${TABLE}.sentiment_confidence ;;
  }

  dimension: sentiment_polarity {
    type: number
    sql: ${TABLE}.sentiment_polarity ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  dimension: verified {
    type: yesno
    hidden: yes
    sql: ${TABLE}.verified ;;
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      display_name,
      name,
      company.name,
      company.id,
      conversation.count,
      customer_email.count,
      customer_active_user.count,
      customer_phone.count,
      customer_last_conversation_tag.count,
      customer_external_link.count,
      customer_shared_email.count,
      customer_shared_external_link.count,
      customer_watcher.count,
      customer_shared_phone.count,
      customer_tag.count,
      message.count
    ]
  }
}
