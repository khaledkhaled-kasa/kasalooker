view: kontrol_giga_search_hit {
    label: "Giga Query Result Hit"
    sql_table_name: `bigquery-analytics-272822.website_kontrol.giga_search_hit` ;;


    dimension: id {
      type: string
      sql: ${TABLE}.id ;;
      primary_key: yes
      hidden: yes
    }

    dimension: result_type_clicked {
      type: string
      sql: ${TABLE}.result_type_clicked;;
    }

    dimension_group: timestamp {
      type: time
      sql: ${TABLE}.original_timestamp ;;
    }
    measure: count {
      type: count_distinct
      sql: ${id} ;;
      drill_fields: [detail*]
    }


    set: detail {
      fields: [id, result_type_clicked , timestamp_time]
    }
  }
