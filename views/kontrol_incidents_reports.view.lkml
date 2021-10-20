view: kontrol_incidents_reports {
  derived_table: {
    sql: SELECT
      _id,
      reservation,
      incidentdate,
      incidents.value.category,
      reportingparty,
      estimatedcostofdamage,
      description,
      guestremoval,
      offendingparty
      FROM `bigquery-analytics-272822.mongo.incidentreports` LEFT JOIN UNNEST(incidents) as incidents
      where description not  like '%Adam test%' and description not  like '%incident test%' and description <> "TEST"
       ;;

  }


  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
    hidden: yes
  }

  dimension_group: incidentdate {
    type: time
    timeframes: [date, time, year, week, month]
    sql: ${TABLE}.incidentdate ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: reporting_party {
    type: string
    sql: ${TABLE}.reportingparty ;;
  }

  dimension: estimated_cost_of_damage {
    type: string
    sql: ${TABLE}.estimatedcostofdamage ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: guest_removal {
    type: yesno
    sql: ${TABLE}.guestremoval ;;
  }

  dimension: offending_party {
    type: string
    sql: ${TABLE}.offendingparty ;;
  }
  measure: count {
    type: count_distinct
    sql: ${_id} ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      _id,
      reservation,
      incidentdate_time,
      category,
      reporting_party,
      estimated_cost_of_damage,
      description,
      guest_removal,
      offending_party
    ]
  }
}
