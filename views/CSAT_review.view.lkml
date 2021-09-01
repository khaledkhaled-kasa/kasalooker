view: csat_review {
    derived_table: {
      sql:

  WITH grouped_confirmation_code AS (

  SELECT reservations_kustomer.confirmationcode  AS confirmationcode, conversation.satisfaction_level_first_answer  AS conversation_satisfaction_level_answer
  FROM `kustomer.customer` AS customer
  INNER JOIN ${conversation.SQL_TABLE_NAME} AS conversation
  ON customer.id = conversation.customer_id
  LEFT JOIN ${kobject_reservation.SQL_TABLE_NAME} AS kobject_reservation
  ON conversation.kobject_id_mapped = kobject_reservation.id
  LEFT JOIN `bigquery-analytics-272822.dbt.reservations_v3`   AS reservations_kustomer
  ON reservations_kustomer.confirmationcode = kobject_reservation.custom_confirmation_code_str
  WHERE LENGTH(conversation.satisfaction_level_first_answer ) > 10 AND (conversation.satisfaction_level_first_answer ) IS NOT NULL AND (reservations_kustomer.confirmationcode ) IS NOT NULL
  GROUP BY
    1,2)

  SELECT confirmationcode, STRING_AGG(conversation_satisfaction_level_answer,'|') CSAT_Review
  FROM grouped_confirmation_code
  GROUP BY 1 ;;


      }


      dimension: confirmationcode {
        hidden: yes
        type: string
        sql: ${TABLE}.confirmationcode ;;
        primary_key: yes
      }

      dimension: csat_review {
        label: "CSAT Review"
        type: string
        hidden: yes
        sql: ${TABLE}.csat_review ;;
      }

    }
