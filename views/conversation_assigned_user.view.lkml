view: conversation_assigned_user {
  derived_table: {
    sql:
        -- Create a conversation assigned user table that will pull the latest timestamp for each conversation assignee

    WITH CAU_MODIFIED AS (SELECT conversation_id, max(_fivetran_synced) _fivetran_synced
    FROM kustomer.conversation_assigned_user
    GROUP BY 1)
    SELECT conversation_assigned_user.* FROM kustomer.conversation_assigned_user
    JOIN CAU_MODIFIED ON conversation_assigned_user.conversation_id = CAU_MODIFIED.conversation_id AND conversation_assigned_user._fivetran_synced = CAU_MODIFIED._fivetran_synced
  ;;

    # persist_for: "1 hour"
      datagroup_trigger: kustomer_default_datagroup
      # indexes: ["night","transaction"]
      publish_as_db_view: yes

    }

    dimension_group: _fivetran_synced {
      type: time
      hidden: yes
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}._fivetran_synced ;;
    }

    dimension: conversation_id {
      type: string
      hidden: yes
      sql: ${TABLE}.conversation_id ;;
    }

    dimension: user_id {
      type: string
      hidden: yes
      sql: ${TABLE}.user_id ;;
    }


    # ----- Sets of fields for drilling ------
    set: detail {
      fields: [
        user.display_name,
        user.name,
        user.id,
        conversation.id,
        conversation.first_company_name,
        conversation.name
      ]
    }
  }
