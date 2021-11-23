view: pom_qa_walkthrough_survey_agg {
  derived_table: {
    sql:

    WITH c1 AS (SELECT Timestamp, DATE(Timestamp) as VisitDate, Building, Door_No_, Building || '-' || Door_No_ as Unit, POM_Name,
      RANK() OVER (PARTITION BY CONCAT(Building,Door_No_) ORDER BY Timestamp desc) visit_recency_rank
      FROM ${pom_qa_walkthrough_survey.SQL_TABLE_NAME}
      Group By 1,2,3,4,5,6),

      MostRecentQA AS (SELECT Unit, POM_NAME MostRecentPOM, MAX(VisitDate) as MostRecentQA
      FROM c1
      WHERE visit_recency_rank = 1
      GROUP BY 1,2)

      SELECT c.*, ref.MostRecentPOM, ref.MostRecentQA
      FROM c1 c
        LEFT JOIN MostRecentQA ref
        ON c.Unit = ref.Unit
      ;;
    persist_for: "4 hours"
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${unit} || CAST(${visit_date} as STRING) ;;
  }

  dimension: visit_date {
    type: date
    datatype: date
    sql: ${TABLE}.VisitDate ;;
  }

  dimension: most_recent_qa {
    label: "Most Recent QA Visit"
    type: date
    datatype: date
    sql: ${TABLE}.MostRecentQA ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.Unit ;;
  }

  dimension: pom_name {
    type: string
    sql: ${TABLE}.POM_Name ;;
  }

  dimension: pom_name_most_recent {
    label: "Most Recent QA POM"
    sql: ${TABLE}.MostRecentPOM ;;
  }

}
