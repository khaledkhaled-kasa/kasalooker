view: gx_scorecard {
  derived_table: {
    sql:

      WITH final_table AS
      (WITH latest_table3 AS
        (WITH latest_table2 AS
         (WITH latest_table AS
           (WITH percentile_table AS
            (WITH SKINNY_ALL_METRICS AS
              (WITH ALL_METRICS AS

                (WITH calls AS
                  (SELECT
                  CASE WHEN aircall_segment.properties.user.name = 'Vida Charra Relato' THEN 'Vida Relato'
                  WHEN aircall_segment.properties.user.name = 'Alfred James' THEN 'Alfred Sadueste'
                  WHEN aircall_segment.properties.user.name = 'Roan ' THEN 'Roan Litz'
                  WHEN aircall_segment.properties.user.name = "Sofie " THEN "Sofia Cruz"
                  WHEN aircall_segment.properties.user.name = "Charmagne " THEN "Charmagne Coston"
                  WHEN aircall_segment.properties.user.name = "Veronica " THEN "Veronica Hawkins"
                  WHEN aircall_segment.properties.user.name = 'Hallie Muscente' THEN "Hallie Knudsen"
                  WHEN aircall_segment.properties.user.name = "Mel  Doroteo" THEN "Mel Doroteo"
                  WHEN aircall_segment.properties.user.name = "Mel Baker" THEN "Melissa Baker"
                  WHEN aircall_segment.properties.user.name = 'Nikki Cardno' THEN 'Nicole Cardno'
                  WHEN aircall_segment.properties.user.name = 'Suzanne Hill' THEN 'Suzie Hill'
                  WHEN aircall_segment.properties.user.name = "Infiniti " THEN "Infiniti"
                  WHEN aircall_segment.properties.user.name = 'Katherine Chappell' THEN "Kate Chappell"
                  WHEN aircall_segment.properties.user.name = 'Patricia Tamayo' THEN "Pat Tamayo"
                  ELSE aircall_segment.properties.user.name
                  END  aircall_names,
                  COUNT(DISTINCT CASE WHEN (aircall_segment.properties.direction = 'inbound') AND (aircall_segment.event = 'call.hungup') THEN concat( aircall_segment.properties.id , aircall_segment.event  )  ELSE NULL END) AS inbound_calls,
                  COUNT(DISTINCT CASE WHEN (aircall_segment.properties.direction = 'outbound') AND (aircall_segment.event = 'call.hungup') THEN concat( aircall_segment.properties.id , aircall_segment.event  )  ELSE NULL END) AS outbound_calls
                  FROM `bigquery-analytics-272822.aircallsegment.track` AS aircall_segment
                  WHERE {% condition review_month %} TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_SECONDS(aircall_segment.properties.started_at), 'America/Los_Angeles')) {% endcondition %}
                  GROUP BY 1),

                  Hours AS
                  (SELECT CONCAT(ximble_master.First_Name," ",ximble_master.Last_Name) AS ximble_names,
                  ROUND(COALESCE(CAST((SUM(DISTINCT (CAST(ROUND(COALESCE(CASE WHEN  ximble_master.Shift_Label IS NULL OR
                  ((LOWER(ximble_master.Shift_Label) NOT LIKE "%project time%")
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE '%training class%')
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE "%culture amp%"))
                  THEN  ximble_master.Total_Hours  ELSE NULL END
                  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST(CASE WHEN  ximble_master.Shift_Label IS NULL OR
                  ((LOWER(ximble_master.Shift_Label) NOT LIKE "%project time%")
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE '%training class%')
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE "%culture amp%"))
                  THEN  CONCAT( (CAST(CAST(ximble_master.Date  AS TIMESTAMP) AS DATE)) ,
                  ( CONCAT(ximble_master.First_Name," ",ximble_master.Last_Name)
                  ), ximble_master.Start_Time , ximble_master.End_Time  )   ELSE NULL END
                  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(CASE WHEN  ximble_master.Shift_Label IS NULL OR
                  ((LOWER(ximble_master.Shift_Label) NOT LIKE "%project time%")
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE '%training class%')
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE "%culture amp%"))
                  THEN  CONCAT( (CAST(CAST(ximble_master.Date  AS TIMESTAMP) AS DATE)) ,(CONCAT(ximble_master.First_Name," ",ximble_master.Last_Name)), ximble_master.Start_Time , ximble_master.End_Time  )   ELSE NULL END
                  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST(CASE WHEN  ximble_master.Shift_Label IS NULL OR
                  ((LOWER(ximble_master.Shift_Label) NOT LIKE "%project time%")
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE '%training class%')
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE "%culture amp%"))
                  THEN  CONCAT( (CAST(CAST(ximble_master.Date  AS TIMESTAMP) AS DATE)) ,(CONCAT(ximble_master.First_Name," ",ximble_master.Last_Name)), ximble_master.Start_Time , ximble_master.End_Time  )   ELSE NULL END
                  AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST(CASE WHEN  ximble_master.Shift_Label IS NULL OR
                  ((LOWER(ximble_master.Shift_Label) NOT LIKE "%project time%")
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE '%training class%')
                  AND (LOWER(ximble_master.Shift_Label) NOT LIKE "%culture amp%"))
                  THEN  CONCAT( (CAST(CAST(ximble_master.Date  AS TIMESTAMP) AS DATE)) ,(CONCAT(ximble_master.First_Name," ",ximble_master.Last_Name)), ximble_master.Start_Time , ximble_master.End_Time  )   ELSE NULL END
                  AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS ximble_master_hours
                  FROM `ximble.ximble_master` AS ximble_master
                  WHERE {% condition review_month %} TIMESTAMP(ximble_master.Date) {% endcondition %}
                  AND ximble_master.Date <= current_date()
                  GROUP BY 1),

                  Messages_sent AS
                  (SELECT user.name  AS user_name, team.name  AS team_name,
                  COUNT(DISTINCT CASE WHEN (message.auto = false) AND (message.direction = 'out') THEN message.id  ELSE NULL END) AS conversation_messages_sent,
                  COUNT(DISTINCT CASE WHEN (message.auto = false) AND (message.direction = 'out') THEN message.conversation_id  ELSE NULL END) AS unique_conversations_messaged
                  FROM `kustomer.customer` AS customer
                  INNER JOIN `kustomer.conversation` AS conversation ON customer.id = conversation.customer_id
                  LEFT JOIN `kustomer.message` AS message ON conversation.id = message.conversation_id
                  LEFT JOIN `kustomer.user` AS user ON user.id = message.created_by
                  LEFT JOIN `kustomer.message_created_by_team` AS message_created_by_team ON message_created_by_team.message_id = message.id
                  LEFT JOIN `kustomer.team` AS team ON team.id =message_created_by_team.team_id
                  WHERE {% condition review_month %} TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', message.created_at , 'America/Los_Angeles')) {% endcondition %}
                  GROUP BY 1,2),

                  MFRT AS
                  (SELECT user.name AS user_name,  team.name  AS team_name,
                  CASE WHEN COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END) <= 10000 THEN (ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5 - 0.0000001) AS INT64))] + ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5) AS INT64))]) / 2 ELSE APPROX_QUANTILES(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'sms') THEN conversation.first_response_time /(60*1000) ELSE NULL END,1000)[OFFSET(500)] END AS MFRT_sms,
                    CASE WHEN COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END) <= 10000 THEN (ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5 - 0.0000001) AS INT64))] + ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5) AS INT64))]) / 2 ELSE APPROX_QUANTILES(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'email') THEN conversation.first_response_time /(60*1000) ELSE NULL END,1000)[OFFSET(500)] END AS MFRT_email,
                      CASE WHEN COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END) <= 10000 THEN (ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5 - 0.0000001) AS INT64))] + ARRAY_AGG(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END IGNORE NULLS ORDER BY CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END) * 0.5) AS INT64))]) / 2 ELSE APPROX_QUANTILES(CASE WHEN (conversation.first_response_time  > 0) AND (message.sent_at = conversation.first_response_sent_at) AND (message.auto = false) AND (message.direction = 'out') AND (message.channel = 'chat') THEN conversation.first_response_time /(60*1000) ELSE NULL END,1000)[OFFSET(500)] END AS MFRT_chat
                      FROM `kustomer.customer` AS customer
                      INNER JOIN `kustomer.conversation` AS conversation ON customer.id = conversation.customer_id
                      LEFT JOIN `kustomer.message` AS message ON conversation.id = message.conversation_id
                      LEFT JOIN `kustomer.user` AS user ON user.id = message.created_by
                      LEFT JOIN `kustomer.message_created_by_team` AS message_created_by_team ON message_created_by_team.message_id = message.id
                      LEFT JOIN `kustomer.team` AS team ON team.id =message_created_by_team.team_id
                      WHERE {% condition review_month %} TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', message.created_at , 'America/Los_Angeles')) {% endcondition %}
                      GROUP BY 1,2),

                      FCRR AS
                      (SELECT name, AVG(value) value
                      FROM Gsheets.kustomer_metrics
                      WHERE {% condition review_month %} TIMESTAMP(kustomer_metrics.date) {% endcondition %}
                      GROUP BY 1),


                      CSAT AS (WITH CAU AS (WITH CAU_MODIFIED AS (SELECT conversation_id, max(_fivetran_synced) _fivetran_synced
                      FROM kustomer.conversation_assigned_user
                      GROUP BY 1)
                      SELECT conversation_assigned_user.* FROM kustomer.conversation_assigned_user
                      JOIN CAU_MODIFIED ON conversation_assigned_user.conversation_id = CAU_MODIFIED.conversation_id AND conversation_assigned_user._fivetran_synced = CAU_MODIFIED._fivetran_synced),

                      CAT AS (WITH CAT_MODIFIED AS (SELECT conversation_id, max(_fivetran_synced) _fivetran_synced
                      FROM kustomer.conversation_assigned_team
                      GROUP BY 1)
                      SELECT conversation_assigned_team.* FROM kustomer.conversation_assigned_team
                      JOIN CAT_MODIFIED ON conversation_assigned_team.conversation_id = CAT_MODIFIED.conversation_id AND conversation_assigned_team._fivetran_synced = CAT_MODIFIED._fivetran_synced)

                      SELECT user.name  AS user_name, team.name  AS team_name,
                      COUNT(DISTINCT CASE WHEN (conversation_csat.satisfaction_level_score  = 1) THEN conversation_csat.id  ELSE NULL END) / NULLIF(COUNT(DISTINCT CASE WHEN (conversation_csat.satisfaction_level_score  >= 0) THEN conversation_csat.id  ELSE NULL END), 0) AS CSAT,
                      COUNT(DISTINCT CASE WHEN (conversation_csat.satisfaction_level_score  = 1) THEN conversation_csat.id  ELSE NULL END) AS CSAT_positive,
                      COUNT(DISTINCT CASE WHEN (conversation_csat.satisfaction_level_score  = 0) THEN conversation_csat.id  ELSE NULL END) AS CSAT_negative
                      FROM `kustomer.customer` AS customer_csat
                      INNER JOIN `kustomer.conversation` AS conversation_csat ON customer_csat.id = conversation_csat.customer_id
                      LEFT JOIN CAT AS conversation_assigned_team ON conversation_assigned_team.conversation_id = conversation_csat.id
                      LEFT JOIN `kustomer.team` AS team ON team.id = conversation_assigned_team.team_id
                      LEFT JOIN `kustomer.team_member` AS team_member ON team.id = team_member.team_id
                      LEFT JOIN CAU AS conversation_assigned_user ON conversation_assigned_user.conversation_id = conversation_csat.id
                      LEFT JOIN `kustomer.user` AS user ON (user.id = conversation_assigned_user.user_id) and (team_member.user_id = user.id)
                      WHERE {% condition review_month %} TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', conversation_csat.satisfaction_level_created_at , 'America/Los_Angeles')) {% endcondition %}
                      GROUP BY 1,2)

                      SELECT messages_sent.user_name, messages_sent.team_name,
                      unique_conversations_messaged, inbound_calls, outbound_calls, ximble_master_hours,
                      round(unique_conversations_messaged/nullif(ximble_master_hours,0),2) as unique_conversations_messaged_per_hour,
                      round(inbound_calls/nullif(ximble_master_hours,0),2) as inbound_calls_per_hour,
                      round(outbound_calls/nullif(ximble_master_hours,0),2) as outbound_calls_per_hour,
                      NULL AS interactions_per_hour,
                      round(MFRT_sms,2) AS MFRT_sms,
                      round(MFRT_email,2) AS MFRT_email,
                      round(MFRT_chat,2) AS MFRT_chat,
                      NULL as weighted_response_time,
                      round((FCRR.value),2) AS FCRR,
                      round(CSAT.CSAT,2) AS CSAT,
                      NULL as comms_quality_score,
                      NULL as total_score
                      from messages_sent LEFT JOIN Calls ON ((messages_sent.user_name = Calls.aircall_names))
                      LEFT JOIN Hours on ((messages_sent.user_name = Hours.ximble_names))
                      LEFT JOIN MFRT ON ((messages_sent.user_name = MFRT.user_name) AND (messages_sent.team_name = MFRT.team_name))
                      LEFT JOIN FCRR ON ((messages_sent.user_name = FCRR.NAME) )
                      LEFT JOIN CSAT ON ((messages_sent.user_name = CSAT.user_name) AND (messages_sent.team_name = CSAT.team_name))

                      WHERE {% condition team_name %} messages_sent.team_name {% endcondition %}
                      AND {% condition user_name_exclude %} messages_sent.user_name {% endcondition %}
                      )


                      SELECT user_name, team_name, metric, SAFE_CAST(value as FLOAT64) value
                      FROM (
                        SELECT user_name, team_name,
                        REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') metric,
                        REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
                        FROM ALL_METRICS,
                        UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(ALL_METRICS), r'{|}', ''))) pair
                        )
                        WHERE NOT LOWER(metric) IN ('user_name', 'team_name'))

                      SELECT user_name, team_name, SKINNY_ALL_METRICS.metric as skinny_metric, value,
                      CASE WHEN value is NULL then NULL
                      WHEN category = 'Efficiency' THEN rank () OVER (partition by SKINNY_ALL_METRICS.metric, (CASE WHEN value is NOT NULL THEN 2 ELSE 1 END)  order by value asc)
                      WHEN category IN ('Productivity', 'Quality (External) - Hospitality / Brand') THEN rank () OVER (partition by SKINNY_ALL_METRICS.metric order by value desc)
                      END rank,
                      round(avg(value) OVER (partition by SKINNY_ALL_METRICS.metric),3) as avg_skin,
                      round(PERCENTILE_CONT(value, 0.75) OVER(partition by SKINNY_ALL_METRICS.metric),3) AS percentile75,
                      round(PERCENTILE_CONT(value, 0.25) OVER(partition by SKINNY_ALL_METRICS.metric),3) AS percentile25,
                      CASE WHEN category = 'Efficiency' THEN round(PERCENTILE_CONT(value, 0.25) OVER(partition by SKINNY_ALL_METRICS.metric),3)
                      WHEN category IN ('Productivity', 'Quality (External) - Hospitality / Brand') THEN round(PERCENTILE_CONT(value, 0.75) OVER(partition by SKINNY_ALL_METRICS.metric),3)
                      ELSE NULL
                      END top_25_percentile,
                      weights_targets.*,
                      CASE
                      WHEN (category = 'Efficiency' and value <= PERCENTILE_CONT(value, 0.25) OVER(PARTITION BY SKINNY_ALL_METRICS.metric)) THEN value
                      WHEN (category IN ('Productivity', 'Quality (External) - Hospitality / Brand') and value >= PERCENTILE_CONT(value, 0.75) OVER(PARTITION BY SKINNY_ALL_METRICS.metric)) THEN value
                      ELSE NULL END top_25_percentile_candidate,
                      from SKINNY_ALL_METRICS
                      LEFT JOIN Gsheets.weights_targets ON weights_targets.metric_looker = SKINNY_ALL_METRICS.metric)

                      SELECT percentile_table.*, percentile_table.target preset_target, percentile_table.target_sgxs preset_target_sgxs,
                      CASE
                      WHEN (percentile_table.team_name = 'Guest Experience' AND percentile_table.target is not null) THEN percentile_table.target
                      WHEN (percentile_table.team_name = 'SGXS' AND percentile_table.target_sgxs is not null) THEN percentile_table.target_sgxs
                      ELSE top_25_percentile
                      END top_25_percentile_or_preset,
                      CASE
                      WHEN (percentile_table.team_name = 'Guest Experience' AND percentile_table.target is not null) THEN percentile_table.target
                      WHEN (percentile_table.team_name = 'SGXS' AND percentile_table.target_sgxs is not null) THEN percentile_table.target_sgxs
                      ELSE round(AVG(top_25_percentile_candidate) OVER (PARTITION BY percentile_Table.skinny_metric),3)
                      END AVG_top_25_percentile
                      from percentile_table)

                      SELECT latest_table.*,
                      CASE WHEN category = 'Efficiency' THEN round(((top_25_percentile_or_preset - value) / top_25_percentile_or_preset),3)
                      WHEN category IN ('Productivity', 'Quality (External) - Hospitality / Brand') THEN round(((value - top_25_percentile_or_preset) / top_25_percentile_or_preset),3)
                      END GX_Diff_Target,
                      CASE WHEN category = 'Efficiency' THEN round(((AVG_top_25_percentile - value) / AVG_top_25_percentile),3)
                      WHEN category IN ('Productivity', 'Quality (External) - Hospitality / Brand') THEN round(((value - AVG_top_25_percentile) / AVG_top_25_percentile),3)
                      END GX_Diff_Target_avg_percentile,
                      CASE WHEN category = 'Efficiency' THEN round(((latest_table.avg_skin - value) / latest_table.avg_skin),3)
                      WHEN category IN ('Productivity', 'Quality (External) - Hospitality / Brand') THEN round(((value - latest_table.avg_skin) / latest_table.avg_skin),3)
                      END GX_Diff_Avg
                      FROM latest_table)

                      SELECT latest_table2.*,
                      CASE WHEN (GX_DIFF_Target is null and skinny_metric IN ("interactions_per_hour","comms_quality_score","weighted_response_time")) THEN ROUND(Sum(gx_diff_target*metric_weight) OVER (partition by user_name, Category),3)
                      ELSE NULL
                      END gx_diff_target_high_level_unweighted,
                      CASE WHEN (GX_DIFF_Target is null and Category = 'All') THEN ROUND(Sum(gx_diff_target*simplified_rate) OVER (partition by user_name),3)
                      WHEN (GX_DIFF_Target is null and skinny_metric IN ("interactions_per_hour","comms_quality_score","weighted_response_time","total_score")) THEN ROUND(Sum(gx_diff_target*simplified_rate) OVER (partition by user_name, Category),3)
                      ELSE NULL
                      END gx_diff_target_high_level
                      from latest_table2)

                      SELECT latest_table3.*,
                      CASE WHEN (skinny_metric IN ("interactions_per_hour","comms_quality_score","weighted_response_time","total_score") AND gx_diff_target_high_level is not null) THEN RANK() OVER (partition by skinny_metric order by gx_diff_target_high_level desc)
                      ELSE rank
                      END final_rank
                      FROM latest_table3)

                      select final_table.*
                      FROM final_table ;;

      persist_for: "1 hours"

    }


    filter: review_month {
      label: "Review Date"
      type: date
      convert_tz: no
    }


    filter: team_name {
      type: string
    }

    filter: user_name_exclude {
      label: "Excluded User Name"
      type: string
    }

    dimension: user_name {
      type: string
      sql: ${TABLE}.user_name ;;
      html: {% if  weight_from_metric._value >= 1 %}
            <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
            {% else %}
            <p style="color: black; font-size:100%">{{ rendered_value }}</p>
            {% endif %} ;;
    }

    dimension: team {
      type: string
      sql: ${TABLE}.team_name ;;

    }


    dimension: skinny_metric {
      type: string
      sql: ${TABLE}.skinny_metric ;;

    }

    dimension: actual {
      type: number
      value_format: "0.00"
      sql: ${TABLE}.value ;;
      html: {% if  weight_from_metric._value >= 1 %}
            <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
            {% else %}
            <p style="color: black; font-size:100%">{{ rendered_value }}</p>
            {% endif %} ;;
    }


    dimension: rank {
      label: "Individual Metric Rank"
      type: number
      sql: ${TABLE}.rank ;;
      html: {% if  weight_from_metric._value >= 1 %}
            <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
            {% else %}
            <p style="color: black; font-size:100%">{{ rendered_value }}</p>
            {% endif %} ;;
    }

    dimension: team_average_actual {
      label: "Team Average"
      type: number
      value_format: "0.00"
      sql: ${TABLE}.avg_skin ;;
      html: {% if  weight_from_metric._value >= 1 %}
            <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
            {% else %}
            <p style="color: black; font-size:100%">{{ rendered_value }}</p>
            {% endif %} ;;
    }

    dimension: percentile75 {
      type: number
      sql: ${TABLE}.percentile75 ;;
      hidden: yes
      # html: {% if  weight_from_metric._value >= 1 %}
      # <p style="color: black; background-color: #819AC9; font-size:110%"><b>{{ rendered_value }}</b></p>
      # {% else %}
      # <p style="color: black; font-size:100%">{{ rendered_value }}</p>
      # {% endif %} ;;
    }

    dimension: percentile25 {
      type: number
      hidden: yes
      sql: ${TABLE}.percentile25 ;;
      # html: {% if  weight_from_metric._value >= 1 %}
      # <p style="color: black; background-color: #819AC9; font-size:110%"><b>{{ rendered_value }}</b></p>
      # {% else %}
      # <p style="color: black; font-size:100%">{{ rendered_value }}</p>
      # {% endif %} ;;
    }

    dimension: top_percentile {
      type: number
      label: "Target (Top / Preset)"
      description: "This will show the target for individual metrics by either pulling the top 25% or 75% percentile (depending on the category) or pulling from the manual preset values on the GSheet."
      sql:
          ${TABLE}.top_25_percentile_or_preset ;;
          # html: {% if  weight_from_metric._value >= 1 %}
          # <p style="color: black; background-color: #819AC9; font-size:110%"><b>{{ rendered_value }}</b></p>
          # {% else %}
          # <p style="color: black; font-size:100%">{{ rendered_value }}</p>
          # {% endif %} ;;
      }

      dimension: metric {
        type: string
        sql: ${TABLE}.Metric ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: metric_looker {
        hidden: yes
        type: string
        sql: ${TABLE}.Metric_Looker ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: category {
        type: string
        sql: ${TABLE}.Category ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: weight_category {
        label: "Category Weight"
        type: number
        value_format: "0%"
        sql: ${TABLE}.Category_Weight ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: weight_from_metric {
        label: "Metric Weight"
        type: number
        value_format: "0%"
        sql: ${TABLE}.Metric_Weight ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: weight_from_total {
        type: number
        value_format: "0%"
        sql: ${TABLE}.Simplified_Rate ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: target_from_gsheet {
        type: number
        hidden: yes
        sql: ${TABLE}.Target ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: preset_targets {
        type: number
        hidden: yes
        sql: ${TABLE}.preset_target ;;
      }


      dimension: top_25_percentile {
        label: "Target (Top 25 Percentile)"
        description: "This will show the target for individual metrics by either pulling the top 25% or 75% percentile (depending on the category) or pulling from the manual preset values on the GSheet."
        type: number
        hidden: yes
        value_format: "0.00"
        sql: ${TABLE}.top_25_percentile ;;
        html: {% if  weight_from_metric._value >= 1 %}
          <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
          {% else %}
          <p style="color: black; font-size:100%">{{ rendered_value }}</p>
          {% endif %} ;;
      }

      dimension: top_percentile_avg {
        label: "Target (Avg. Top 25 Percentile)"
        description: "This will show the target for individual metrics by either calculating the average of the top 25% or 75% percentile (depending on the category) or pulling from the manual preset values on the GSheet."
        type: number
        hidden: yes
        value_format: "0.00"
        sql: ${TABLE}.AVG_top_25_percentile ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: GX_diff_target {
        label: "% Difference from Target"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.GX_Diff_Target ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: GX_diff_avg {
        label: "% Difference from Average"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.GX_Diff_Avg ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: GX_category_score {
        label: "Category Score"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.gx_diff_target_high_level_unweighted ;;
        html: {% if  weight_from_metric._value >= 1 %}
          <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
          {% else %}
          <p style="color: black; font-size:100%">{{ rendered_value }}</p>
          {% endif %} ;;
      }


      dimension: GX_category_score_weighted {
        label: "Category Score (Weighted)"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.gx_diff_target_high_level ;;
        html: {% if  weight_from_metric._value >= 1 %}
              <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
              {% else %}
              <p style="color: black; font-size:100%">{{ rendered_value }}</p>
              {% endif %} ;;
      }

      dimension: final_rank {
        label: "Rank"
        type: number
        sql: ${TABLE}.final_rank ;;
        html: {% if  weight_from_metric._value >= 1 %}
                 <p style="color: black; font-size:110%"><b>{{ rendered_value }}</b></p>
                 {% else %}
                   <p style="color: black; font-size:100%">{{ rendered_value }}</p>
                 {% endif %} ;;
      }



      measure: GX_category_score_measure {
        label: "GXer Category Score"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.gx_diff_target_high_level_unweighted ;;
      }

      measure: GX_category_score_measure_weighted {
        label: "GXer Category Score (Weighted)"
        type: number
        value_format: "0.0%"
        hidden: no
        sql: ${TABLE}.gx_diff_target_high_level ;;
      }

      measure: final_rank_measure {
        label: "Rank"
        type: number
        sql: ${TABLE}.final_rank ;;

      }


    }
