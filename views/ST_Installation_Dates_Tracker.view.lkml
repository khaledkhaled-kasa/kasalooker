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
              datagroup_trigger: ST_Installation_Dates_Tracker_datagroup
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

    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
      hidden: yes
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


  measure: avg_checkin_rating_after {
    label: "Avg CI Rating(After Installation)"
    type: average
    value_format: "0.00"
    sql:  ${airbnb_reviews.checkin_rating};;
    filters: [sT_Installation_Status: "After Installation"]
  }
  measure: avg_checkin_rating_before {
    label: "Avg CI Rating(Before Installation)"
    type: average
    value_format: "0.00"
    sql:  ${airbnb_reviews.checkin_rating};;
    filters: [sT_Installation_Status: "Befor Installation"]
  }
  measure: count_checkin_rating_before {
    label: "#Reviews (Before Installation)"
    type: count_distinct
    sql:  ${airbnb_reviews.reservation_code};;
    filters: [sT_Installation_Status: "Befor Installation",airbnb_reviews.reservation_code: "-Null"]
    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status,airbnb_reviews.checkin_comments]

  }
  measure: count_checkin_rating_after {
    label: "#Reviews (After Installation)"
    type: count_distinct
    sql:  ${airbnb_reviews.reservation_code};;
    filters: [sT_Installation_Status: "After Installation",airbnb_reviews.reservation_code: "-Null"]
    drill_fields: [airbnb_reviews.reservation_code,airbnb_reviews.checkin_rating,sT_Installation_Status,airbnb_reviews.checkin_comments]

  }
  # measure: avg_checkin_rating_before_realtime {
  #   label: "Avg Real-time Review Rating(Before Installation)"
  #   type: average
  #   value_format: "0.00"
  #   sql:  ${reviews.avg_rating};;
  #   filters: [sT_Installation_Status: "Befor Installation"]
  # }
  # measure: avg_checkin_rating_after_realtime {
  #   label: "Avg Real-time Review Rating(After Installation)"
  #   type: average
  #   value_format: "0.00"
  #   sql:   ${reviews.avg_rating};;
  #   filters: [sT_Installation_Status: "After Installation"]
  # }
  # measure: count_checkin_rating_after_realtime {
  #   label: "#Real time Reviews (After Installation)"
  #   type: count_distinct
  #   sql:  ${reviews.count};;
  #   filters: [sT_Installation_Status: "After Installation"]

  # }

  }
