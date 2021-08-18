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

              WHERE NOT LOWER(parent_category) IN ('confirmationcode')
              and child_category != "null" -- Filters out all null category records
              )

      SELECT * EXCEPT(c) REPLACE(c AS child_category)
      FROM t2,
      UNNEST(SPLIT(child_category, "|")) c
              )

      SELECT *, TRIM(child_category) clean_child_category -- trimming child category will ensure all white spaces are removed, especially in cases of multiple child category selections
      FROM t3 LEFT JOIN `bigquery-analytics-272822.Gsheets.reviewforce_responsibility_mapping` t4
      ON TRIM(t3.child_category) = t4.child_categories
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


  measure: count {
    label: "Count"
    description: "This will count the number of review force categories (parent/child)"
    type: count_distinct
    # sql_distinct_key: ${primary_key} ;;
    sql: ${primary_key} ;;
  }


}
