view: kasa_kredit_reimbursement {
  derived_table: {
    sql: SELECT * FROM `bigquery-analytics-272822.Gsheets.kasa_kredit_reimbursement`
    where Timestamp is not null
      ;;
  }


  dimension_group: form_received {
    type: time
    sql: ${TABLE}.Timestamp ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.Email_Address ;;
  }

  dimension: confirmation_code {
    label: "Confirmation Code"
    type: string
    sql: ${TABLE}.What_is_your_booking_confirmation_code_ ;;
  }

  dimension: feedback_received {
    label: "Feedback Completed?"
    type: yesno
    sql: ${kasa_stay_employee_feedback.reservation_code} is not null ;;
  }

  dimension: booking_amount {
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.What_is_the_total_amount_of_your_booking__including_all_taxes_and_fees_ ;;
  }

  dimension: booking_latest_kasaverary {
    label: "Booking from Latest Kasaversary?"
    type: yesno
    sql: ${reservations_clean.bookingdate_date} >= ${kasa_team_summary.latest_kasaversary} ;;
  }

  dimension: booking_previous_kasaverary {
    label: "Booking from Previous Kasaversary?"
    type: yesno
    sql: ${reservations_clean.bookingdate_date} >= ${kasa_team_summary.previous_kasaversary} AND ${reservations_clean.bookingdate_date} < ${kasa_team_summary.latest_kasaversary}  ;;
  }

  dimension: reimbursement_amount {
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.Amount_to_reimburse ;;
  }

  dimension: processed_date{
    type: date
    datatype: date
    sql: ${TABLE}.Processed ;;
  }

  dimension: processed_notes {
    label: "Notes"
    type: string
    sql: ${TABLE}.Processed_Note ;;
  }

  dimension: new_hire_stay__ {
    label: "New Hire Stay?"
    type: yesno
    sql: ${TABLE}.New_Hire_Stay__ ;;
  }

  dimension: exclude {
    label: "Exclude?"
    type: yesno
    sql: ${TABLE}.Exclude ;;
  }

  measure: booking_amount_sum {
    label: "Total Booking Amount"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.What_is_the_total_amount_of_your_booking__including_all_taxes_and_fees_ ;;
    filters: [exclude: "no", reservations_clean.status: "confirmed, checked_in"]
    drill_fields: [kasa_team_summary.kasa_employee, email_address, confirmation_code, reservations_clean.bookingdate_date, reservations_clean.checkindate_date, reservations_clean.checkoutdate_date, reservations_clean.status, processed_date, booking_amount, reimbursement_amount]
  }

  measure: reimbursement_amount_sum {
    label: "Total Reimbursement Amount"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Amount_to_reimburse ;;
    filters: [exclude: "no", reservations_clean.status: "confirmed, checked_in"]
  }

  measure: booking_amount_latest {
    label: "Total Booking Amount (Latest Kasaversary)"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.What_is_the_total_amount_of_your_booking__including_all_taxes_and_fees_ ;;
    filters: [booking_latest_kasaverary: "yes", new_hire_stay__: "no", exclude: "no", reservations_clean.status: "confirmed, checked_in"]
  }

  measure: remaining_booking_kredit {
    label: "Remaining Booking Credit (Latest Kasaversary)"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN (2000 - ${booking_amount_latest}) < 0 THEN 0
    ELSE 2000 - ${booking_amount_latest}
    END ;;
  }

  measure: booking_amount_previous {
    label: "Total Booking Amount (Previous Kasaversary)"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.What_is_the_total_amount_of_your_booking__including_all_taxes_and_fees_ ;;
    filters: [booking_previous_kasaverary: "yes", new_hire_stay__: "no", exclude: "no", reservations_clean.status: "confirmed, checked_in"]
  }

  measure: remaining_booking_kredit_previous {
    label: "Remaining Booking Kredits (Previous Kasaversary)"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN (2000 - ${booking_amount_previous}) < 0 THEN 0
    ELSE 2000 - ${booking_amount_previous}
    END;;
  }

}
