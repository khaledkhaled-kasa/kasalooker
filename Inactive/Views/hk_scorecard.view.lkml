view:hk_scorecard {
  derived_table: {
    sql: With dirty_tbl as (
      Select housekeeper, createdat, unit, cleaningstatus, _id
      from mongo.cleaninglogs as logs
      where logs.cleaningstatus = "dirty"
      and housekeeper is not null
      ), clean_tbl as (
      Select housekeeper, createdat, unit, cleaningstatus, _id
      from mongo.cleaninglogs as logs
      where logs.cleaningstatus = "clean"
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
      Select checkin, unit_id, prev_checkin, prev_unit, prev_checkout,
        concat(firstname, " ",lastname) as HK, time(clean_tbl.createdat, timezone) as time, date(clean_tbl.createdat, timezone) as date,
        clean_tbl._id, clean_tbl.createdat as date_cleaned,
        case
          when date(clean_tbl.createdat, timezone) = PARSE_DATE("%Y-%m-%d", prev_checkout) and
             time(clean_tbl.createdat, timezone) <= Cast("15:00:00" as TIME) then 1
          else 0
        End as on_time,
        case
          when date(clean_tbl.createdat, timezone) < PARSE_DATE("%Y-%m-%d", checkin) or
             (date(clean_tbl.createdat, timezone) = PARSE_DATE("%Y-%m-%d", checkin) and
             time(clean_tbl.createdat, timezone) <= Cast("15:00:00" as TIME)) then 1
          else 0
        End as before_checkin,
        case
          when date(clean_tbl.createdat, timezone) = PARSE_DATE("%Y-%m-%d", prev_checkout) and
             (PARSE_DATE("%Y-%m-%d", prev_checkout) != PARSE_DATE("%Y-%m-%d", checkin)  OR
              time(clean_tbl.createdat, timezone) <= CAST("15:00:00" as TIME)) then 1
          else 0
        End as day_of_checkout,
        confCode
      from chrono_checkins
      inner join clean_tbl
        on unit = unit_id
      inner join mongo.staffs
        on clean_tbl.housekeeper = staffs._id
      where date(clean_tbl.createdat, timezone) between PARSE_DATE("%Y-%m-%d", prev_checkout) and Date_Sub(PARSE_DATE("%Y-%m-%d", checkout), interval 1 DAY)
      and housekeeper is not null
      ;;
  }
# The reason we have fewer total than we have in the clean_tbl is because we are
# manually limiting them with the last Where clause. There may be a slick way of doing this,
# but I have not yet thought of it. The goal would be to easily tie together the checkins with the
# "MOST" previous, prev_checkin.
  measure: counted_cleans {
    type: number
    sql: count(${time}) ;;
    drill_fields: [detail*]
  }

  measure: total_cleanings {
    type:  number
    sql: (Select count(*) from cleaninglogs where cleaningstatus = "cleaning");;
  }

  measure: total_cleans {
    type:  number
    sql: (Select count(*) from cleaninglogs where cleaningstatus = "clean");;
  }

  measure: pct_on_time {
    type:  number
    sql: round(sum(${TABLE}.on_time)/count(${TABLE}.on_time),2) ;;
  }

  measure: pct_before_checkin{
    type:  number
    sql: round(sum(${TABLE}.before_checkin)/count(${TABLE}.before_checkin),2) ;;
  }

  measure: pct_day_of_checkout{
    type:  number
    sql: round(sum(${TABLE}.day_of_checkout)/count(${TABLE}.day_of_checkout),2) ;;
  }

  dimension: on_time {
    type: number
    sql: ${TABLE}.on_time ;;
  }

  dimension: day_of_checkout {
    type: number
    sql: ${TABLE}.day_of_checkout ;;
  }

  dimension: before_checkin {
    type: number
    sql: ${TABLE}.before_checkin ;;
  }

  dimension_group: checkin {
    description: "Local Checkin Date for Reservations"
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
    sql: Cast(${TABLE}.checkin  as TIMESTAMP) ;;
  }

#   dimension_group: checkout {
#     description: "Local Checkout Time for Reservations"
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.checkout ;;
#   }

  dimension_group: prev_checkin {
    description: "Previous Checkin Date for Reservations"
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
    sql: Cast(${TABLE}.prev_checkin  as TIMESTAMP) ;;
  }

  dimension_group: prev_checkout {
    description: "Local Checkout Date for Reservations"
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
    sql: Cast(${TABLE}.prev_checkin as TIMESTAMP) ;;
  }

  dimension_group: date_cleaned {
    description: "Date Clean log was created"
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
    sql: Cast(${TABLE}.date_cleaned as TIMESTAMP) ;;
  }

  dimension: HK {
    type: string
    sql: ${TABLE}.HK ;;
  }

  dimension: time {
    type: string
    hidden: yes
    sql: ${TABLE}.time ;;
  }

  dimension: day_date {
    type: string
    hidden: yes
    sql: ${TABLE}.date ;;
  }

  dimension: unit_id {
    type: string
    sql: ${TABLE}.unit_id;;
  }

  dimension: log_id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: confCode {
    type: string
    primary_key: yes
    sql: ${TABLE}.confCode ;;
  }

  dimension: prev_unit {
    type: string
    sql: ${TABLE}.prev_unit;;
  }

  set: detail {
    fields: [HK, pct_on_time, total_cleans, counted_cleans]
  }

#   dimension: prev_confCode {
#     type: string
#     sql: ${TABLE}.prev_confCode ;;
#   }


#   dimension: timezone {
#     type: string
#     sql: ${TABLE}.timezone ;;
#   }

}
