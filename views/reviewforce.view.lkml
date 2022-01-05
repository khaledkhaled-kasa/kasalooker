view: reviewforce {
  derived_table: {
    sql: -- Table t2 will populate a new record for child categories with multiple records per reservation
      WITH t3 AS (
        WITH t2 AS (
              SELECT ConfirmationCode, parent_category, child_category
              FROM (
                SELECT ConfirmationCode,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') parent_category,
                REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') child_category
              FROM `bigquery-analytics-272822.Gsheets.reviewforce_categorization_clean` t1,
              UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t1), r'{|}', ''))) pair)

              WHERE NOT LOWER(parent_category) IN ('confirmationcode','assigned_categorizer','investigation_notes', 'investigation_status', 'issues_to_investigate', 'parent_category_issues_to_investigate','categorization_next_steps')
              and child_category != "null" -- Filters out all null category records
              )

      SELECT * EXCEPT(c) REPLACE(c AS child_category)
      FROM t2,
      UNNEST(SPLIT(child_category, "|")) c
              )

      SELECT t3.*, t4.*, TRIM(child_category) clean_child_category, -- trimming child category will ensure all white spaces are removed, especially in cases of multiple child category selections
      t5.Assigned_Categorizer, t5.Investigation_Status, t5.Issues_to_Investigate, t5.Parent_Category_Issues_to_Investigate, t5.Investigation_Notes, t5.Categorization_Next_Steps
      FROM t3 LEFT JOIN `bigquery-analytics-272822.Gsheets.reviewforce_responsibility_mapping` t4
      ON TRIM(t3.child_category) = t4.child_categories LEFT JOIN `bigquery-analytics-272822.Gsheets.reviewforce_categorization_clean` t5
      ON t3.ConfirmationCode = t5.ConfirmationCode
       ;;

    datagroup_trigger: reviewforce_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql:  CONCAT(${reservations_clean.confirmationcode},${TABLE}.parent_category, ${TABLE}.clean_child_category) ;;
  }


  dimension: confirmation_code {
    hidden: yes
    type: string
    sql: ${TABLE}.ConfirmationCode ;;
  }

  dimension: parent_category {
    type: string
    sql: ${TABLE}.parent_category ;;
  }


  dimension: child_category {
    type: string
    sql: ${TABLE}.clean_child_category ;;
  }

  dimension: feedback_type {
    type: string
    sql: ${TABLE}.Feedback_Type ;;
  }

  dimension: parent_categories {
    label: "Parent Categories (Responsibility Mapping)"
    hidden: yes
    type: string
    sql: ${TABLE}.Parent_Categories ;;
  }

  dimension: child_categories {
    label: "Child Categories (Responsibility Mapping)"
    hidden: yes
    type: string
    sql: ${TABLE}.Child_Categories ;;
  }

  dimension: tech_product_influence {
    type: yesno
    sql: ${TABLE}.Tech_Product_Influence ;;
  }

  dimension: ops_influence {
    type: yesno
    sql: ${TABLE}.Ops_Influence ;;
  }

  dimension: kasa_controlled {
    type: yesno
    sql: ${TABLE}.Kasa_Controlled ;;
  }

  dimension: assigned_categorizer {
    type: string
    sql: ${TABLE}.Assigned_Categorizer ;;
  }


  dimension: investigation_status {
    type: string
    sql: ${TABLE}.Investigation_Status ;;
  }

  dimension: investigation_notes {
    type: string
    sql: ${TABLE}.Investigation_Notes ;;
  }


  dimension: issues_to_investigate {
    type: string
    sql: ${TABLE}.Issues_to_Investigate ;;
  }

  dimension: parent_category_issues_to_investigate {
    type: string
    sql: ${TABLE}.Parent_Category_Issues_to_Investigate ;;
  }

  dimension: categorization_next_steps {
    type: string
    sql: ${TABLE}.Categorization_Next_Steps ;;
  }

  measure: count {
    label: "Count"
    description: "This will count the number of review force categories (parent/child)"
    type: count_distinct
    # sql_distinct_key: ${primary_key} ;;
    sql: ${primary_key} ;;
  }


}
