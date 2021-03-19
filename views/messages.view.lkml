view: messages {
  sql_table_name: `bigquery-analytics-272822.mongo.messages`
    ;;
  drill_fields: [meta__airbnbmessageid__st]

  dimension: meta__airbnbmessageid__st {
    primary_key: yes
    type: string
    sql: ${TABLE}.meta.airbnbmessageid__st ;;
    group_label: "Meta Airbnbmessageid"
    group_item_label: "St"
  }

  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
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

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }

  dimension_group: createdat {
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
    sql: ${TABLE}.createdat ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: from__item {
    type: string
    sql: ${TABLE}.`from`.item ;;
    group_label: "From"
    group_item_label: "Item"
  }

  dimension: from__kind {
    type: string
    sql: ${TABLE}.`from`.kind ;;
    group_label: "From"
    group_item_label: "Kind"
  }

  dimension: meta__airbnbmessageid {
    type: number
    value_format_name: id
    sql: ${TABLE}.meta.airbnbmessageid ;;
    group_label: "Meta"
    group_item_label: "Airbnbmessageid"
  }

  dimension: meta__airbnbthreadid {
    type: number
    value_format_name: id
    sql: ${TABLE}.meta.airbnbthreadid ;;
    group_label: "Meta"
    group_item_label: "Airbnbthreadid"
  }

  dimension: meta__airbnbthreadid__st {
    type: string
    sql: ${TABLE}.meta.airbnbthreadid__st ;;
    group_label: "Meta Airbnbthreadid"
    group_item_label: "St"
  }

  dimension: meta__guestyconversationid {
    type: string
    sql: ${TABLE}.meta.guestyconversationid ;;
    group_label: "Meta"
    group_item_label: "Guestyconversationid"
  }

  dimension: meta__kustomerconversationid {
    type: string
    sql: ${TABLE}.meta.kustomerconversationid ;;
    group_label: "Meta"
    group_item_label: "Kustomerconversationid"
  }

  dimension: meta__kustomermessageid {
    type: string
    sql: ${TABLE}.meta.kustomermessageid ;;
    group_label: "Meta"
    group_item_label: "Kustomermessageid"
  }

  dimension: meta__reservationconfirmationcode {
    type: string
    sql: ${TABLE}.meta.reservationconfirmationcode ;;
    group_label: "Meta"
    group_item_label: "Reservationconfirmationcode"
  }

  dimension: meta__reservationid {
    type: string
    sql: ${TABLE}.meta.reservationid ;;
    group_label: "Meta"
    group_item_label: "Reservationid"
  }

  dimension: meta__templateid {
    type: string
    sql: ${TABLE}.meta.templateid ;;
    group_label: "Meta"
    group_item_label: "Templateid"
  }

  dimension: meta__zendeskticketid {
    type: string
    sql: ${TABLE}.meta.zendeskticketid ;;
    group_label: "Meta"
    group_item_label: "Zendeskticketid"
  }

  dimension: meta__zendeskticketid__it {
    type: number
    sql: ${TABLE}.meta.zendeskticketid__it ;;
    group_label: "Meta Zendeskticketid"
    group_item_label: "It"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: to__item {
    type: string
    sql: ${TABLE}.`to`.item ;;
    group_label: "To"
    group_item_label: "Item"
  }

  dimension: to__kind {
    type: string
    sql: ${TABLE}.`to`.kind ;;
    group_label: "To"
    group_item_label: "Kind"
  }

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }

  measure: count {
    type: count
    drill_fields: [meta__airbnbmessageid__st]
  }
}
