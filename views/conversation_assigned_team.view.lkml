view: conversation_assigned_team {
  derived_table: {
    sql:
        -- Create a conversation assigned team table that will pull the latest timestamp for each conversation assignee

    WITH CAT_MODIFIED AS (SELECT conversation_id, max(_fivetran_synced) _fivetran_synced
    FROM kustomer.conversation_assigned_team
    GROUP BY 1)
    SELECT conversation_assigned_team.* FROM kustomer.conversation_assigned_team
    JOIN CAT_MODIFIED ON conversation_assigned_team.conversation_id = CAT_MODIFIED.conversation_id AND conversation_assigned_team._fivetran_synced = CAT_MODIFIED._fivetran_synced
  ;;

    # persist_for: "1 hour"
      datagroup_trigger: kustomer_default_datagroup
      # indexes: ["night","transaction"]
      publish_as_db_view: yes

    }

    dimension_group: _fivetran_synced {
      hidden: yes
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
      sql: ${TABLE}._fivetran_synced ;;
    }

    dimension: conversation_id {
      type: string
      hidden: yes
      sql: ${TABLE}.conversation_id ;;
    }

    dimension: team_id {
      type: string
      hidden: yes
      sql: ${TABLE}.team_id ;;
    }


    # ----- Sets of fields for drilling ------
    set: detail {
      fields: [
        conversation.id,
        conversation.first_company_name,
        conversation.name,
        team.display_name,
        team.name,
        team.id
      ]
    }
  }
