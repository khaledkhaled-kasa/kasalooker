view: security_deposits_kfc {
  derived_table: {
    sql:

    with reservationriskscores AS (
      SELECT rrs.reservation, trust_riskscoretype, trust_risklevel, party_riskscoretype, party_risklevel
      FROM  mongo.reservationriskscores rrs

      LEFT JOIN

      (SELECT reservation, trust.riskscoretype trust_riskscoretype, trust.risklevel trust_risklevel
      FROM  mongo.reservationriskscores trust
      WHERE riskscoretype = 'trust'
      GROUP BY 1,2,3) trust
      ON rrs.reservation = trust.reservation

      LEFT JOIN

      (SELECT reservation, party.riskscoretype party_riskscoretype, party.risklevel party_risklevel
      FROM  mongo.reservationriskscores party
      WHERE riskscoretype = 'party'
      GROUP BY 1,2,3) party
      ON rrs.reservation = party.reservation
      GROUP BY 1,2,3,4,5)

      SELECT  reservations._id as reservationid,
        reservations.confirmationcode,
        reservations.status as reservation_status,
        reservations.checkindate,
        reservations.checkoutdate,
        securitydeposits.status as security_deposit_status,
        securitydeposits.holdamountcents/100 as deposit_amount,
        CONCAT(guests.firstname," ",guests.lastname) AS guestname,
        securitydeposits.securitydepositversion security_deposit_version,
        guests.email,
        reservationriskscores.trust_risklevel, reservationriskscores.party_risklevel

    FROM mongo.securitydeposits CROSS JOIN UNNEST(reservations) as unique_reservation_id_secdep
    JOIN mongo.reservations ON unique_reservation_id_secdep.value = reservations._id
    LEFT OUTER JOIN mongo.guests ON reservations.guest = guests._id
    LEFT OUTER JOIN reservationriskscores ON reservations._id = reservationriskscores.reservation


 ;;

  }

  dimension: reservationid {
    type: string
    sql: ${TABLE}.reservationid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: reservation_status {
    type: string
    sql: ${TABLE}.reservation_status ;;
  }

  dimension: checkindate {
    label: "Checkin Date"
    type: date
    datatype: timestamp
    sql: SAFE.TIMESTAMP(${TABLE}.checkindate) ;;
  }

  dimension: checkinmonth {
    label: "Checkin Month"
    type: date_month
    datatype: timestamp
    sql: SAFE.TIMESTAMP(${TABLE}.checkindate) ;;
  }

  dimension: checkoutdate {
    label: "Checkout Date"
    type: date
    datatype: timestamp
    sql: SAFE.TIMESTAMP(${TABLE}.checkoutdate) ;;
  }

  dimension: security_deposit_status {
    type: string
    sql: ${TABLE}.security_deposit_status ;;
  }

  dimension: security_deposit_version {
    type: number
    sql: ${TABLE}.security_deposit_version ;;
  }

  dimension: risk_score_type {
    type: string
    sql: ${TABLE}.riskscoretype ;;
  }

  dimension: deposit_amount {
    type: number
    sql: ${TABLE}.deposit_amount ;;
  }

  dimension: guestname {
    type: string
    sql: ${TABLE}.guestname ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: party_risk_level {
    type: string
    sql: ${TABLE}.party_risklevel ;;
  }

  dimension: trust_risk_level {
    type: string
    sql: ${TABLE}.trust_risklevel ;;
  }

  measure: count_success {
    label: "Success Transaction Count"
    description: "Security deposit status holdAuthorized or released"
    type: count_distinct
    sql: ${TABLE}.confirmationcode ;;
    filters: [security_deposit_status: "holdAuthorized, released"]
  }

  measure: count_failure {
    label: "Failed Transaction Count"
    description: "Security deposit status holdFailed"
    type: count_distinct
    sql: ${TABLE}.confirmationcode ;;
    filters: [security_deposit_status: "holdFailed"]
  }

}
