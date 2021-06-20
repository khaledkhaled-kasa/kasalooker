view: codejobs_v2 {
  derived_table: {
    sql: SELECT
      cj.accessid,
      cj.codeservice,
      cj.action,
      cj.status,
      cj.completedat,
      cj._id,
      cj.params.code as code,
      cj.params.unitid as unitid,
      a.confirmationcode
      FROM codejobs cj
      left JOIN accesses a
      on cj.accessid=a._id
      WHERE cj.status <> "canceled" and cj.status is not null
       ;;
  }

  dimension: _id {
    type: string
    primary_key: yes
    sql: ${TABLE}._id ;;
  }

  dimension: accessid {
    type: string
    sql: ${TABLE}.accessid ;;
  }



  dimension: codeservice {
    type: string
    sql: ${TABLE}.codeservice ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: completedat {
    type: string
    sql: ${TABLE}.completedat ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: confirmationcode {
    type: string
    hidden: yes
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: unitid {
    type: string
    sql: ${TABLE}.unitid ;;
  }

  measure: total_codes{
    type: count_distinct
    sql: ${_id} ;;
  }

  # measure: total_res{
  #   type: count_distinct
  #   sql: ${confirmationcode} ;;
  # }

  measure: total_setCodeJobs{
    label: "Total SetCodeJobs"
    description: "Total Num of Succeeded and Faild SetCodesJobs"
    type: count_distinct
    sql: CASE WHEN ${action}="setCode"  and
    (${status}="failed" or ${status}="succeeded") Then
    ${_id} ELSE NULL END;;
    drill_fields: [detail*]
  }

  measure: number_ofReservations_setCodeJobs_nexia {
    label: "Num Of Resrevations From SetCodJobs (Nexia)"
    description: "Num Of Resrevations From SetCodJobs"
    type: count_distinct
    sql: ${confirmationcode};;
    filters: [action: "setCode",codeservice: "nexia"]
    drill_fields: [confirmationcode,codeservice,action,accessid]
  }

  measure: number_ofReservations_from_succeeded_setCodeJobs_nexia {
    label: "Num Of Resrevations From Succeeded SetCodJobs (Nexia)"
    description: "Num Of Resrevations From Succeeded SetCodJobs "
    type: count_distinct
    sql: ${confirmationcode};;
    filters: [action: "setCode",status: "succeeded",codeservice: "nexia"]
    drill_fields: [confirmationcode,codeservice,action,accessid]
  }

  measure: number_ofReservations_checkCode_st {
    label: "Num Of Resrevations From CheckCode (ST)"
    description: "Num Of Resrevations From CheckCode"
    type: count_distinct
    sql: ${confirmationcode};;
    filters: [action: "checkCode",codeservice:"smartthings"]
    drill_fields: [confirmationcode,codeservice,action,accessid]
  }

  measure: number_ofReservations_from_succeeded_cehckCode_st {
    label: "Num Of Resrevations From Succeeded CheckCode (ST)"
    description: "Num Of Resrevations From Succeeded CheckCode "
    type: count_distinct
    sql: ${confirmationcode};;
    filters: [action: "checkCode",status: "succeeded",codeservice: "smartthings"]
    drill_fields: [confirmationcode,codeservice,action,accessid]
  }


  set: detail {
    fields: [
      accessid,
      confirmationcode,
      codeservice,
      action,
      status,
      completedat,
      _id,
      code,
      unitid
    ]
  }
}
