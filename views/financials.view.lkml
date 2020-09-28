view: financials {
  sql_table_name: `bigquery-analytics-272822.mongo.financials`
    ;;

# This will calculate amount but doesn't adjust for duplicated rows
  #27-09
#   measure: amount_aggregated {
#     view_label: "Metrics"
#     label: "Amount Aggregated"
#     description: "Total financial amount (duplicated rows)"
#     hidden: no
#     type: sum
#     value_format: "$#,##0.00"
#     sql: ${amount_revised} ;;
#     filters: [reservations.status: "-inquiry, -canceled, -declined"]
#   }
#   measure: amount {
#     view_label: "Metrics"
#     label: "Amount"
#     description: "Adjusting Amount for nights"
#     type: number
#     value_format: "$#,##0.00"
#     sql: CASE WHEN ${reservations.reservation_night} = 0 THEN
#     ${amount_aggregated} / NULLIF(${reservations.reservation_night_old}, 0)
#     ELSE ${amount_aggregated} / NULLIF(${reservations.reservation_night}, 0)
#     END ;;
#   }


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


  measure: amount {
    view_label: "Metrics"
    label: "Amount"
    description: "Adjusting Amount for nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations.status: "-inquiry, -canceled, -declined"]
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
    sql: ${amount} / NULLIF(${reservations.reservation_night}, 0) ;;
  }


  measure: revpar {
    view_label: "Metrics"
    label: "RevPar"
    description: "Revenue per available room: amount / capacity"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${capacities_rolled.capacity_measure}, 0) ;;
  }

  dimension: cashatbooking {
    type: yesno
    sql: ${TABLE}.cashatbooking ;;
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
