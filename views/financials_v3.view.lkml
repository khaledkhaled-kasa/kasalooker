view: financials_v3{
  label: "Financials"
  derived_table: {
    sql: SELECT financials.*, DATE(financials.night) as partition_date,
        CASE WHEN CAST(financials.night as date) < '2021-01-01' THEN (t2.outstanding_amount / t3.count_nights_room_revenue)
        ELSE null
        END nightly_outstanding_amount
        FROM financials
        LEFT JOIN

        (SELECT confirmationcode, reservation_id, 'roomRevenue' as Type, outstanding_amount
        FROM
          (SELECT reservations.confirmationcode as confirmationcode, financials.reservation as reservation_id,
          (COALESCE(sum(amount),0) + COALESCE(sum(amount__fl),0)) as outstanding_amount
          FROM financials JOIN reservations
          ON financials.reservation = reservations._id
          WHERE (CAST(financials.night AS DATE) < CAST(timestamp(reservations.checkindate) AS DATE) OR CAST(financials.night AS DATE) >= CAST(timestamp(reservations.checkoutdate) AS DATE))
          AND financials.type NOT IN ("channelFee","ToT","ToTInflow","ToTOutflowNonLiability","ToTInflowNonLiability")
          AND (isvalid is null or isvalid = true)
          GROUP BY 1,2)t1)t2

        ON financials.reservation = t2.reservation_id
        AND financials.type = t2.type

        LEFT JOIN

        (SELECT financials.reservation as reservationid, count(*) as count_nights_room_revenue
        FROM financials JOIN reservations
        ON financials.reservation = reservations._id
        AND financials.type = 'roomRevenue'
        AND (CAST(financials.night AS DATE) >= CAST(timestamp(reservations.checkindate) AS DATE) AND CAST(financials.night AS DATE) < CAST(timestamp(reservations.checkoutdate) AS DATE))
        GROUP BY 1)t3
        ON financials.reservation = t3.reservationid
        where financials.isvalid is null or financials.isvalid = true
      ;;


    # persist_for: "1 hour"
    datagroup_trigger: kasametrics_reservations_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
    partition_keys: ["partition_date"]
  }


  dimension: _id {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}._id ;;
  }

  dimension: amount_revised {
    hidden: yes
    label: "Amount Revised"
    description: "This will correct for unavailable amount__fl values"
    type: number
    value_format: "$#,##0.00"
    sql: CASE WHEN ${TABLE}.amount__fl IS NULL THEN ${TABLE}.amount
          ELSE ${TABLE}.amount__fl
          END;;
  }

  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
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
    hidden: yes
    sql: ${TABLE}.casheventual ;;
  }

  dimension_group: night {
    hidden:  yes
    group_label: "Financial Night"
    description: "An occupied night at a Kasa"
    label: "Financial"
    type: time
    timeframes: [
      date,
      week_of_year,
      week,
      month,
      day_of_week
    ]
    sql: ${TABLE}.night ;;
    convert_tz: no
  }


  dimension: reservation {
    hidden: yes
    type: string
    # primary_key: yes
    sql: ${TABLE}.reservation ;;
  }

  dimension_group: transaction {
    description: "Date of a given financial transaction"
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week
    ]
    convert_tz: no
    sql: cast(${TABLE}.transactiondate as TIMESTAMP);;
  }


  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }


  dimension: actualizedat {
    type: string
    hidden: yes
    sql: ${TABLE}.actualizedat ;;
  }

  dimension: actualizedat_modified {
    label: "Actualized Record"
    description: "This will only pull actualized records for any financial records up to today and nonactualized records for future nights"
    type: string
    sql:
    CASE WHEN (${night_date} >= CURRENT_DATE("America/Los_Angeles")) THEN "Future Booking"
    WHEN (${TABLE}.actualizedat is not null) THEN "Actualized"
    WHEN (${night_date} < "2020-09-01") THEN "Older Booking"
    WHEN (${TABLE}.actualizedat is null and ${TABLE}._id is not null) THEN "Nonactualized (Historic)"
    END;;
  }

  measure: amount_original {
    label: "Original Amount"
    hidden: yes
    description: "This is amount as per payment received dates"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability"]
  }

  measure: amount_original_direct {
    label: "Original Amount (Direct)"
    hidden: yes
    description: "This is amount as per payment received dates from direct, kasawebsite & website booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "direct, kasawebsite, website, guestportal"]
  }

  measure: amount_original_gx {
    label: "Original Amount (GX)"
    hidden: yes
    description: "This is amount as per payment received dates from direct booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "direct"]
  }

  measure: amount_original_website {
    label: "Original Amount (Website)"
    hidden: yes
    description: "This is amount as per payment received dates from kasawebsite & website booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "kasawebsite, website"]
  }

  measure: amount_original_guestportal {
    label: "Original Amount (Guest Portal)"
    hidden: yes
    description: "This is amount as per payment received dates from guest portal channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "guestportal"]
  }

  measure: amount_original_unfiltered {
    view_label: "Metrics"
    label: "Original Amount"
    hidden: yes
    description: "This is amount as per payment received dates"
    type: sum
    value_format: "$#,##0.00"
    sql: ${amount_revised} ;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)"]
  }


  measure: amount_outstanding {
    hidden: yes
    label: "Amount Outstanding"
    description: "This is the amount missing from previous scheduled nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability"]
  }

  measure: amount_outstanding_direct {
    hidden: yes
    label: "Amount Outstanding (Direct)"
    description: "This is the amount missing from previous scheduled nights from direct, kasawebsite & website booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "direct, kasawebsite, website, guestportal"]
  }

  measure: amount_outstanding_gx {
    hidden: yes
    label: "Amount Outstanding (GX)"
    description: "This is the amount missing from previous scheduled nights from direct booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "direct"]
  }

  measure: amount_outstanding_website {
    hidden: yes
    label: "Amount Outstanding (Website)"
    description: "This is the amount missing from previous scheduled nights from kasawebsite & website booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "kasawebsite, website"]
  }

  measure: amount_outstanding_guestportal {
    hidden: yes
    label: "Amount Outstanding (Guest Portal)"
    description: "This is the amount missing from previous scheduled nights from guest portal booking channels"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)",reservations_v3.status: "confirmed, checked_in", type: "-channelFee,-ToT,-ToTInflow,-ToTOutflowNonLiability,-ToTInflowNonLiability", reservations_v3.sourcedetail: "guestportal"]
  }

  measure: amount_outstanding_unfiltered {
    hidden: yes
    label: "Amount Outstanding"
    description: "This is the amount missing from previous scheduled nights"
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.nightly_outstanding_amount;;
    filters: [reservations_v3.financial_night_part_of_res_modified: "yes",actualizedat_modified: "-Nonactualized (Historic)"]
  }

  measure: amount {
    label: "Amount"
    description: "This amount will automatically filter for only confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount_original} + ${amount_outstanding};;
    drill_fields: [reservations_v3.confirmationcode, reservations_v3.bookingdate_date, reservations_v3.checkindate_date, reservations_v3.checkoutdate_date, reservations_v3.status, reservations_v3.reservation_night, reservations_v3.num_reservations, amount]
  }


  measure: direct_share {
    label: "Total Direct Revenue Share"
    description: "This will collect % revenue share from direct, kasawebsite & website booking channels"
    type: number
    value_format: "0.0%"
    sql: (${amount_original_direct} + ${amount_outstanding_direct}) / ${amount};;
  }


  measure: gx_share {
    label: "GX Revenue Share"
    description: "This will collect % revenue share from direct booking channels"
    type: number
    value_format: "0.0%"
    sql: (${amount_original_gx} + ${amount_outstanding_gx}) / ${amount};;
  }


  measure: website_share {
    label: "Website Revenue Share"
    description: "This will collect % revenue share from kasawebsite & website booking channels"
    type: number
    value_format: "0.0%"
    sql: (${amount_original_website} + ${amount_outstanding_website}) / ${amount};;
  }

  measure: guestportal_share {
    label: "Guest Portal Revenue Share"
    description: "This will collect % revenue share from guestportal booking channels"
    type: number
    value_format: "0.0%"
    sql: (${amount_original_guestportal} + ${amount_outstanding_guestportal}) / ${amount};;
  }


  measure: amount_unfiltered {
    label: "Amount (Unfiltered)"
    description: "This amount is unfiltered (all reservation status, including cancellations & financial types)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount_original_unfiltered} + ${amount_outstanding_unfiltered};;
  }


  measure: adr {
    label: "ADR"
    description: "Average daily rate: amount / reservation_night. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
    drill_fields: [reservations_v3.confirmationcode, reservations_v3.bookingdate_date, reservations_v3.checkindate_date, reservations_v3.checkoutdate_date, reservations_v3.status, reservations_v3.reservation_night, reservations_v3.num_reservations, amount]
  }

# This is the same as ADR - REQUEST MADE BY TAFT LANDLORD
  measure: revenue_per_booked_room {
    label: "Revenue per Booked Room"
    description: "Average daily rate: amount / reservation_night. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${reservations_v3.reservation_night}, 0) ;;
  }


  measure: revpar {
    label: "RevPar"
    description: "Revenue per available room: amount / capacity. This only applies to confirmed / checked-in bookings and filtered financial types (excluding taxes & channel fees)"
    type: number
    value_format: "$#,##0.00"
    sql: ${amount} / NULLIF(${capacities_v3.capacity}, 0) ;;
    drill_fields: [reservations_v3.confirmationcode, reservations_v3.bookingdate_date, reservations_v3.checkindate_date, reservations_v3.checkoutdate_date, reservations_v3.status, reservations_v3.reservation_night, reservations_v3.num_reservations, amount, adr]
  }


}
