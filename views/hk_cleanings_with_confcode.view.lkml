view: hk_cleanings_with_confcode {
  derived_table: {
    sql: With cleaning_tbl as (
        Select housekeeper, createdat, unit, cleaningstatus, _id
        from mongo.cleaninglogs as logs
            where logs.cleaningstatus = "cleaning"
            and housekeeper is not null
        ), res_ties as(
          Select res.checkinDateLocal as checkin,
                res.checkoutDateLocal as checkout,
                units._id as unit_id,
                res.confirmationCode as confCode,
                units.timezone as timezone,
                res.status
          from mongo.reservations as res
          inner join mongo.units as units
            on units._id = res.unit
          where res.status = "confirmed"
          or res.status = "checked_in"
        ), chrono_checkins as (
          Select *
          from (
          Select res_ties.checkin,
            res_ties.checkout,
            res_ties.unit_id,
            LAG(res_ties.checkin,1) OVER(order by res_ties.unit_id, res_ties.checkin) as prev_checkin,
            LAG(res_ties.unit_id,1) OVER(order by res_ties.unit_id, res_ties.checkin) as prev_unit,
            LAG(res_ties.confCode,1) OVER(order by res_ties.unit_id, res_ties.checkin) as prev_confCode,
            LAG(res_ties.checkout,1) OVER(order by res_ties.unit_id, res_ties.checkin) as prev_checkout,
            res_ties.timezone,
            res_ties.confCode
          from res_ties) as lag
          where unit_id = prev_unit
          group by unit_id, checkin, checkout, prev_checkout, prev_checkin, prev_confCode, prev_unit, timezone, confCode
          order by unit_id, checkin
          )
          Select concat(firstname, " ", lastname) as HK, cleaning_tbl.createdat, chrono_checkins.confCode,
                hk_scorecard.date_cleaned, timezone, chrono_checkins.prev_checkout, chrono_checkins.checkout
          from chrono_checkins
          inner join cleaning_tbl
            on cleaning_tbl.unit = chrono_checkins.unit_id
          inner join mongo.staffs
            on staffs._id = cleaning_tbl.housekeeper
          inner join hk_scorecard
            on ${hk_scorecard.SQL_TABLE_NAME}.confCode = chrono_checkins.confCode
          where date(cleaning_tbl.createdat, timezone) between PARSE_DATE("%Y-%m-%d", chrono_checkins.prev_checkout) and
          Date_Sub(PARSE_DATE("%Y-%m-%d", chrono_checkins.checkout), interval 1 DAY)
          and housekeeper is not null
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hk {
    type: string
    sql: ${TABLE}.HK ;;
  }

  dimension_group: createdat {
    description: "Date cleaning was created"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: Cast(${TABLE}.createdat  as TIMESTAMP) ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: time {
    type: date_time_of_day
    sql: ${TABLE}.createdat ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}.createdat ;;
  }

  dimension: conf_code {
    type: string
    sql: ${TABLE}.confCode ;;
  }

  set: detail {
    fields: [hk, createdat_time, conf_code]
  }
}
