view: message_attachment {
  sql_table_name: `kustomer.message_attachment`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

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

  dimension: content_length {
    type: number
    sql: ${TABLE}.content_length ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
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
    type: string
    sql: ${TABLE}.created_by ;;
  }

  dimension: message_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.message_id ;;
  }

  dimension: modified_by {
    type: string
    sql: ${TABLE}.modified_by ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: org_id {
    type: string
    sql: ${TABLE}.org_id ;;
  }

  dimension: redacted {
    type: yesno
    sql: ${TABLE}.redacted ;;
  }

  dimension: related {
    type: string
    sql: ${TABLE}.related ;;
  }

  dimension: self {
    type: string
    sql: ${TABLE}.self ;;
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

  measure: count {
    type: count
    drill_fields: [id, name, message.first_company_name, message.id]
  }
}
