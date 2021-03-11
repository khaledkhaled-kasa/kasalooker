view: reservations_v3 {
  label: "Reservations"
  derived_table: {
    sql:

  WITH  guest_type_table AS (
         SELECT email,
         CASE WHEN count(*) > 1 THEN "Multi Booker"
         ELSE "Single Booker"
         END guest_type,
         count(*) AS number_of_bookings
         FROM reservations
         JOIN guests ON reservations.guest = guests._id
         WHERE reservations.status IN ('confirmed','checked_in')
         GROUP BY 1),

        extensions AS (
            with r1 AS (SELECT reservations.*, guests.email
            FROM reservations JOIN guests ON reservations.guest = guests._id),
            r2 AS (SELECT reservations.*, guests.email
            FROM reservations JOIN guests ON reservations.guest = guests._id)
          SELECT r1.confirmationcode AS initial_reservation_extensions,
          r2.confirmationcode AS reservation_extensions
          FROM r1 JOIN r2 ON r1.email = r2.email
          AND CAST(TIMESTAMP(r1.checkoutdate) AS DATE) = CAST(TIMESTAMP(r2.checkindate) AS DATE)
          AND r1.property = r2.property
          WHERE r1.status IN ('confirmed','checked_in')
          AND r2.status IN ('confirmed','checked_in')),

          number_of_extended_bookings AS (
            with r1 AS (SELECT reservations.*, guests.email
            FROM reservations JOIN guests ON reservations.guest = guests._id),
            r2 AS (SELECT reservations.*, guests.email
            FROM reservations JOIN guests ON reservations.guest = guests._id)
          SELECT r1.email, count(*) AS bookings_with_extensions
          FROM r1 JOIN r2 ON r1.email = r2.email
          AND CAST(TIMESTAMP(r1.checkoutdate) AS DATE) = CAST(TIMESTAMP(r2.checkindate) AS DATE)
          AND r1.property = r2.property
          WHERE r1.status IN ('confirmed','checked_in')
          AND r2.status IN ('confirmed','checked_in')
          GROUP BY 1),

        reservations_new AS (
          SELECT reservations.*, email
          FROM reservations JOIN guests
          ON reservations.guest = guests._id)


    SELECT reservations_new.*, guest_type_table.guest_type, guest_type_table.number_of_bookings, number_of_extended_bookings.bookings_with_extensions,
    CASE WHEN bookings_with_extensions is null THEN guest_type_table.number_of_bookings
    WHEN (guest_type_table.number_of_bookings - number_of_extended_bookings.bookings_with_extensions) < 1 THEN (guest_type_table.number_of_bookings - 0.5*number_of_extended_bookings.bookings_with_extensions)
    ELSE guest_type_table.number_of_bookings - number_of_extended_bookings.bookings_with_extensions
    END number_of_unique_reservations,
    CASE WHEN e2.initial_reservation_extensions is not null THEN 1
    ELSE NULL
    END initial_booking,
    CASE WHEN e1.reservation_extensions is not null THEN 1
    ELSE NULL
    END extended_booking
    FROM reservations_new
    LEFT JOIN extensions e1
    ON reservations_new.confirmationcode = e1.reservation_extensions
    LEFT JOIN extensions e2
    ON reservations_new.confirmationcode = e2.initial_reservation_extensions
    LEFT JOIN number_of_extended_bookings
    ON reservations_new.email = number_of_extended_bookings.email
    LEFT JOIN guest_type_table
    ON reservations_new.email = guest_type_table.email ;;

        # persist_for: "1 hour"
        datagroup_trigger: kasametrics_v3_default_datagroup
        # indexes: ["night","transaction"]
        publish_as_db_view: yes

    }

  dimension: confirmationcode {
    type: string
    primary_key: yes
    sql: ${TABLE}.confirmationcode ;;
    drill_fields: [reservation_details*]
  }

    dimension: guest_type {
      hidden: no
      view_label: "Guests"
      type: string
      description: "Multibooker is classified as someone making more than one UNIQUE reservation (extensions are excluded)"
      sql: CASE
      WHEN ${TABLE}.guest_type = "Multi Booker" and ${TABLE}.number_of_unique_reservations = 1 THEN "Single Booker"
      ELSE ${TABLE}.guest_type
      END;;
    }

  dimension: guest_reservations {
    view_label: "Guests"
    label: "Total Guest Reservations (Including Extensions)"
    hidden: no
    description: "This pulls the number of reservations the guest has made including extensions"
    type: number
    sql: ${TABLE}.number_of_bookings ;;
  }

    dimension: guest_unique_reservations {
      view_label: "Guests"
      description: "This pulls the number of reservations the guest has made excluding extensions"
      label: "Total Guest Reservations (Excluding Extensions)"
      hidden: no
      type: number
      sql: ${TABLE}.number_of_unique_reservations ;;
      }


    dimension: extended_booking {
      type: yesno
      sql: ${TABLE}.extended_booking = 1 ;;
    }


    dimension: initial_booking {
      label: "Initial Booking (For Extensions Only)"
      description: "This will inform us if it's the original / initial booking of an extended stay."
      type: yesno
      sql: ${TABLE}.initial_booking = 1 ;;
    }



    dimension: _id {
      hidden: yes
      type: string
      sql: ${TABLE}._id ;;
    }


    dimension_group: bookingdate {
      label: "Booking"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        week_of_year,
        month,
        month_name,
        quarter,
        year
      ]
      sql: ${TABLE}.bookingdate ;;
    }

    dimension: lead_time {
      description: "This will pull the time between the booking date and checkin date."
      type:  number
      sql:  date_diff(${checkindate_date}, CAST(${TABLE}.bookingdate as DATE), DAY) ;;
    }

  dimension: cancellation_window {
    description: "This will pull the time between the cancellation date and checkin date."
    type:  number
    sql:  date_diff(${checkindate_date}, CAST(${TABLE}.cancellationdate as DATE), DAY) ;;
  }

    dimension: length_of_stay {
      type:  number
      sql:  date_diff(${checkoutdate_date}, ${checkindate_date}, DAY) ;;
    }



    dimension: bringingpets {
      type: yesno
      sql: ${TABLE}.bringingpets ;;
    }



    dimension_group: cancellationdate {
      label: "Cancellation"
      type: time
      timeframes: [
        time,
        date,
        week,
        month,
        year
      ]
      sql: ${TABLE}.cancellationdate ;;
    }


    dimension_group: checkindate {
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


    dimension: earlycheckin {
      hidden: yes
      sql: ${TABLE}.earlycheckin ;;
    }

    dimension: externalrefs {
      hidden: yes
      sql: ${TABLE}.externalrefs ;;
    }

    dimension: guest {
      hidden: yes
      type: string
      sql: ${TABLE}.guest ;;
    }

    dimension: guestscount {
      type: number
      sql: ${TABLE}.guestscount ;;
    }


    dimension: parkingspaceneeded {
      type: yesno
      sql: ${TABLE}.parkingspaceneeded ;;
    }


    dimension: pets {
      type: yesno
      sql: ${TABLE}.pets ;;
    }


    dimension: plannedarrival {
      type: string
      sql: ${TABLE}.plannedarrival ;;
    }

    dimension: planneddeparture {
      type: string
      sql: ${TABLE}.planneddeparture ;;
    }

    dimension: platform {
      type: string
      sql: ${TABLE}.platform ;;
    }

    dimension: signeddoc {
      type: string
      sql: ${TABLE}.signeddoc ;;
    }

    dimension: smartlockcode {
      type: string
      sql: ${TABLE}.smartlockcode ;;
    }


    dimension: source {
      type: string
      sql: ${TABLE}.source ;;
    }

    dimension: sourcedetail {
      type: string
      sql: ${TABLE}.sourcedetail ;;
    }

    dimension: specialrequest {
      type: string
      sql: ${TABLE}.specialrequest ;;
    }

    dimension: status {
      type: string
      sql: ${TABLE}.status ;;
    }

    dimension: status_booked{
      description: "Was this night booked?"
      type: yesno
      sql: ${TABLE}.status is null or ${TABLE}.status IN ("confirmed","checked_in");;
    }

    dimension: suspicious {
      type: yesno
      sql: ${TABLE}.suspicious ;;
    }

    dimension: timezone {
      hidden: yes
      type: string
      sql: ${TABLE}.timezone ;;
    }

    dimension: unit {
      type: string
      hidden: yes
      sql: ${TABLE}.unit ;;
    }


    dimension: financial_night_part_of_res {
      hidden: yes
      type:  yesno
      sql: ${financials_v3.night_date} < ${checkoutdate_date} and
        ${financials_v3.night_date} >= ${checkindate_date};;
    }

    dimension: financial_night_part_of_res_modified {
      hidden: yes
      description: "This will ultimately just apply the financial night part of reservations for any financial nights prior to 01-21 where neccessary data manipulation for historic data was set in place"
      type:  string
      sql: CASE WHEN (${financial_night_part_of_res} OR ${financials_v3.night_date} >= '2021-01-01')THEN "yes"
            ELSE "no"
            END;;
    }

    dimension: capacity_night_part_of_res {
      type:  yesno
      hidden: yes
      sql: ${capacities_v3.night_date} < ${checkoutdate_date} and
        ${capacities_v3.night_date} >= ${checkindate_date};;
    }

  dimension: checkin_night {
    hidden: yes
    type:  yesno
    sql: ${capacities_v3.night_date} = ${checkindate_date} ;;
  }

  dimension: checkout_night {
    hidden: yes
    type:  yesno
    sql: ${capacities_v3.night_date} = ${checkoutdate_date} ;;
  }

  measure: reservation_night {
    label: "Num ReservationNights"
    description: "Reservation night stay. This metric will only consider confirmed / checked in bookings."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${capacities_v3.night_date});;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: reservation_night_canceled {
    label: "Num ReservationNights (Canceled)"
    description: "Reservation night stay. This metric will only filter for canceled bookings."
    type:  count_distinct
    sql: CONCAT(${confirmationcode}, '-', ${capacities_v3.night_date});;
    filters: [capacity_night_part_of_res: "yes", status: "cancelled, canceled"]
  }


    measure: num_reservations {
      label: "Num Reservations"
      description: "Number of unique reservations. This metric will only consider confirmed / checked in bookings."
      type: count_distinct
      sql: ${confirmationcode} ;;
      filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
      drill_fields: [reservation_details*]
    }

  measure: num_reservations_canceled {
    label: "Num Reservations (Canceled)"
    description: "Number of unique reservations. This metric will only filter for canceled bookings."
    type: count_distinct
    sql: ${confirmationcode} ;;
    filters: [capacity_night_part_of_res: "yes", status: "cancelled, canceled"]
    drill_fields: [reservation_details*]
  }


    measure: occupancy {
      label: "Occupancy"
      description: "Number of reservation nights / capacity"
      type: number
      value_format: "0.0%"
      sql:  ${reservation_night} / NULLIF(${capacities_v3.capacity}, 0) ;;
    }


    measure: number_of_checkins {
      label: "Number of Checkins"
      description: "Number of Check-ins EXCLUDING Extensions"
      type: count_distinct
      sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
      filters: [checkin_night: "yes", extended_booking: "no", status: "confirmed, checked_in"]
    }

  measure: number_of_checkins_star {
    label: "Number of Checkins - Including Extensions"
    description: "Number of Check-ins INCLUDING Extensions"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [checkin_night: "yes", status: "confirmed, checked_in"]
  }

    measure: number_of_checkouts {
      label: "Number of Checkouts"
      description: "Number of Check-outs EXCLUDING Initial Extended Booking Checkouts"
      type: count_distinct
      sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
      filters: [checkout_night: "yes", initial_booking: "no", status: "confirmed, checked_in"]
    }

  measure: number_of_checkouts_star {
    label: "Number of Checkouts - Including Extensions"
    description: "Number of Check-outs INCLUDING Initial Extended Booking Checkouts"
    type: count_distinct
    sql: CONCAT(${units.internaltitle},${confirmationcode}) ;;
    filters: [checkout_night: "yes", status: "confirmed, checked_in"]
  }

  measure: extended_booking_count {
    label: "Extended Booking Count"
    description: "This would apply only to confirmed / checked-in bookings"
    type: count_distinct
    sql: CONCAT(${extended_booking}, ${confirmationcode}) ;;
    filters: [extended_booking: "yes", status: "confirmed, checked_in"]
  }

  measure: avg_lead_time {
    label: "Average Lead Time"
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: avg_cancellation_window {
    description: "Days between cancelling and checking in."
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${cancellation_window};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes"]
  }

  measure: median_lead_time {
    description: "Days between booking and checking in. This metric will only consider confirmed / checked in bookings."
    label: "Median Lead Time"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${lead_time};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: avg_length_of_stay {
    description: "Number of days of stay. This metric will only consider confirmed / checked in bookings."
    label: "Average Length of Stay"
    value_format: "0.0"
    type:  average_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: median_length_of_stay {
    description: "Number of days of stay. This metric will only consider confirmed / checked in bookings."
    label: "Median Length of Stay"
    value_format: "0.0"
    type:  median_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${length_of_stay};;
    drill_fields: [reservation_details*]
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

  measure: guestscount_sum {
    label: "Total Number of Guests"
    description: "Number of guests within the reservation(s). This metric will only consider confirmed / checked in bookings."
    type: sum_distinct
    sql_distinct_key: ${confirmationcode} ;;
    sql: ${guestscount} ;;
    filters: [capacity_night_part_of_res: "yes", status: "confirmed, checked_in"]
  }

    set:reservation_details {
      fields: [confirmationcode, status, source, bookingdate_date]
    }

}
