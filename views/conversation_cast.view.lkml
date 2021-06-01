view: conversation_csat {
  sql_table_name: `kustomer.conversation`
    ;;

  dimension: id {
    primary_key: yes
    type: string
    label: "Conversation ID"
    sql: ${TABLE}.id ;;
  }


  dimension_group: created_at {
    type: time
    hidden: yes
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: string
    hidden: yes
    sql: ${TABLE}.created_by ;;
  }

  dimension: custom_issue_category_tree {
    type: string
    hidden: yes
    sql: ${TABLE}.custom_issue_category_tree ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: ended {
    type: string
    hidden: yes
    sql: ${TABLE}.ended ;;
  }

  dimension: name {
    type: string
    label: "Conversation Title"
    sql: ${TABLE}.name ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}.priority ;;
  }

  dimension: satisfaction_level_channel {
    type: string
    sql: ${TABLE}.satisfaction_level_channel ;;
  }

  dimension_group: satisfaction_level_created_at {
    type: time
    view_label: "Date Dimensions"
    group_label: "Satisfaction Level Created Date"
    label: ""
    description: "Satisfaction level created at"
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year,
      time_of_day
    ]
    sql: ${TABLE}.satisfaction_level_created_at ;;
  }

  dimension: satisfaction_level_rating {
    type: number
    sql: ${TABLE}.satisfaction_level_rating ;;
  }

  dimension: satisfaction_level_score {
    type: number
    sql: ${TABLE}.satisfaction_level_score ;;
  }


  dimension: satisfaction_level_status {
    type: string
    sql: ${TABLE}.satisfaction_level_status ;;
  }

  dimension: sentiment_confidence {
    type: number
    sql: ${TABLE}.sentiment_confidence ;;
  }

  dimension: sentiment_polarity {
    type: number
    sql: ${TABLE}.sentiment_polarity ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: queue_id {
    type: string
    hidden: yes
    sql: ${TABLE}.queue_id ;;
  }

  # dimension: user_id {
  #   type: string
  #   hidden: yes
  #   sql: ${TABLE}.user_id ;;
  # }

  # dimension: team_id {
  #   type: string
  #   hidden: yes
  #   sql: ${TABLE}.team_id ;;
  # }

  # dimension: user_name {
  #   type: string
  #   sql: ${TABLE}.user_name ;;
  # }

  # dimension: team_name {
  #   type: string
  #   sql: ${TABLE}.team_name ;;
  # }

  measure: total_responses {
    view_label: "Metrics"
    description: "Total CSAT Responses"
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: satisfaction_level_score
      value: ">=0"
    }
    drill_fields: []
  }

  measure: positive_responses {
    hidden: no
    view_label: "Metrics"
    type: count_distinct
    sql: ${id} ;;
    label: "Number of Positive CSAT Responses"
    filters: {
      field: satisfaction_level_score
      value: "=1"
    }
  }

  measure: CSAT_score {
    hidden: no
    view_label: "Metrics"
    type: average_distinct
    sql_distinct_key: ${id} ;;
    value_format: "0.0"
    label: "CSAT Score"
    sql: ${satisfaction_level_rating} ;;
  }

  measure: negative_responses {
    hidden: no
    view_label: "Metrics"
    type: count_distinct
    sql: ${id} ;;
    label: "Number of Negative CSAT Responses"
    filters: {
      field: satisfaction_level_score
      value: "=0"
    }
  }

  measure: positive_percentage {
    view_label: "Metrics"
    label: "% Positive CSAT"
    description: "% of conversations scored 'Positive' in the selected time period."
    type: number
    value_format: "0%"
    sql: ${positive_responses} / nullif(${total_responses},0);;
  }




# (count(satisfaction_level_score) - sum(satisfaction_level_score)) as Negative, sum(satisfaction_level_score) as Positive,
# count(satisfaction_level_score) as Total, round(100*(sum(satisfaction_level_score)  / count(satisfaction_level_score)),0) as AVG_Score

  set: detail {
    fields: [
      id,
      created_at_time,
      created_by,
      custom_issue_category_tree,
      customer_id,
      ended,
      name,
      priority,
      satisfaction_level_channel,
      satisfaction_level_created_at_time,
      satisfaction_level_rating,
      satisfaction_level_score,
      satisfaction_level_status,
      sentiment_confidence,
      sentiment_polarity,
      status,
      queue_id
    ]
  }
}
