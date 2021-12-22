view: CI_feedback_sms_kustomer {
  view_label: "CI Feedback SMS (Mid Trip)"
  derived_table: {
    sql:
    With CI_feedback_Kustomer AS(
          Select c.id, c.name ,m.id as message_id
          , m.preview, m.direction,m.created_at, rank() over (partition by c.name  order by
          safe_cast(
          m.created_at as timestamp)
          ) as rank
          FROM `bigquery-analytics-272822.kustomer.conversation`c
          LEFT JOIN    `bigquery-analytics-272822.kustomer.message` m
          on
          c.id=m.conversation_id
          WHERE ( c.name LIKE '%Auto CI Feedback:%' OR  c.name LIKE '%Auto CI Feedback Expanded:%' OR c.name LIKE '%Auto CI Feedback Standard%') and m.direction="in"
          ) ,
           feedback as
          (
          SELECT
          id,
          name,
          message_id,
          preview,
          RANK,
          CASE WHEN RANK=1 AND
          LEFT(preview,1) IN ('1','2','3','4','5')
          then left(preview,1)
          WHEN RANK=1 AND preview IN
          ('Great!','Fine','Could be better') THEN preview
          ELSE NULL END AS
          CI_score_SMS
          from CI_feedback_Kustomer
          where rank=1
          ),
          string_feedback AS
          (SELECT
          id,
          STRING_AGG(preview  ORDER BY name) AS feedback_Text_sms,
          from
          CI_feedback_Kustomer
          where rank =2 or rank=3
          GROUP BY id
          )
          SELECT
          LTRIM(split(a.name,":")[OFFSET (1)]) AS confirmationcode, a.id as conversation_id,a.CI_score_SMS, b.feedback_Text_sms,
          FROM
          feedback a
          LEFT join
          string_feedback  b
          ON
          a.id=b.id
       ;;
      persist_for: "2 hours"
  }


  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
    hidden: yes
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: ci_score_sms {
    label: "CI Score(SMS)"
    description: "This feedback Score pulled from Kustomer conversation"
    type: string
    sql: CASE WHEN ${TABLE}.CI_score_SMS IN ('Great!','great!','great','Great') THEN "3"
    WHEN ${TABLE}.CI_score_SMS IN ("Fine","fine", "Fine, could be better","Could be better") THEN "2"
    WHEN ${TABLE}.CI_score_SMS IN ("Not going well","NOT going well","not going well") THEN "1"
  Else ${TABLE}.CI_score_SMS END;;

  }

  dimension: feedback_sms {
    label: "Text Feedback (SMS)"
    description: "This feedback pulled from Kustomer conversation"
    type: string
    sql: ${TABLE}.feedback_Text_sms;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }
  measure: count_CI_SMS_Feedback {
    type: count_distinct
    drill_fields: [detail*]
  }

  set: detail {
    fields: [confirmationcode, conversation_id, ci_score_sms, feedback_sms, name]
  }
}
