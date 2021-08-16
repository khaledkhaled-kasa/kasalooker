view: ST_Installation_Dates_Tracker {
    derived_table: {
      sql: select * from
              (
              SELECT
                    UnitInternalTitle,
                    SmartThings_Installation,
                    dense_rank() over(partition by UnitInternalTitle order by SmartThings_Installation asc) as rank
                    FROM `bigquery-analytics-272822.Gsheets.ST_Installation_Dates_Tracker`
                    where
                    UnitInternalTitle is not null
                  ) where rank=1
               ;;
              datagroup_trigger: ST_Installation_Dates_Tracke_datagroup
    }


    dimension: unit_internal_title {
      type: string
      sql: ${TABLE}.UnitInternalTitle ;;
      primary_key: yes
    }

    dimension: smart_things_installation {
      type: date
      datatype: date
      sql: ${TABLE}.SmartThings_Installation ;;
      hidden: yes
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
    }

    set: detail {
      fields: [unit_internal_title, smart_things_installation, rank]
    }

  dimension: sT_Installation_Status {
    type: string
    sql: CASE WHEN ${airbnb_reviews.reservation_checkin_date}> ${smart_things_installation} then "After Installation"
      ELSE "Befor Installation" end ;;
  }
  measure: count {
    type: count_distinct
    sql: ${unit_internal_title};;
    drill_fields: [detail*]
  }
  measure: AfterReviews {
    type: count_distinct
    label: "# Reviews After Installation"
    sql: case when ${sT_Installation_Status}="After Installation" then ${airbnb_reviews.reservation_code} else null end  ;;
    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status]
    hidden: yes
  }
  measure: BeforerReviews {
    type: count_distinct
    label: "# Reviews Before Installation"
    sql: case when ${sT_Installation_Status}="Befor Installation" then ${airbnb_reviews.reservation_code} else null end ;;
    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status]
    hidden: yes
  }

  measure: BeforerCheckinRating {
    label: "SUM Checkin Rating(Befor Installation)"
    type: sum
    sql: case when ${sT_Installation_Status}="Befor Installation" then ${airbnb_reviews.checkin_rating} else null end ;;

    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status]
    hidden: yes
  }
  measure: AfterCheckinRating {
    label: "SUM Checkin Rating(After Installation)"
    type: sum
    sql: case when ${sT_Installation_Status}="After Installation" then ${airbnb_reviews.checkin_rating} else null end ;;
    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status]
    hidden: yes
  }


  measure: avg_checkin_rating_after {
    label: "Average Checkin Rating(After Installation)"
    type: average
    value_format: "0.00"
    sql:  ${airbnb_reviews.checkin_rating};;
    filters: [sT_Installation_Status: "After Installation"]
  }
  measure: avg_checkin_rating_before {
    label: "Average Checkin Rating(Before Installation)"
    type: average
    value_format: "0.00"
    sql:  ${airbnb_reviews.checkin_rating};;
    filters: [sT_Installation_Status: "Befor Installation"]
  }

  }
