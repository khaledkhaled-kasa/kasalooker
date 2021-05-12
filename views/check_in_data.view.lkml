view: check_in_data {
  derived_table: {
    sql: SELECT  u.internaltitle,
        p.POM,
        EXTRACT(MONTH from DATE(r.checkindate)) as CheckinDateMonth,
        EXTRACT(YEAR from DATE(r.checkindate)) as CheckinDateYear,
        COUNT(DISTINCT r.confirmationcode) as MonthlyCheckins
        FROM mongo.units u
          LEFT JOIN ${reservations_v3.SQL_TABLE_NAME} r
          ON u._id = r.unit
          INNER JOIN ${pom_information.SQL_TABLE_NAME} p
          ON substr(u.internaltitle, 1, 3) = p.PropCode
        WHERE u.internaltitle is not null
        AND r.status IN ('confirmed','checked_in')
        AND r.extended_booking IS NULL
        Group By 1,2,3,4
 ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${internaltitle} || CAST(${checkin_date_month} AS STRING) || CAST(${checkin_date_year} AS STRING) ;;
  }

  dimension: internaltitle {
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: pom {
    type: string
    sql: ${TABLE}.POM ;;
  }

  dimension: checkin_date_month {
    type: number
    sql: ${TABLE}.CheckinDateMonth ;;
  }

  dimension: checkin_date_year {
    type: number
    sql: ${TABLE}.CheckinDateYear ;;
  }

  dimension: MonthlyCheckins {
    type: number
    sql: ${TABLE}.MonthlyCheckins ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_checkins {
    type: sum
    sql: ${MonthlyCheckins} ;;
  }

  set: detail {
    fields: [internaltitle, pom, checkin_date_month, checkin_date_year, MonthlyCheckins]
  }
}
