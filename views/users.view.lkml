view: users {
  sql_table_name: `kustomer.users`
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

  dimension: avatar_url {
    type: string
    sql: ${TABLE}.avatar_url ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: deleted_at {
    type: string
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_signature {
    type: string
    sql: ${TABLE}.email_signature ;;
  }

  dimension: email_verified_at {
    type: string
    sql: ${TABLE}.email_verified_at ;;
  }

  dimension: first_email_verified_at {
    type: string
    sql: ${TABLE}.first_email_verified_at ;;
  }

  dimension: links {
    hidden: yes
    sql: ${TABLE}.links ;;
  }

  dimension: mobile {
    type: string
    sql: ${TABLE}.mobile ;;
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

  dimension: password {
    hidden: yes
    sql: ${TABLE}.password ;;
  }

  dimension: role_groups {
    hidden: yes
    sql: ${TABLE}.role_groups ;;
  }

  dimension: roles {
    hidden: yes
    sql: ${TABLE}.roles ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, display_name, name]
  }
}

view: users__roles {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: users__password {
  dimension: allow_new {
    type: yesno
    sql: ${TABLE}.allow_new ;;
  }

  dimension: force_new {
    type: yesno
    sql: ${TABLE}.force_new ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }
}

view: users__links {
  dimension: self {
    type: string
    sql: ${TABLE}.self ;;
  }
}

view: users__org {
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

view: users__created_by {
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

view: users__role_groups {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: users__modified_by {
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
