view: trs_prs {
  derived_table: {
    sql: select
      reservations.status,
      reservations.confirmationcode,
      reservations._id,
      reservations.checkindate, reservations.checkoutdate,
      complexes.title, complexes.internaltitle, units.internaltitle as internaltitleUnit , units.address.city, units.address.state,
      -- infinitystones.partyrisk.*,
      -- infinitystones.trustrisk.*,
      infinitystones.riskstatus,
      -- rrs_party.reservation, rrs_party._id rrs_party_id
      rrs_party.risklevel party_risk_level, rrs_party.riskscoretype risktype_party, rrs_party.rawscore party_rawscore,
      -- rrs_trust.reservation, rrs_trust._id rrs_trust_id
      rrs_trust.risklevel trust_risk_level, rrs_trust.riskscoretype risktype_trust, rrs_trust.rawscore trust_rawscore,
      CASE
      WHEN rrs_party.risklevel = 'low' AND rrs_party.rawscore >= 1.8 THEN 1
      WHEN rrs_party.risklevel = 'medium' AND rrs_party.rawscore >= 3.3 THEN 1
      WHEN rrs_party.risklevel = 'high' AND rrs_party.rawscore >= 5.4 THEN 1
      ELSE NULL
      END partyviolation,
      CASE
      WHEN rrs_trust.risklevel = 'low' AND rrs_trust.rawscore >= 1.1 THEN 1
      WHEN rrs_trust.risklevel = 'medium' AND rrs_trust.rawscore >= 1.9 THEN 1
      WHEN rrs_trust.risklevel = 'high' AND rrs_trust.rawscore >= 4.9 THEN 1
      ELSE NULL
      END trustviolation,
      units._id as unitId
      from reservations
      left join units on reservations.unit = units._id
      left join complexes on units.complex = complexes._id
      left join reservationriskscores rrs_party on (reservations._id = rrs_party.reservation and reservations.infinitystones.partyrisk.reservationriskscore = rrs_party._id)
      left join reservationriskscores rrs_trust on (reservations._id = rrs_trust.reservation and infinitystones.trustrisk.reservationriskscore = rrs_trust._id)
       ;;
  }

  dimension: status {
    view_label: "Reservations"
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: res_id {
    view_label: "Reservations ID"
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }
  dimension: unitId {
    type: string
    hidden: yes
    sql: ${TABLE}.unitId ;;
  }
  dimension: risk_status {
    view_label: "TRS/PRS"
    type: string
    sql: ${TABLE}.riskstatus ;;
  }

  dimension: confirmationcode {
    view_label: "Reservations"
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension_group: checkindate {
    view_label: "Reservations"
    type: time
    label: "Checkin"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: TIMESTAMP(${TABLE}.checkindate);;
  }


  dimension_group: checkoutdate {
    view_label: "Reservations"
    type: time
    label: "Checkout"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.checkoutdate as TIMESTAMP);;
  }


  dimension: title {
    view_label: "Building & Geographic Information"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: building_internal_title {
    view_label: "Building & Geographic Information"
    label: "Property Code"
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: unit {
    view_label: "Unit"
    type: string
    sql: ${TABLE}.internaltitleUnit ;;
  }

  dimension: city {
    view_label: "Building & Geographic Information"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    view_label: "Building & Geographic Information"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: party_risk_level {
    view_label: "TRS/PRS"
    type: string
    sql: ${TABLE}.party_risk_level ;;
  }


  dimension: party_rawscore {
    view_label: "TRS/PRS"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.party_rawscore ;;
  }

  dimension: trust_risk_level {
    view_label: "TRS/PRS"
    type: string
    sql: ${TABLE}.trust_risk_level ;;
  }


  dimension: trust_rawscore {
    view_label: "TRS/PRS"
    type: number
    value_format: "0.00"
    sql: ${TABLE}.trust_rawscore ;;
  }

  dimension: partyviolation {
    view_label: "TRS/PRS"
    label: "Party Violation"
    description: "Thresholds -  Low:1.8 | medium:3.3 | high:5.4"
    hidden: no
    type: yesno
    sql: ${TABLE}.partyviolation = 1 ;;
  }

  dimension: trustviolation {
    label: "Trust Violation"
    description: "Thresholds -  Low:1.1 | medium:1.9 | high:4.9"
    view_label: "TRS/PRS"
    hidden: no
    type: yesno
    sql: ${TABLE}.trustviolation = 1 ;;
  }

  dimension: violation_type {
    view_label: "TRS/PRS"
    hidden: no
    type: string
    sql: CASE
    WHEN ${TABLE}.trustviolation = 1 AND ${TABLE}.partyviolation = 1 THEN "TRS & PRS Violation"
    WHEN ${TABLE}.trustviolation = 1 THEN "TRS Violation"
    WHEN ${TABLE}.partyviolation = 1 THEN "PRS Violation"
    ELSE NULL
    END;;
  }

  measure: num_reservations_trs_prs {
    label: "Number of Unauthorized Bookings (TRS/PRS/Both)"
    view_label: "Reservations"
    description: "Number of unique reservations which have been cancelled due to a TRS,PRS or TRS+PRS threshold violation (flagged for cancelQueue)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "cancelled, canceled", risk_status: "cancelQueue, canceled", violation_type: "TRS & PRS Violation, TRS Violation, PRS Violation"]
    drill_fields: [confirmationcode, checkindate_date, checkoutdate_date, title, city, state, party_risk_level, party_rawscore, trust_risk_level, trust_rawscore, partyviolation, trustviolation]
  }

  measure: num_reservations_trs {
    label: "Number of Unauthorized Bookings (TRS/Both)"
    view_label: "Reservations"
    description: "Number of unique reservations which have been cancelled due to a TRS or TRS+PRS threshold violation (flagged for cancelQueue)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "cancelled, canceled", risk_status: "cancelQueue, canceled", violation_type: "TRS & PRS Violation, TRS Violation"]
    drill_fields: [confirmationcode, checkindate_date, checkoutdate_date, title, city, state, party_risk_level, party_rawscore, trust_risk_level, trust_rawscore, partyviolation, trustviolation]
  }

  measure: num_reservations_prs {
    label: "Number of Unauthorized Bookings (PRS/Both)"
    view_label: "Reservations"
    description: "Number of unique reservations which have been cancelled due to a PRS or PRS+TRS threshold violation (flagged for cancelQueue)"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "cancelled, canceled", risk_status: "cancelQueue, canceled", violation_type: "TRS & PRS Violation, PRS Violation"]
    drill_fields: [confirmationcode, checkindate_date, checkoutdate_date, title, city, state, party_risk_level, party_rawscore, trust_risk_level, trust_rawscore, partyviolation, trustviolation]
  }

  measure: num_reservations_confirmed {
    label: "Number of Confirmed Bookings"
    view_label: "Reservations"
    description: "Number of unique reservations which are confirmed/ checked_in"
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [status: "confirmed, checked_in"]
    drill_fields: [confirmationcode, checkindate_date, checkoutdate_date, title, city, state]
  }

    measure: percent_prs {
      label: "% of Unauthorized due to PRS/Both"
      view_label: "Reservations"
      description: "% of unique reservations from total confirmed bookings which have been cancelled due to either PRS or PRS+TRS violation (flagged for cancelQueue)"
      type: number
      value_format: "0.00%"
      sql: ${num_reservations_prs} / ${num_reservations_confirmed};;
    }

  measure: percent_trs {
    label: "% of Unauthorized due to TRS/Both"
    view_label: "Reservations"
    description: "% of unique reservations from total confirmed bookings which have been cancelled due to either TRS or PRS+TRS violation (flagged for cancelQueue)"
    type: number
    value_format: "0.00%"
    sql: ${num_reservations_trs} / ${num_reservations_confirmed} ;;
  }

  measure: percent_both {
    label: "% of Unauthorized due to TRS/PRS/Both"
    view_label: "Reservations"
    description: "% of unique reservations from total confirmed bookings which have been cancelled due to either PRS /TRS or PRS+TRS violation (flagged for cancelQueue)"
    type: number
    value_format: "0.00%"
    sql: ${num_reservations_trs_prs} / ${num_reservations_confirmed} ;;
  }
  measure: num_reservations_high_PRS{
    type: count_distinct
    label: "PRS High"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [party_risk_level: "high",status: "confirmed, checked_in"]
  }
  measure: num_reservations_low_PRS{
    type: count_distinct
    label: "PRS Low"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [party_risk_level: "low",status: "confirmed, checked_in"]
  }
  measure: num_reservations_medium_PRS{
    type: count_distinct
    label: "PRS Medium"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [party_risk_level: "medium",status: "confirmed, checked_in"]
  }

  measure: num_reservations_high_TRS{
    type: count_distinct
    label: "TRS High"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [trust_risk_level: "high",status: "confirmed, checked_in"]
  }
  measure: num_reservations_low_TRS{
    type: count_distinct
    label: "TRS Low"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [trust_risk_level: "low",status: "confirmed, checked_in"]
  }
  measure: num_reservations_medium_TRS{
    type: count_distinct
    label: "TRS Medium"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [trust_risk_level: "medium",status: "confirmed, checked_in"]
  }
  measure: num_reservations_nibe_TRS{
    type: count_distinct
    label: "TRS None"
    view_label: "TRS/PRS"
    sql:${confirmationcode};;
    filters: [trust_risk_level: "none",status: "confirmed, checked_in"]
  }


}
