view: message {
  sql_table_name: `kustomer.message`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: no
    type: string
    sql: ${TABLE}.id ;;
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

  dimension: app {
    type: string
    sql: ${TABLE}.app ;;
  }

  dimension: auto {
    type: yesno
    sql: ${TABLE}.auto ;;
  }

  dimension: message_trip_phase {
    type: string
    description: "This will identify the trip phase based on the time the message was created. Reservations not picked up within range of the customer's conversations would not be assigned a trip phase. The conversation and message trip phase may vary for conversations containing more than one message."
    sql: CASE
          WHEN ${created_date} < ${reservations_kustomer.checkin_date} THEN "Pre-Trip"
          WHEN ${created_date} = ${reservations_kustomer.checkin_date} THEN "Day of Check-in"
          WHEN ${created_date} > ${reservations_kustomer.checkin_date} AND ${created_date} < ${reservations_kustomer.checkout_date} THEN "On-Trip"
          WHEN ${created_date} = ${reservations_kustomer.checkout_date} THEN "Day of Check-out"
          WHEN ${created_date} > ${reservations_kustomer.checkout_date} THEN "Post-Trip"
          ELSE "No Reservation in Range"
          END
          ;;
  }


  dimension: auto_adjusted_logic {
    type: yesno
    hidden: yes
    sql:
    CASE WHEN ${channel} = "voice" and ${direction} IN ("in","out") THEN true
    WHEN (${channel} <> "voice" and ${TABLE}.auto = false and ${direction} = "out") THEN true
    ELSE false
    END;;
  }

  dimension: auto_adjusted {
    label: "Adjusted Messages"
    description: "This will take into account all outbound and non-automated messages and inbound calls (voice channel)"
    type: yesno
    sql: ${auto_adjusted_logic} ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: conversation_id {
    type: string
    hidden: no
    sql: ${TABLE}.conversation_id ;;
  }

  dimension_group: created {
    type: time
    group_label: "Message Created Date"
    label: ""
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      hour_of_day
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: customer_id {
    type: string
    hidden: no
    sql: ${TABLE}.customer_id ;;
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
  }

  dimension: direction_type {
    type: string
    sql: ${TABLE}.direction_type ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension: first_company_id {
    type: string
    hidden: yes
    sql: ${TABLE}.first_company_id ;;
  }

  dimension: first_company_name {
    type: string
    hidden: yes
    sql: ${TABLE}.first_company_name ;;
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

  dimension: org_id {
    type: string
    hidden: yes
    sql: ${TABLE}.org_id ;;
  }

  dimension: preview {
    label: "Message Preview"
    type: string
    sql: ${TABLE}.preview ;;
  }

  dimension: redacted {
    type: yesno
    hidden: yes
    sql: ${TABLE}.redacted ;;
  }

  dimension_group: redacted {
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
    sql: ${TABLE}.redacted_at ;;
  }

  dimension: redacted_by {
    type: string
    hidden: yes
    sql: ${TABLE}.redacted_by ;;
  }

  dimension_group: sent {
    type: time
    label: "Message Sent"
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      hour_of_day,
      quarter,
      year
    ]
    sql: ${TABLE}.sent_at ;;
  }

  dimension: size {
    hidden: yes
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject {
    hidden: yes
    type: string
    sql: ${TABLE}.subject ;;
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

  measure: count {
    type: count_distinct
    label: "Message Count (GX Cost Allocation)"
    description: "This metric is utilized for the GX Cost Allocation in order to deduce the outbound messages sent along with the inbound calls."
    hidden: yes
    sql: ${id} ;;
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_company_name,
      conversation.id,
      conversation.first_company_name,
      conversation.name,
      customer.id,
      customer.first_name,
      customer.last_name,
      customer.display_name,
      customer.name,
      message_assigned_user.count,
      message_attachment.count,
      message_assigned_team.count,
      message_created_by_team.count,
      message_shortcut.count
    ]
  }
}
