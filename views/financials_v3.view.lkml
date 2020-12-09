view: financials_v3{
  label: "Financials"
  derived_table: {
    sql: SELECT financials.*, t2.outstanding_amount / t3.count_nights_room_revenue as nightly_outstanding_amount
        FROM financials
        LEFT JOIN

        (SELECT confirmationcode, reservation_id, 'roomRevenue' as Type, outstanding_amount
        FROM
          (SELECT reservations.confirmationcode as confirmationcode, financials.reservation as reservation_id,
          (COALESCE(sum(amount),0) + COALESCE(sum(amount__fl),0)) as outstanding_amount
          FROM financials JOIN reservations
          ON financials.reservation = reservations._id
          WHERE (CAST(financials.night AS DATE) < CAST(reservations.checkindatelocal AS DATE) OR CAST(financials.night AS DATE) >= CAST(reservations.checkoutdatelocal AS DATE))
          AND financials.type NOT IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability")
          AND (isvalid is null or isvalid = true)
          GROUP BY 1,2)t1)t2

        ON financials.reservation = t2.reservation_id
        AND financials.type = t2.type

        JOIN

        (SELECT financials.reservation as reservationid, count(*) as count_nights_room_revenue
        FROM financials JOIN reservations
        ON financials.reservation = reservations._id
        AND financials.type = 'roomRevenue'
        AND (CAST(financials.night AS DATE) >= CAST(reservations.checkindatelocal AS DATE) AND CAST(financials.night AS DATE) < CAST(reservations.checkoutdatelocal AS DATE))
        GROUP BY 1)t3
        ON financials.reservation = t3.reservationid
        where financials.isvalid is null or financials.isvalid = true
      ;;
  }


  dimension: amount_revised {
    hidden: yes
    view_label: "Metrics"
    label: "Amount Revised"
    description: "This will correct for unavailable amount__fl values"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN ${TABLE}.amount__fl IS NULL THEN ${TABLE}.amount
          ELSE ${TABLE}.amount__fl
          END;;
  }


  measure: amount_original {
    view_label: "Metrics"
    label: "Original Amount"
    hidden: yes
    description: "This is amount as per payment received dates"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [financials_v3.isvalid: "yes", reservations_v3.financial_night_part_of_res: "Yes", reservations_v3.status: "confirmed, checked_in"]
  }


  measure: amount_outstanding {
    view_label: "Metrics"
    hidden: yes
    label: "Amount Outstanding"
    description: "This is the amount missing from previous scheduled nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [financials_v3.isvalid: "yes", reservations_v3.financial_night_part_of_res: "yes", reservations_v3.status: "confirmed, checked_in"]
  }

  measure: amount {
    view_label: "Metrics"
    label: "Amount"
    description: "This amount has been adjusted to consider payments from previously scheduled nights"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount_original} + ${amount_outstanding};;
  }


  measure: cleaning_amount {
    type: number
    value_format: "$#,##0.00"
    sql: sum(if(${TABLE}.type = "cleaning",${amount_revised},0)) ;;
  }

  measure: clean_refund_amount {
    type: number
    value_format: "$#,##0.00"
    sql: sum(if(${TABLE}.type = "CleanRefund",${amount_revised},0)) ;;
  }

  measure: cleaning_transactions {
    type: count
    value_format: "0"
    filters: [
      type: "cleaning"
    ]
  }

  measure: cleaning_refund_transactions {
    type: count
    value_format: "0"
    filters: [
      type: "CleanRefund"
    ]
  }

  measure: adr {
    view_label: "Metrics"
    label: "ADR"
    description: "Average daily rate: amount / reservation_night"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
  }

  measure: revenue_per_booked_room {
    view_label: "Metrics"
    label: "Revenue per Booked Room"
    description: "Average daily rate: amount / reservation_night"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
  }


  measure: revpar {
    view_label: "Metrics"
    label: "RevPar"
    description: "Revenue per available room: amount / capacity"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${capacities_v3.capacity}, 0) ;;
  }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
  }

  dimension: isvalid {
    type: yesno
    hidden: yes
    sql: ${TABLE}.isvalid is null OR ${TABLE}.isvalid = true;;
  }

  dimension: casheventual {
    type: yesno
    sql: ${TABLE}.casheventual ;;
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


  dimension: weekend {
    view_label: "Date Dimensions"
    type:  yesno
    sql:  ${night_day_of_week} in ('Friday', 'Saturday') ;;
  }

  dimension: reservation {
    type: string
    primary_key: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension_group: transaction {
    view_label: "Date Dimensions"
    group_label: "Transaction Date"
    description: "Date of a given financial transaction"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week
    ]
    sql: cast(${TABLE}.transactiondate as TIMESTAMP);;
  }

  dimension: transactiondate {
    type: string
    sql: ${TABLE}.transactiondate ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: types_filtered{
    description: "This will filter out Channel Fees / ToTs"
    type: yesno
    sql: ${TABLE}.type is null or ${TABLE}.type not IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability");;
  }


}
