view: reservations_mod {
  derived_table: {
    sql: SELECT TIMESTAMP(capacities.night) as night, complexes.title AS building_title, CAST(capacities.bedroomtype AS STRING) as bedroom_type, capacities.capacity,
      units.internaltitle AS unit_name, reservations.confirmationcode, reservations.checkindatelocal, reservations.checkoutdatelocal, reservations.sourcedetail,
      CASE WHEN reservations.confirmationcode IS NULL then 0 ELSE 1 END AS reservation_night
      FROM capacities JOIN complexes
      ON capacities.complex = complexes._id JOIN units
      ON (capacities.complex = units.complex AND CAST(capacities.bedroomtype AS STRING) = CAST(units.bedrooms AS STRING)) LEFT JOIN reservations
      ON (reservations.unit = units._id
      AND (CAST(capacities.night AS DATE) >= CAST(reservations.checkindatelocal AS DATE) AND CAST(capacities.night AS DATE) < CAST(reservations.checkoutdatelocal AS DATE))
      AND reservations.status IN ('checked_in', 'confirmed'))
      order by capacities.night desc
       ;;
  }

#   measure: count {
#     view_label: "Metrics"
#     hidden: yes
#     type: count
#     drill_fields: [detail*]
#   }



  measure: reservation_night_sum {
    view_label: "Metrics"
    label: "Reservation_Night"
    type: sum
    sql: ${TABLE}.reservation_night ;;
  }

  measure: occupancy {
    view_label: "Metrics"
    label: "Occupancy"
    description: "Number of reservation nights / capacity"
    type: number
    value_format: "0.0%"
    sql:  ${reservation_night_sum} / NULLIF(${TABLE}.capacity, 0) ;;
#     drill_fields: [financials.night_date, reservation_details*];;
  }

#   dimension: night {
#     type: date
#     sql: ${TABLE}.night ;;
#   }

  dimension_group: night {
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

  dimension: building_title {
    type: string
    sql: ${TABLE}.building_title ;;
  }

  dimension: bedroom_type {
    type: string
    sql: ${TABLE}.bedroom_type ;;
  }

  dimension: capacity {
    type: number
    sql: ${TABLE}.capacity ;;
  }

  dimension: unit_name {
    type: string
    sql: ${TABLE}.unit_name ;;
  }

  dimension: confirmationcode {
    type: string
    hidden: yes
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: checkindatelocal {
    type: date
    hidden: yes
    sql: ${TABLE}.checkindatelocal ;;
  }

  dimension: checkoutdatelocal {
    type: date
    hidden: yes
    sql: ${TABLE}.checkoutdatelocal ;;
  }

  dimension: sourcedetail {
    type: string
    sql: ${TABLE}.sourcedetail ;;
  }

  dimension: reservation_night {
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_night ;;
  }

#   set: detail {
#     fields: [
#       night,
#       building_title,
#       bedroom_type,
#       capacity,
#       unit_name,
#       confirmationcode,
#       checkindatelocal,
#       checkoutdatelocal,
#       sourcedetail,
#       reservation_night
#     ]
#   }
}
