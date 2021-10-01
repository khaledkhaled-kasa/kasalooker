view: pom_walkthrough_with_reservations {
  derived_table: {
    sql:
    WITH most_recent_pom_visit as (
        SELECT  MAX(DATE(Timestamp)) as VisitDate,
                POM_Name as POM,
                Building || '-' || Door_No_ as Unit
          FROM `bigquery-analytics-272822.Gsheets.POM_QA_Walkthrough_Survey`
          Group By 2, 3
        )


        SELECT r.confirmationcode, u.internaltitle, r.checkindate, p.visitdate, po.POM
        FROM mongo.reservations r
          LEFT JOIN mongo.units u
          ON r.unit = u._id
            LEFT JOIN most_recent_pom_visit p
            ON u.internaltitle = p.unit
            LEFT JOIN ${pom_information.SQL_TABLE_NAME} po
            ON LEFT(u.internaltitle,3) = po.propcode
         ;;

    persist_for: "4 hours"

  }

  dimension: confirmation_code {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: internaltitle {
    type: string
    sql: ${TABLE}.internaltitle ;;
  }

  dimension_group: checkin {
    type: time
    timeframes: [date, month, year]
    sql: CAST(${TABLE}.checkindate as TIMESTAMP) ;;
  }

  dimension_group: visit {
    label: "POM Visit Dates"
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.visitdate ;;
  }

  dimension: pom {
    label: "POM"
    type: string
    sql: ${TABLE}.POM ;;
  }

  measure: total_check_ins {
    type: count_distinct
    sql: ${internaltitle} ;;
  }

  measure: total_check_ins_with_walkthrough {
    description: "Counts to the total number of check-ins that has had a POM Walkthrough"
    type: count_distinct
    sql: ${internaltitle} ;;
    filters: [visit_date: "-NULL"]
  }

  measure: pct_units_with_walkthrough {
    description: "Returns the percentage of units that have had a check-in as well as a POM Walkthrough"
    type: number
    sql: ${total_check_ins_with_walkthrough}/NULLIF(${total_check_ins},0);;
    value_format_name: percent_2
  }

  set: detail {
    fields: [internaltitle, checkin_date, visit_date, pom]
  }
}
