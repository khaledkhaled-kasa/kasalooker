view: tag {
  sql_table_name: `kustomer.tag`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
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

  dimension: color {
    type: string
    hidden: yes
    sql: ${TABLE}.color ;;
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
    hidden: yes
    sql: ${TABLE}.name ;;
  }

  dimension: org_id {
    type: string
    hidden: yes
    sql: ${TABLE}.org_id ;;
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

  # measure: count {
  #   type: count
  #   drill_fields: [id, name, conversation_tag.count, customer_last_conversation_tag.count, customer_tag.count]
  # }
}
