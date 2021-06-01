view: customers {
  sql_table_name: `kustomer.customers`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: _sdc_batched {
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
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
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
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
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
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension: active_users {
    type: string
    sql: ${TABLE}.active_users ;;
  }

  dimension: conversation_counts {
    hidden: yes
    sql: ${TABLE}.conversation_counts ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: deleted {
    type: string
    sql: ${TABLE}.deleted ;;
  }

  dimension: display_color {
    type: string
    sql: ${TABLE}.display_color ;;
  }

  dimension: display_icon {
    type: string
    sql: ${TABLE}.display_icon ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: emails {
    hidden: no
    sql: ${TABLE}.emails ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: external_ids {
    hidden: yes
    sql: ${TABLE}.external_ids ;;
  }

  dimension: facebook_ids {
    type: string
    sql: ${TABLE}.facebook_ids ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension_group: imported {
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
    sql: ${TABLE}.imported_at ;;
  }

  dimension: instagram_ids {
    type: string
    sql: ${TABLE}.instagram_ids ;;
  }

  dimension_group: last_activity {
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
    sql: ${TABLE}.last_activity_at ;;
  }

  dimension: last_conversation {
    hidden: yes
    sql: ${TABLE}.last_conversation ;;
  }

  dimension: last_customer_activity_at {
    type: string
    sql: ${TABLE}.last_customer_activity_at ;;
  }

  dimension: last_message_at {
    type: string
    sql: ${TABLE}.last_message_at ;;
  }

  dimension: last_message_in {
    hidden: yes
    sql: ${TABLE}.last_message_in ;;
  }

  dimension: last_message_out {
    hidden: yes
    sql: ${TABLE}.last_message_out ;;
  }

  dimension: last_message_unresponded_to {
    hidden: yes
    sql: ${TABLE}.last_message_unresponded_to ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: last_seen_at {
    type: string
    sql: ${TABLE}.last_seen_at ;;
  }

  dimension: links {
    hidden: yes
    sql: ${TABLE}.links ;;
  }

  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: locations {
    type: string
    sql: ${TABLE}.locations ;;
  }

  dimension: modified_at {
    type: string
    sql: ${TABLE}.modified_at ;;
  }

  dimension: modified_by {
    hidden: yes
    sql: ${TABLE}.modified_by ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: org {
    hidden: yes
    sql: ${TABLE}.org ;;
  }

  dimension: phones {
    hidden: yes
    sql: ${TABLE}.phones ;;
  }

  dimension: preview {
    hidden: yes
    sql: ${TABLE}.preview ;;
  }

  dimension: progressive_status {
    type: string
    sql: ${TABLE}.progressive_status ;;
  }

  dimension: recent_items {
    hidden: yes
    sql: ${TABLE}.recent_items ;;
  }

  dimension: recent_location {
    hidden: yes
    sql: ${TABLE}.recent_location ;;
  }

  dimension: rev {
    type: number
    sql: ${TABLE}.rev ;;
  }

  dimension: role_group_versions {
    type: string
    sql: ${TABLE}.role_group_versions ;;
  }

  dimension: satisfaction_level {
    hidden: yes
    sql: ${TABLE}.satisfaction_level ;;
  }

  dimension: sentiment {
    hidden: yes
    sql: ${TABLE}.sentiment ;;
  }

  dimension: shared_emails {
    type: string
    sql: ${TABLE}.shared_emails ;;
  }

  dimension: shared_external_ids {
    type: string
    sql: ${TABLE}.shared_external_ids ;;
  }

  dimension: shared_phones {
    type: string
    sql: ${TABLE}.shared_phones ;;
  }

  dimension: shared_socials {
    type: string
    sql: ${TABLE}.shared_socials ;;
  }

  dimension: smooch_ids {
    type: string
    sql: ${TABLE}.smooch_ids ;;
  }

  dimension: socials {
    type: string
    sql: ${TABLE}.socials ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: updated_at {
    type: string
    sql: ${TABLE}.updated_at ;;
  }

  dimension: urls {
    type: string
    sql: ${TABLE}.urls ;;
  }

  dimension: verified {
    type: yesno
    sql: ${TABLE}.verified ;;
  }

  dimension: watchers {
    type: string
    sql: ${TABLE}.watchers ;;
  }

  dimension: whatsapps {
    type: string
    sql: ${TABLE}.whatsapps ;;
  }

  measure: count {
    type: count
    drill_fields: [id, display_name, name, first_name, last_name]
  }
}

view: customers__last_message_unresponded_to {
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: sent_at {
    type: string
    sql: ${TABLE}.sent_at ;;
  }
}

view: customers__links {
  dimension: self {
    type: string
    sql: ${TABLE}.self ;;
  }
}

view: customers__recent_location {
  dimension: updated_at {
    type: string
    sql: ${TABLE}.updated_at ;;
  }
}

view: customers__satisfaction_level__first_satisfaction__sent_by_teams {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: customers__satisfaction_level__last_satisfaction__sent_by_teams {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: customers__last_message_in {
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: sent_at {
    type: string
    sql: ${TABLE}.sent_at ;;
  }
}

view: customers__created_by {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: customers__external_ids__value {
  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: verified {
    type: yesno
    sql: ${TABLE}.verified ;;
  }
}

view: customers__last_conversation__channels {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: customers__last_conversation {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: channels {
    hidden: yes
    sql: ${TABLE}.channels ;;
  }

  dimension: tags {
    hidden: yes
    sql: ${TABLE}.tags ;;
  }
}

view: customers__last_conversation__tags {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: customers__recent_items__value {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: meta {
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: updated_at {
    type: string
    sql: ${TABLE}.updated_at ;;
  }
}

view: customers__recent_items__value__meta {
  dimension: klass_name {
    type: string
    sql: ${TABLE}.klass_name ;;
  }
}

view: customers__conversation_counts {
  dimension: all {
    type: number
    sql: ${TABLE}.`all` ;;
  }

  dimension: done {
    type: number
    sql: ${TABLE}.done ;;
  }

  dimension: open {
    type: number
    sql: ${TABLE}.open ;;
  }

  dimension: snoozed {
    type: number
    sql: ${TABLE}.snoozed ;;
  }
}

view: customers__preview {
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: preview_at {
    type: string
    sql: ${TABLE}.preview_at ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: customers__sentiment {
  dimension: confidence {
    type: number
    sql: ${TABLE}.confidence ;;
  }

  dimension: polarity {
    type: number
    sql: ${TABLE}.polarity ;;
  }
}

view: customers__phones__value {
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: verified {
    type: yesno
    sql: ${TABLE}.verified ;;
  }
}

view: customers__emails__value {
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: verified {
    type: yesno
    sql: ${TABLE}.verified ;;
  }
}

view: customers__org {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: customers__modified_by {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: customers__last_message_out {
  dimension: sent_at {
    type: string
    sql: ${TABLE}.sent_at ;;
  }
}

view: customers__satisfaction_level__first_satisfaction {
  dimension: sent_by_teams {
    hidden: yes
    sql: ${TABLE}.sent_by_teams ;;
  }
}

view: customers__satisfaction_level__last_satisfaction {
  dimension: sent_by_teams {
    hidden: yes
    sql: ${TABLE}.sent_by_teams ;;
  }
}

view: customers__external_ids {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: customers__recent_items {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: customers__phones {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: customers__emails {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: customers__satisfaction_level {
  dimension: first_satisfaction {
    hidden: yes
    sql: ${TABLE}.first_satisfaction ;;
  }

  dimension: last_satisfaction {
    hidden: yes
    sql: ${TABLE}.last_satisfaction ;;
  }
}
