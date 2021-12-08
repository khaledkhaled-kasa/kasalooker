view: playvox {
  derived_table: {
    sql: WITH users AS (SELECT email,concat(name," ",last_name) full_name,id  FROM `bigquery-analytics-272822.playvox.users`)

      SELECT sequence, u1.full_name agent_name, u2.full_name evaluated_by, created_at, evaluation_time evaluation_time_mins, score, schedule_date, score_avg, evaluations.scorecard_id, status,
      total_errors, u1.email agent_email, u2.email evaluated_by_email, scorecard_name_looker, scorecard_name
      FROM `bigquery-analytics-272822.playvox.evaluations` evaluations
      LEFT JOIN users u1 ON u1.id = evaluations.agent_id
      LEFT JOIN users u2 ON u2.id = evaluations.monitor_id
      LEFT JOIN `bigquery-analytics-272822.playvox.playvox_scorecard_names_final` scorecard_names ON evaluations.scorecard_id = scorecard_names.scorecard_id
      where status = 'active'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
      ORDER BY evaluations.sequence desc
       ;;
  }


  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  dimension: agent_name {
    type: string
    sql: ${TABLE}.agent_name ;;
  }

  dimension: evaluated_by {
    type: string
    sql: ${TABLE}.evaluated_by ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: evaluation_time {
    label: "Evaluation Time (Mins)"
    type: string
    sql: ${TABLE}.evaluation_time_mins ;;
  }


  dimension_group: schedule_date {
    type: time
    sql: ${TABLE}.schedule_date ;;
  }

  dimension: score_avg {
    type: number
    value_format: "00.0%"
    sql: ${TABLE}.score_avg/100 ;;
  }

  dimension: scorecard_id {
    type: string
    sql: ${TABLE}.scorecard_id ;;
  }

  dimension: scorecard_name {
    type: string
    sql: ${TABLE}.scorecard_name_looker ;;
  }

  dimension: scorecard_name_raw {
    label: "Scorecard Name (Raw)"
    type: string
    sql: ${TABLE}.scorecard_name ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: total_errors {
    type: number
    sql: ${TABLE}.total_errors ;;
  }

  dimension: agent_email {
    type: string
    sql: ${TABLE}.agent_email ;;
  }

  dimension: evaluated_by_email {
    type: string
    sql: ${TABLE}.evaluated_by_email ;;
  }

}
