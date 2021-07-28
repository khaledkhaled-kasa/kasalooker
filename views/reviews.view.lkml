# view: reviews {
#   sql_table_name: `bigquery-analytics-272822.mongo.reviews`
#     ;;

  view: reviews {
    derived_table: {
      sql:
      with t4 as (with t3 as (
              with t2 as (
                with t1 as
                (SELECT * FROM mongo.reviews, UNNEST(reviewtags))
                  select _id as _id2, value
                 from t1)
                 select * from mongo.reviews
                  left join t2
                  on reviews._id = t2._id2)

                select reviewbykasa, reservation, overallratingstandardized, submitdate, _id, target, unit, guest, channel, overallrating, privatereviewtext,
                string_agg(value order by value) as review_tags
                from t3
                group by 1,2,3,4,5,6,7,8,9,10,11)


      select t4.*, t5.privatereviewtext privatereviewtext2
      from t4 join t4 t5
      on (t4.reservation = t5.reservation and t4.target != t5.target);;
    }



view_label: "Check-In Survey Data"

  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }


  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: guest {
    type: string
    sql: ${TABLE}.guest ;;
  }

  dimension: overallrating {
    label: "Overall Rating"
    hidden: no
    type: number
    sql: ${TABLE}.overallrating ;;
  }

    dimension: overallrating_bucket {
      label: "Overall Rating (Bad/Neutral/Perfect)"
      hidden: no
      type: string
      sql: CASE WHEN ${TABLE}.overallrating = 5 THEN "Perfect"
      WHEN ${TABLE}.overallrating = 4 THEN "Neutral"
      WHEN ${TABLE}.overallrating BETWEEN 1 AND 3 THEN "Bad"
      END;;
    }

  dimension: review_tags {
    type: string
    sql: ${TABLE}.review_tags ;;
  }

  measure: avg_rating {
    type:  average
    value_format: "0.0"
    label: "Average Real-time Review Rating"
    sql: ${TABLE}.overallrating ;;
  }

  measure: count_thumbs_up {
    type: count_distinct
    sql: ${reservation};;
    hidden: yes
    view_label: "Metrics"
    filters: [overallrating: "5"]
  }

    measure: percent_thumbs_up {
      type: number
      label: "% Thumbs Up"
      description: "This will pull the % of ratings which scored a 5 for either cleanliness or checkin."
      value_format: "0%"
      sql: ${count_thumbs_up} / nullif(${count},0) ;;
    }

  dimension: privatereviewtext {
    label: "Private Review Text"
    type: string
    sql: ${TABLE}.privatereviewtext ;;
  }

    dimension: aggregated_comments {
      hidden: yes
      label: "Aggregated Private Review Text"
      description: "This will concatenate the cleaning and checking comments"
      type: string
      sql: CASE WHEN ${target} = "cleaning" THEN CONCAT(COALESCE(${TABLE}.privatereviewtext,""),"~",COALESCE(${TABLE}.privatereviewtext2,"N/A"))
      ELSE CONCAT(COALESCE(${TABLE}.privatereviewtext2,""),"~",COALESCE(${TABLE}.privatereviewtext,"N/A"))
      END;;
    }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: reviewbykasa {
    type: yesno
    sql: ${TABLE}.reviewbykasa ;;
  }

  dimension_group: submitdate {
    label: "Real-time Review"
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
    sql: ${TABLE}.submitdate ;;
  }

  dimension: target {
    type: string
    label: "Type"
    sql: ${TABLE}.target ;;
  }

  dimension: unit {
    type: string
    hidden: yes
    sql: ${TABLE}.unit ;;
  }


    dimension: number_of_days {
      description: "Number of days it took to complete real-time checkin survey post check-in"
      hidden: yes
      type:  number
      sql:  date_diff(${submitdate_date}, ${reservations_clean.checkindate_date}, DAY) ;;
    }


    measure: number_of_days_median {
      description: "Median number of days it took to complete real-time checkin survey post check-in."
      label: "Median # of Days to Complete VFD Survey"
      value_format: "0.0"
      type:  median_distinct
      sql_distinct_key: ${reservation} ;;
      sql: ${number_of_days};;
    }

  measure: count {
    label: "Review Count (Total)"
    description: "This will pull the # of reviews for either cleanliness or checkin."
    type: count_distinct
    sql: ${reservation};;
    drill_fields: [reservations_clean.confirmation_code]
  }

    measure: count_bad {
      group_label: "NQS Metrics"
      label: "Review Count (Bad)"
      description: "This will pull the # of 1-3 star reviews for either cleanliness or checkin."
      type: count_distinct
      sql: ${reservation};;
      drill_fields: [reservations_clean.confirmation_code]
      filters: [overallrating_bucket: "Bad"]
    }

    measure: count_neutral {
      group_label: "NQS Metrics"
      label: "Review Count (Neutral)"
      description: "This will pull the # of 4 star reviews for either cleanliness or checkin."
      type: count_distinct
      sql: ${reservation};;
      filters: [overallrating_bucket: "Neutral"]
      drill_fields: [reservations_clean.confirmation_code]
    }

    measure: count_perfect {
      group_label: "NQS Metrics"
      label: "Review Count (Perfect)"
      description: "This will pull the # of 5 star reviews for either cleanliness or checkin."
      type: count_distinct
      sql: ${reservation};;
      filters: [overallrating_bucket: "Perfect"]
      drill_fields: [reservations_clean.confirmation_code]
    }

    measure: percent_bad {
      group_label: "NQS Metrics"
      description: "This will pull the % Bad Stays for either cleanliness or checkin."
      label: "% Bad Stays"
      value_format: "0.0%"
      type: number
      sql: ${count_bad} / nullif(${count},0);;
    }

    measure: percent_neutral {
      group_label: "NQS Metrics"
      description: "This will pull the % Neutral Stays for either cleanliness or checkin."
      label: "% Neutral Stays"
      value_format: "0.0%"
      type: number
      sql: ${count_neutral} / nullif(${count},0);;
    }

    measure: percent_perfect {
      group_label: "NQS Metrics"
      description: "This will pull the % Perfect Stays for either cleanliness or checkin."
      label: "% Perfect Stays"
      value_format: "0.0%"
      type: number
      sql: ${count_perfect} / nullif(${count},0);;
    }

    measure: net_quality_score {
      group_label: "NQS Metrics"
      description: "This will pull the NQS for either cleanliness or checkin."
      value_format: "0.0"
      type: number
      sql: 100*(${percent_perfect} - ${percent_bad});;
    }




}
