view: kontrol_giga_search_query {
  label: "Giga Search Query"
 sql_table_name: `bigquery-analytics-272822.website_kontrol.giga_search_query` ;;


    dimension: id {
      type: string
      sql: ${TABLE}.id ;;
      primary_key: yes
      hidden: yes
    }

    dimension: search_keyword {
      type: string
      sql: ${TABLE}.search_keyword ;;
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
      fields: [id, search_keyword, timestamp_time]
    }
  }
