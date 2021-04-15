view: disputes_tracker {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.disputes`
      ;;
  }

  dimension: reservation_id {
    type: string
    sql: ${TABLE}.Reservation_ID ;;
  }

  dimension: booking_channel {
    type: string
    sql: ${TABLE}.Booking_Channel ;;
  }

  dimension: name_on_guesty_reservation {
    type: string
    sql: ${TABLE}.Name_on_Guesty_Reservation ;;
  }

  dimension: name_on_cc {
    type: string
    sql: ${TABLE}.Name_on_CC ;;
  }

  dimension: name_mismatch {
    type: string
    sql: ${TABLE}.Name_mismatch ;;
  }

  dimension: property {
    type: string
    sql: CASE WHEN ${TABLE}.Property is NULL THEN ${complexes.title}
    ELSE ${TABLE}.Property
    END;;
  }

  dimension: city {
    type: string
    sql: CASE WHEN ${TABLE}.City is NULL THEN  ${complexes.city}
    ELSE ${TABLE}.City
    END;;
  }

  dimension: bad_actor {
    type: yesno
    sql: ${TABLE}.Bad_Actor ;;
  }

  dimension_group: dispute_created {
    type: time
    timeframes: [
      date,
      time,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.Dispute_Created ;;
    convert_tz: no
  }

  dimension_group: charge_created {
    type: time
    timeframes: [
      date,
      time,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.Charge_Created ;;
    convert_tz: no
  }

  dimension: dispute_amount {
    type: number
    sql: ${TABLE}.Dispute_Amount ;;
  }

  dimension: type_of_cc_used {
    type: string
    sql: ${TABLE}.Type_of_CC_used ;;
  }

  dimension: reason_for_dispute {
    type: string
    sql: ${TABLE}.Reason_for_Dispute ;;
  }

  dimension: dispute_due_to_unsatisfied_guest {
    type: string
    sql: ${TABLE}.Dispute_due_to_unsatisfied_guest ;;
  }

  dimension: dispute_accepted___reason {
    type: string
    sql: ${TABLE}.Dispute_Accepted___Reason ;;
  }

  dimension: gv_completed_issues {
    type: string
    sql: ${TABLE}.GV_Completed_Issues ;;
  }

  dimension: evidence_submitted {
    type: string
    sql: ${TABLE}.Evidence_submitted ;;
  }

  dimension: resolution {
    type: string
    sql: ${TABLE}.Resolution ;;
  }

  dimension: expedia_extenuating_circumstances_ {
    type: string
    sql: ${TABLE}.Expedia_Extenuating_Circumstances_ ;;
  }

  dimension: action_taken {
    type: string
    sql: ${TABLE}.Action_Taken ;;
  }

  measure: dispute_total {
    label: "Disputed Amount"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Dispute_Amount ;;
    drill_fields: [detail*]
  }

  measure: dispute_percent {
    label: "Dispute %"
    type: number
    value_format: "0.00%"
    sql: ${dispute_total} / nullif(${stripe_aggregated_balance.gross_sum},0) ;;
    drill_fields: [detail*]
  }

  measure: dispute_accepted_bad_1 {
    label: "Dispute (Bad Actor)"
    type: sum
    hidden: yes
    value_format: "$#,##0"
    sql: ${TABLE}.Dispute_Amount ;;
    filters: [bad_actor: "yes", resolution: "-null"]
  }

  measure: dispute_accepted_bad_2 {
    label: "Dispute (Accepted Dispute Actor)"
    hidden: yes
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Dispute_Amount ;;
    filters: [resolution: "Accepted dispute"]
  }

  measure: dispute_accepted_bad {
    label: "Dispute $ of Accepted or Bad Actor"
    type: number
    value_format: "$#,##0"
    sql: ${dispute_accepted_bad_1} + ${dispute_accepted_bad_2}  ;;
    drill_fields: [detail*]
  }

  measure: dispute_accepted_bad_percent {
    label: "Dispute % (Net of Accepted / Bad Actor)"
    type: number
    value_format: "0.00%"
    sql: ${dispute_accepted_bad} / nullif(${stripe_aggregated_balance.gross_sum},0) ;;
    drill_fields: [detail*]
  }

  measure: dispute_amount_won {
    label: "Dispute Amount Won"
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Dispute_Amount ;;
    filters: [resolution: "Won"]
    drill_fields: [detail*]
  }

  measure: dispute_won_percent {
    label: "Dispute % (Won)"
    type: number
    value_format: "0.00%"
    sql: ${dispute_amount_won} / nullif(${stripe_aggregated_balance.gross_sum},0) ;;
    drill_fields: [detail*]
  }

  measure: dispute_amount_pending {
    label: "Dispute Amount Pending"
    type: sum
    hidden: no
    value_format: "$#,##0"
    sql: ${TABLE}.Dispute_Amount ;;
    filters: [resolution: "null"]
    drill_fields: [detail*]
  }

  measure: dispute_amount_won_percent {
    label: "Dispute Amount Won % Net of Pending / Bad Actor / Accepted"
    type: number
    value_format: "0.00%"
    sql: ifnull(${dispute_amount_won} / nullif(${dispute_total} - ${dispute_accepted_bad} - ${dispute_amount_pending},0),0) ;;
    drill_fields: [detail*]
    }

  measure: dispute_count {
    label: "Total Disputes"
    type: count
    hidden: no
    drill_fields: [detail*]
  }

  measure: dispute_count_won {
    label: "Total Won Disputes"
    type: count
    hidden: no
    filters: [resolution: "Won"]
    drill_fields: [detail*]
  }

  measure: win_ratio {
    label: "Win Ratio of Total Disputes"
    type: number
    value_format: "0.00%"
    sql: ifnull(${dispute_count_won} / ${dispute_count},0) ;;
    drill_fields: [detail*]
  }

  measure: dispute_bad_1 {
    label: "Dispute (Bad Actor)"
    type: count
    hidden: yes
    filters: [bad_actor: "yes", resolution: "-null"]
  }

  measure: dispute_bad_2 {
    label: "Dispute (Accepted Dispute Actor)"
    type: count
    hidden: yes
    filters: [resolution: "Accepted dispute"]
  }

  measure: dispute_bad_actor {
    label: "Disputes from Bad Actors / Accepted"
    type: number
    sql: ${dispute_bad_1} + ${dispute_bad_2} ;;
    drill_fields: [detail*]
  }

  measure: dispute_pending {
    label: "Disputes Pending"
    type: count
    hidden: no
    filters: [resolution: "null"]
    drill_fields: [detail*]
  }

  measure: win_ratio_count {
    label: "Win Ratio of Disputes Net of Pending / Bad Actor / Accepted"
    type: number
    value_format: "0.00%"
    sql: ifnull(${dispute_count_won} / nullif(${dispute_count} - ${dispute_bad_actor} - ${dispute_pending},0),0) ;;
    drill_fields: [detail*]

  }

  measure: dispute_fraud {
    label: "Fraudulent Dispute Type"
    type: count
    hidden: no
    filters: [reason_for_dispute: "Fraudulent"]
    drill_fields: [detail*]
  }

  measure: chargeback {
    label: "Chargeback due to Unsatisfied Guests"
    type: count
    hidden: no
    filters: [dispute_due_to_unsatisfied_guest: "Yes"]
    drill_fields: [detail*]
  }

  measure: chargeback_percent {
    label: "% of Chargebacks due to Unsatisfied Guests"
    type: number
    value_format: "0.00%"
    sql: ifnull(${chargeback} / ${dispute_count},0) ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      reservation_id, booking_channel, name_on_guesty_reservation,
      name_on_cc, name_mismatch, property, city, bad_actor, charge_created_date,
      charge_created_date, dispute_amount, type_of_cc_used, reason_for_dispute,
      dispute_due_to_unsatisfied_guest, dispute_accepted___reason, gv_completed_issues,
      evidence_submitted, resolution, expedia_extenuating_circumstances_, action_taken
    ]
  }


}
