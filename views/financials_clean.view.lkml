view: financials_clean {
  label: "Financials"
  derived_table: {
    sql: SELECT financials.*
        FROM financials
          WHERE isvalid is null or isvalid = true
      ;;

    persist_for: "6 hours"

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

    measure: amount {
      view_label: "Metrics"
      label: "Amount"
      description: "Amount per night"
      type: sum
      hidden: yes
      value_format: "$#,##0.00"
      sql: ${amount_revised} ;;
      filters: [actualizedat_modified: "-Nonactualized (Historic)"]
    }

    dimension: types_filtered{
      description: "This will filter out Channel Fees / ToTs"
      hidden: yes
      type: yesno
      sql: ${TABLE}.type is null or ${TABLE}.type not IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability");;
    }

    measure: cleaning_amount {
      type: sum
      group_label: "Cleaning"
      view_label: "Metrics"
      value_format: "$#,##0.00"
      sql: ${amount_revised};;
      filters: [type: "cleaning", actualizedat_modified: "-Nonactualized (Historic)"]
    }

    measure: clean_refund_amount {
      type: sum
      view_label: "Metrics"
      group_label: "Cleaning"
      value_format: "$#,##0.00"
      sql: ${amount_revised};;
      filters: [type: "CleanRefund", actualizedat_modified: "-Nonactualized (Historic)"]
    }


    measure: cleaning_transactions {
      type: count
      view_label: "Metrics"
      group_label: "Cleaning"
      value_format: "0"
      filters: [type: "cleaning", actualizedat_modified: "-Nonactualized (Historic)"]
    }

    measure: cleaning_refund_transactions {
      type: count
      view_label: "Metrics"
      group_label: "Cleaning"
      value_format: "0"
      filters: [type: "CleanRefund", actualizedat_modified: "-Nonactualized (Historic)"]
    }

    # dimension: cashatbooking {
    #   type: yesno
    #   sql: ${TABLE}.cashatbooking ;;
    # }

    # dimension: isvalid {
    #   type: yesno
    #   sql: ${TABLE}.isvalid is null OR ${TABLE}.isvalid = true;;
    # }

    # dimension: casheventual {
    #   type: yesno
    #   sql: ${TABLE}.casheventual ;;
    # }

    dimension_group: night {
      hidden:  yes
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
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.reservation ;;
    }

    dimension_group: transaction {
      view_label: "Date Dimensions"
      group_label: "Transaction Date"
      label: ""
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
      hidden: yes
      sql: ${TABLE}.transactiondate ;;
    }

    dimension: actualizedat {
      type: string
      hidden: yes
      sql: ${TABLE}.actualizedat ;;
    }

    dimension: actualizedat_modified {
      hidden: yes
      label: "Actualized Record"
      description: "This will only pull actualized records for any financial records up to today and nonactualized records for future nights"
      type: string
      sql:
          CASE WHEN (${night_date} >= CURRENT_DATE("America/Los_Angeles")) THEN "Future Booking"
          WHEN (${TABLE}.actualizedat is not null) THEN "Actualized"
          WHEN (${night_date} < "2020-09-01") THEN "Older Booking"
          WHEN (${TABLE}.actualizedat is null and ${TABLE}._id is not null) THEN "Nonactualized (Historic)"
          --WHEN ${TABLE}.actualizedat is null THEN null
          END;;
    }

    dimension: type {
      hidden: yes
      type: string
      sql: ${TABLE}.type ;;
    }

  }
