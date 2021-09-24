  view: hk_partners {
    derived_table: {
      sql:   SELECT *
          FROM `bigquery-analytics-272822.Breezeway_Data.hk_partners`
       ;;
      persist_for: "24 hours"
    }

    dimension: start_date {
      type: date
      sql: timestamp(${TABLE}.Start_Date) ;;
      convert_tz: no
    }

    dimension: end_date {
      type: date
      sql: ${TABLE}.End_Date ;;
      convert_tz: no
    }


  dimension: first_3_months {
      label: "Review within First 3 Months"
      description: "Review is given on a reservation checked in within the first 90 days of the HK Partner contractual date"
      hidden: no
      type: yesno
      sql: ${reservations_clean.checkindate_date} >= ${start_date} AND ${reservations_clean.checkindate_date} <= (${start_date} + 90) ;;
    }

  dimension: buildings {
    hidden: no
    type: string
    sql: ${TABLE}.Buildings ;;
  }

  dimension: comm_preferred {
    hidden: yes
    type: string
    sql: ${TABLE}.Comm_Preferred ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.Company_Name ;;
  }

  dimension: daily_occupancy_report_set_up {
    hidden: yes
    type: yesno
    sql: ${TABLE}.Daily_Occupancy_Report_set_up ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: home_address {
    type: string
    sql: ${TABLE}.Home_Address ;;
  }

  dimension: partner_name {
    type: string
    sql: ${TABLE}.Housekeeper ;;
  }

  dimension: kasa_manager {
    type: string
    sql: ${TABLE}.Kasa_Manager ;;
  }

  dimension: kasa_region {
    type: string
    sql: ${TABLE}.Kasa_Region ;;
  }

  dimension: metro {
    type: string
    sql: ${TABLE}.Metro ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.Phone ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }


  measure: count_partners {
    type: count_distinct
    sql: ${TABLE}.Housekeeper ;;
  }


}
