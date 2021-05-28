# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: codejobs {
  hidden: yes

  join: codejobs__params__keyids {
    view_label: "Codejobs: Params Keyids"
    sql: LEFT JOIN UNNEST(${codejobs.params__keyids}) as codejobs__params__keyids ;;
    relationship: one_to_many
  }

  join: codejobs__params__additionalinfo {
    view_label: "Codejobs: Params Additionalinfo"
    sql: LEFT JOIN UNNEST(${codejobs.params__additionalinfo}) as codejobs__params__additionalinfo ;;
    relationship: one_to_many
  }
}

view: codejobs {
  sql_table_name: `bigquery-analytics-272822.mongo.codejobs`
    ;;

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

  dimension_group: _sdc_deleted {
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
    sql: ${TABLE}._sdc_deleted_at ;;
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

  dimension: accessid {
    type: string
    sql: ${TABLE}.accessid ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: checksuccessful {
    type: yesno
    sql: ${TABLE}.checksuccessful ;;
  }

  dimension: codeservice {
    type: string
    sql: ${TABLE}.codeservice ;;
  }

  dimension: completedat {
    type: string
    sql: ${TABLE}.completedat ;;
  }

  dimension: notbefore {
    type: string
    sql: ${TABLE}.notbefore ;;
  }

  dimension: params__accessid {
    type: string
    sql: ${TABLE}.params.accessid ;;
    group_label: "Params"
    group_item_label: "Accessid"
  }

  dimension: params__action {
    type: string
    sql: ${TABLE}.params.action ;;
    group_label: "Params"
    group_item_label: "Action"
  }

  dimension: params__additionalinfo {
    hidden: yes
    sql: ${TABLE}.params.additionalinfo ;;
    group_label: "Params"
    group_item_label: "Additionalinfo"
  }

  dimension: params__code {
    type: string
    sql: ${TABLE}.params.code ;;
    group_label: "Params"
    group_item_label: "Code"
  }

  dimension: params__codeid {
    type: number
    value_format_name: id
    sql: ${TABLE}.params.codeid ;;
    group_label: "Params"
    group_item_label: "Codeid"
  }

  dimension: params__codeid__st {
    type: string
    sql: ${TABLE}.params.codeid__st ;;
    group_label: "Params Codeid"
    group_item_label: "St"
  }

  dimension: params__email {
    type: string
    sql: ${TABLE}.params.email ;;
    group_label: "Params"
    group_item_label: "Email"
  }

  dimension: params__endtime {
    type: string
    sql: ${TABLE}.params.endtime ;;
    group_label: "Params"
    group_item_label: "Endtime"
  }

  dimension: params__firstname {
    type: string
    sql: ${TABLE}.params.firstname ;;
    group_label: "Params"
    group_item_label: "Firstname"
  }

  dimension: params__houseid {
    type: number
    value_format_name: id
    sql: ${TABLE}.params.houseid ;;
    group_label: "Params"
    group_item_label: "Houseid"
  }

  dimension: params__houseid__st {
    type: string
    sql: ${TABLE}.params.houseid__st ;;
    group_label: "Params Houseid"
    group_item_label: "St"
  }

  dimension: params__keycafeaccessid {
    type: string
    sql: ${TABLE}.params.keycafeaccessid ;;
    group_label: "Params"
    group_item_label: "Keycafeaccessid"
  }

  dimension: params__keycafeid {
    type: string
    sql: ${TABLE}.params.keycafeid ;;
    group_label: "Params"
    group_item_label: "Keycafeid"
  }

  dimension: params__keyids {
    hidden: yes
    sql: ${TABLE}.params.keyids ;;
    group_label: "Params"
    group_item_label: "Keyids"
  }

  dimension: params__lastname {
    type: string
    sql: ${TABLE}.params.lastname ;;
    group_label: "Params"
    group_item_label: "Lastname"
  }

  dimension: params__lockid {
    type: string
    sql: ${TABLE}.params.lockid ;;
    group_label: "Params"
    group_item_label: "Lockid"
  }

  dimension: params__nexiaaccountname {
    type: string
    sql: ${TABLE}.params.nexiaaccountname ;;
    group_label: "Params"
    group_item_label: "Nexiaaccountname"
  }

  dimension: params__nexiaid {
    type: number
    value_format_name: id
    sql: ${TABLE}.params.nexiaid ;;
    group_label: "Params"
    group_item_label: "Nexiaid"
  }

  dimension: params__nexiaid__st {
    type: string
    sql: ${TABLE}.params.nexiaid__st ;;
    group_label: "Params Nexiaid"
    group_item_label: "St"
  }

  dimension: params__parentaction {
    type: string
    sql: ${TABLE}.params.parentaction ;;
    group_label: "Params"
    group_item_label: "Parentaction"
  }

  dimension: params__parentjob {
    type: string
    sql: ${TABLE}.params.parentjob ;;
    group_label: "Params"
    group_item_label: "Parentjob"
  }

  dimension: params__phonenumber {
    type: string
    sql: ${TABLE}.params.phonenumber ;;
    group_label: "Params"
    group_item_label: "Phonenumber"
  }

  dimension: params__sendsalert {
    type: yesno
    sql: ${TABLE}.params.sendsalert ;;
    group_label: "Params"
    group_item_label: "Sendsalert"
  }

  dimension: params__slot {
    type: number
    sql: ${TABLE}.params.slot ;;
    group_label: "Params"
    group_item_label: "Slot"
  }

  dimension: params__slot__st {
    type: string
    sql: ${TABLE}.params.slot__st ;;
    group_label: "Params Slot"
    group_item_label: "St"
  }

  dimension: params__smartthingsaccountname {
    type: string
    sql: ${TABLE}.params.smartthingsaccountname ;;
    group_label: "Params"
    group_item_label: "Smartthingsaccountname"
  }

  dimension: params__smartthingslockname {
    type: string
    sql: ${TABLE}.params.smartthingslockname ;;
    group_label: "Params"
    group_item_label: "Smartthingslockname"
  }

  dimension: params__starttime {
    type: string
    sql: ${TABLE}.params.starttime ;;
    group_label: "Params"
    group_item_label: "Starttime"
  }

  dimension: params__token {
    type: string
    sql: ${TABLE}.params.token ;;
    group_label: "Params"
    group_item_label: "Token"
  }

  dimension: params__unitid {
    type: string
    sql: ${TABLE}.params.unitid ;;
    group_label: "Params"
    group_item_label: "Unitid"
  }

  dimension: previouserror {
    type: string
    sql: ${TABLE}.previouserror ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}.priority ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: sqsmessageid {
    type: string
    sql: ${TABLE}.sqsmessageid ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [params__lastname, params__firstname, params__nexiaaccountname, params__smartthingslockname, params__smartthingsaccountname]
  }
}

view: codejobs__params__keyids {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: codejobs__params__additionalinfo {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}
