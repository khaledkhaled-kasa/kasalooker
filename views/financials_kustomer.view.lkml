view: financials_kustomer {
  derived_table: {
    sql: SELECT financials.*
        FROM financials
          WHERE isvalid is null or isvalid = true
      ;;
  }

  dimension_group: night {
    hidden:  no
    view_label: "Date Dimensions"
    group_label: "Stay Night"
    description: "An occupied night at a Kasa"
    type: time
    timeframes: [
      date,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.night ;;
  }

  dimension: reservation {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.reservation ;;
  }


  dimension: financial_night_part_of_res {
    type:  yesno
    hidden: yes
    sql: CAST(${TABLE}.night as date) < CAST(TIMESTAMP(${reservations_kustomer.checkoutdate}) as date) and
      CAST(${TABLE}.night as date) >= CAST(TIMESTAMP(${reservations_kustomer.checkindate}) as date);;
  }


  measure: num_reservations {
    view_label: "Metrics"
    label: "Num Reservations (Kustomer)"
    description: "Number of unique reservations (Kustomer)"
    type: count_distinct
    sql: ${reservations_kustomer.confirmationcode} ;;
    filters: [financial_night_part_of_res: "yes", reservations_kustomer.status: "confirmed, checked_in"]
  }



}
