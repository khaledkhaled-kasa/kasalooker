view: pom_qa_walkthrough_survey {
  derived_table: {
    sql:

  -- New derived table created on May-04 to add tiers to scores
  WITH aggregated_survey AS (WITH pom_qa_walkthrough_survey AS (
    WITH Skinny_POM_Checklist AS (

  -- Table T will be a recreation of the Survey while replacing commas in relevant columns with a hyphen to avoid issues in downstream analysis
  WITH t AS (
    SELECT * REPLACE(
    REPLACE(Wrap_Up___New_Clean_Required_Areas,',','-') AS Wrap_Up___New_Clean_Required_Areas,
    REPLACE(Kitchen___Glasses,',','-') AS Kitchen___Glasses,
    REPLACE(Bedroom___Closet_Stocking,',','-') AS Bedroom___Closet_Stocking,
    REPLACE(WO_Details___WO_Issues,',','-') AS WO_Details___WO_Issues)
    FROM `bigquery-analytics-272822.Gsheets.POM_QA_Walkthrough_Survey`)

  SELECT TIMESTAMP, Email_address,POM_Name, Building, Door_No_,
  column_name, value
  FROM (
  SELECT TIMESTAMP, Email_address,POM_Name, Building, Door_No_,
    REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') column_name,
    REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
  FROM t,
  UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
  )
  WHERE NOT LOWER(column_name) IN ('timestamp', 'email_address', 'pom_name', 'building','door_no_'))
  select Skinny_POM_Checklist.*, checklist_weights.question, checklist_weights.Section, checklist_weights.Weight
  from Skinny_POM_Checklist JOIN `bigquery-analytics-272822.Gsheets.POM_QA_Walkthrough_Weights` checklist_weights
  ON Skinny_POM_Checklist.column_name = checklist_weights.column_name)

SELECT
    (FORMAT_TIMESTAMP('%F %T', pom_qa_walkthrough_survey.TIMESTAMP )) AS pom_qa_walkthrough_survey_submitdate_time,
    pom_qa_walkthrough_survey.POM_Name  AS pom_qa_walkthrough_survey_pom_name,
    pom_qa_walkthrough_survey.Email_address  AS pom_qa_walkthrough_survey_email_address,
        COALESCE(SUM(CASE
    WHEN pom_qa_walkthrough_survey.value IN ('Yes- high dusting was completed','No - there were no items left behind from the previous guest under the bed.',
    'Cabinets are organized and well stocked','Blanket- sheets and pillows for sofa bed are stocked properly.',
    'Shower liner is clean and in good condition?','No there were not items left behind from the previous guest.',
    'All appliances are clean', 'All areas have been sanitized', 'Windows are streak free and clear',
    'The sink was cleaned out properly. Individually wrapped is present and clean.', "No Items were left behind from the previous guest") THEN pom_qa_walkthrough_survey.Weight

    WHEN pom_qa_walkthrough_survey.value = "Yes" AND pom_qa_walkthrough_survey.column_name IN ("Living_Room___Carpet", "Balcony___Cleanliness", "Living_Room___Sofa", "Living_Room___Ceiling_Fan", "Kitchen___Glasses",
    "Kitchen___Dishwasher") THEN pom_qa_walkthrough_survey.Weight

    WHEN pom_qa_walkthrough_survey.value = "true" AND pom_qa_walkthrough_survey.column_name IN ("Wall_to_Wall___Scuffs_and_Spots", "Living_Room___Vents", "Living_Room___Non_carpeted_Floors",
    "Living_Room___Dust", "Laundry_Room___Stocking_Supplies_Par_Levels", "Kitchen___Stocking_Supplies_Par_Levels", "Kitchen___Microwave",
    "Kitchen___Essential_Stocking_Items_", "Kitchen___Coffeemaker", "Bedroom___Bed_Stains", "Bathroom___Stocking_Supplies") THEN pom_qa_walkthrough_survey.Weight

    WHEN pom_qa_walkthrough_survey.value = "No" AND pom_qa_walkthrough_survey.column_name IN ("Bathroom___Shower_Liner","Bathroom___Drawers", "Bedroom___Under_Bed", "Bedroom___Carpet", "Balcony___Smoking",
    "Bedroom___Fan_Blades", "Kitchen___Drawers", "Living_Room___Fan_Blades") THEN pom_qa_walkthrough_survey.Weight

    WHEN pom_qa_walkthrough_survey.value = "false" AND pom_qa_walkthrough_survey.column_name IN ("Bedroom___Linen_and_Pillow_Cases", "Bathroom___Vents", "Bathroom___Hair_Removal") THEN pom_qa_walkthrough_survey.Weight
    WHEN pom_qa_walkthrough_survey.value LIKE '%N/A%' OR pom_qa_walkthrough_survey.value = "null" THEN NULL
    ELSE 0
    END), 0) / nullif(COALESCE(SUM(( CASE WHEN pom_qa_walkthrough_survey.value LIKE '%N/A%' OR pom_qa_walkthrough_survey.value = "null" THEN NULL
    ELSE pom_qa_walkthrough_survey.Weight
    END ) ), 0), 0) AS pom_qa_walkthrough_survey_total_score
FROM pom_qa_walkthrough_survey
GROUP BY
    1,
    2,
    3),
    Skinny_POM_Checklist AS (

  -- Table T will be a recreation of the Survey while replacing commas in relevant columns with a hyphen to avoid issues in downstream analysis
  WITH t AS (
    SELECT * REPLACE(
    REPLACE(Wrap_Up___New_Clean_Required_Areas,',','-') AS Wrap_Up___New_Clean_Required_Areas,
    REPLACE(Kitchen___Glasses,',','-') AS Kitchen___Glasses,
    REPLACE(Bedroom___Closet_Stocking,',','-') AS Bedroom___Closet_Stocking,
    REPLACE(WO_Details___WO_Issues,',','-') AS WO_Details___WO_Issues)
    FROM `bigquery-analytics-272822.Gsheets.POM_QA_Walkthrough_Survey`)

  SELECT TIMESTAMP, Email_address,POM_Name, Building, Door_No_,
  column_name, value
  FROM (
  SELECT TIMESTAMP, Email_address,POM_Name, Building, Door_No_,
    REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(0)], r'^"|"$', '') column_name,
    REGEXP_REPLACE(SPLIT(pair, ':')[SAFE_OFFSET(1)], r'^"|"$', '') value
  FROM t,
  UNNEST(SPLIT(REGEXP_REPLACE(to_json_string(t), r'{|}', ''))) pair
  )
  WHERE NOT LOWER(column_name) IN ('timestamp', 'email_address', 'pom_name', 'building','door_no_'))
  select Skinny_POM_Checklist.*, checklist_weights.question, checklist_weights.Section, checklist_weights.Weight,
  aggregated_survey.*
  from Skinny_POM_Checklist JOIN `bigquery-analytics-272822.Gsheets.POM_QA_Walkthrough_Weights` checklist_weights
  ON Skinny_POM_Checklist.column_name = checklist_weights.column_name
  LEFT JOIN aggregated_survey ON (FORMAT_TIMESTAMP('%F %T', Skinny_POM_Checklist.timestamp)) = aggregated_survey.pom_qa_walkthrough_survey_submitdate_time
  AND Skinny_POM_Checklist.POM_Name = aggregated_survey.pom_qa_walkthrough_survey_pom_name
  AND Skinny_POM_Checklist.Email_address = aggregated_survey.pom_qa_walkthrough_survey_email_address

    ;;

    datagroup_trigger: pom_checklist_default_datagroup
    # indexes: ["night","transaction"]
    publish_as_db_view: yes
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${submitdate_time} ;;
  }

  dimension_group: submitdate {
    label: "Submission"
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
    sql: ${TABLE}.TIMESTAMP ;;
    convert_tz: no
  }

  dimension: Email_address {
    label: "E-mail"
    type: string
    sql: ${TABLE}.Email_address ;;
  }

  dimension: POM_Name {
    label: "POM"
    type: string
    sql: ${TABLE}.POM_Name ;;
  }

  dimension: Building {
    hidden: no
    label: "Property Code"
    type: string
    sql: ${TABLE}.Building ;;
  }

  dimension: property_code_3_letter {
    hidden: no
    label: "Property Code (3 Letter)"
    type: string
    sql: LEFT(${TABLE}.Building,3) ;;
  }

  dimension: Door {
    hidden: yes
    type: string
    sql: ${TABLE}.Door_No_ ;;
  }

  dimension: Unit {
    type: string
    sql: CONCAT(${Building},"-",${Door}) ;;
  }

  dimension: Q {
    hidden: no
    label: "Short Q"
    type: string
    sql: ${TABLE}.column_name ;;
  }

  dimension: survey_response {
    label: "Survey Response"
    type: string
    sql: ${TABLE}.value ;;
  }

  dimension: Question {
    hidden: no
    label: "Survey Question"
    type: string
    sql: ${TABLE}.question ;;
  }

  dimension: section {
    label: "Survey Section"
    type: string
    sql: ${TABLE}.Section ;;
  }

  dimension: weight {
    type: number
    sql:  ${TABLE}.Weight;;
  }

  dimension: response_answer {
    type: number
    sql:  CASE
    WHEN ${survey_response} IN ('Yes- high dusting was completed','No - there were no items left behind from the previous guest under the bed.',
    'Cabinets are organized and well stocked','Blanket- sheets and pillows for sofa bed are stocked properly.',
    'Shower liner is clean and in good condition?','No there were not items left behind from the previous guest.',
    'All appliances are clean', 'All areas have been sanitized', 'Windows are streak free and clear',
    'The sink was cleaned out properly. Individually wrapped is present and clean.', "No Items were left behind from the previous guest") THEN ${TABLE}.Weight

    WHEN ${survey_response} = "Yes" AND ${Q} IN ("Living_Room___Carpet", "Balcony___Cleanliness", "Living_Room___Sofa", "Living_Room___Ceiling_Fan", "Kitchen___Glasses",
    "Kitchen___Dishwasher") THEN ${TABLE}.Weight

    WHEN ${survey_response} = "true" AND ${Q} IN ("Wall_to_Wall___Scuffs_and_Spots", "Living_Room___Vents", "Living_Room___Non_carpeted_Floors",
    "Living_Room___Dust", "Laundry_Room___Stocking_Supplies_Par_Levels", "Kitchen___Stocking_Supplies_Par_Levels", "Kitchen___Microwave",
    "Kitchen___Essential_Stocking_Items_", "Kitchen___Coffeemaker", "Bedroom___Bed_Stains", "Bathroom___Stocking_Supplies") THEN ${TABLE}.Weight

    WHEN ${survey_response} = "No" AND ${Q} IN ("Bathroom___Shower_Liner","Bathroom___Drawers", "Bedroom___Under_Bed", "Bedroom___Carpet", "Balcony___Smoking",
    "Bedroom___Fan_Blades", "Kitchen___Drawers", "Living_Room___Fan_Blades") THEN ${TABLE}.Weight

    WHEN ${survey_response} = "false" AND ${Q} IN ("Bedroom___Linen_and_Pillow_Cases", "Bathroom___Vents", "Bathroom___Hair_Removal") THEN ${TABLE}.Weight
    WHEN ${survey_response} LIKE '%N/A%' OR ${survey_response} = "null" THEN NULL
    ELSE 0
    END;;
  }

  dimension: weight_adjusted {
    label: "Weight Adjusted"
    description: "This weight has been adjusted for cases of N/A"
    type: number
    sql:  CASE WHEN ${survey_response} LIKE '%N/A%' OR ${survey_response} = "null" THEN NULL
    ELSE ${weight}
    END;;
  }

  dimension: aggregated_score_dimension {
    label: "Total Score (%)"
    hidden: no
    value_format: "0.0%"
    type: number
    sql: ${TABLE}.pom_qa_walkthrough_survey_total_score;;
  }

  dimension: aggregated_score_tier {
    label: "Score Buckets"
    description: "Create buckets for total score (%). Pass >= 90% | Needs Improvement Between 80% and 90% | Fail < 80%"
    hidden: no
    type: string
    sql: CASE
    WHEN ${aggregated_score_dimension} >= 0.9 THEN "Pass"
    WHEN ${aggregated_score_dimension}  < 0.9 AND ${aggregated_score_dimension}  >= 0.8 THEN "Needs Improvement"
    WHEN ${aggregated_score_dimension}  < 0.8 THEN "Failed"
    END;;
  }

  dimension: real_time_POM_Walkthrough {
    label: "Real-time Checkin Survey Received POM Walkthrough"
    type: yesno
    sql: ${reviews.submitdate_date} is not null AND ${pom_qa_walkthrough_survey.submitdate_date} is not null ;;
  }

  dimension: airbnb_reviews_POM_Walkthrough {
    label: "Airbnb Review Received POM Walkthrough"
    type: yesno
    sql: ${airbnb_reviews.reservation_checkout_date} is not null AND ${pom_qa_walkthrough_survey.submitdate_date} is not null ;;
  }


  measure: passed_QAs {
    label: "# of QAs Passed"
    description: "Create buckets for total score (%). Pass >= 90% | Needs Improvement Between 80% and 90% | Fail < 80%"
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [aggregated_score_tier: "Pass"]
  }

  measure: need_improvement_QAs {
    label: "# of QAs Needs Improvement"
    description: "Create buckets for total score (%). Pass >= 90% | Needs Improvement Between 80% and 90% | Fail < 80%"
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [aggregated_score_tier: "Needs Improvement"]
  }

  measure: failed_QAs {
    label: "# of QAs Failed"
    description: "Create buckets for total score (%). Pass >= 90% | Needs Improvement Between 80% and 90% | Fail < 80%"
    type: count_distinct
    sql: ${primary_key} ;;
    filters: [aggregated_score_tier: "Failed"]
  }

  measure: response_sum {
    label: "Total Score"
    type: sum
    sql: ${response_answer} ;;
    drill_fields: [Question, section, survey_response, response_answer, weight_adjusted]
  }


  measure: weight_adjusted_sum {
    label: "Maximum Points"
    description: "This will calculate the total points that can be attained per checklist after excluding Qs that are N/A from the calculation"
    type: sum
    sql: ${weight_adjusted} ;;
    drill_fields: [Question, section, survey_response, response_answer, weight_adjusted]
  }

  measure: total_score {
    label: "Total Score (%)"
    type: number
    value_format: "0.0%"
    sql: (${response_sum} / nullif(${weight_adjusted_sum},0));;
    drill_fields: [Question, section, survey_response, response_answer, weight_adjusted]
  }


  measure: qs_count {
    label: "Number of Qs"
    description: "This will pull the number of Qs for integrity checks."
    type: count_distinct
    sql: ${Q} ;;
    drill_fields: [Question, section, survey_response, response_answer, weight_adjusted]
  }

  measure: survey {
    label: "Number of Surveys"
    description: "This will pull the total number of surveys"
    type: count_distinct
    sql: ${primary_key} ;;
    drill_fields: [submitdate_time, Email_address, POM_Name, Unit]
  }

  measure: resend_to_hk {
    label: "QAs Resending to HK"
    description: "This will pull the total number of surveys"
    type: count_distinct
    sql: ${primary_key} ;;
    drill_fields: [submitdate_time, Email_address, POM_Name, Unit]
    filters: [Q: "Wrap_Up___New_Clean_Required", survey_response: "Yes"]
  }

  measure: percent_resend {
    label: "% of Tasks resent for HK"
    description: "This will pull the percentage of the tasks which have undergone QA and have been resent for cleaning"
    type: number
    value_format: "0.0%"
    sql: ${resend_to_hk} / nullif(${survey},0)  ;;
  }

  measure: total_qas_completed {
    label: "Total QAs Completed"
    description: "This metric should be used as an aggregate or on a per POM basis"
    type: count_distinct
    sql: CAST(${submitdate_date} as STRING) || ${POM_Name} || ${Building} || ${Door} ;;
  }

  measure: total_qas_completed_percentage {
    label: "Pct QAs Completed"
    description: "Total QAs completed as a percentage of check-ins. Should be used in conjunstion with a check-in date filter"
    type: number
    sql: ${total_qas_completed} / NULLIF(${reservations_v3.number_of_checkins},0) ;;
  }

  measure: total_qas_completed_score {
    label: "Total QAs Completed Score"
    type: number
    sql:  CASE WHEN ${total_qas_completed_percentage} >= ${pom_information.PctQAsCompleted_Standard} THEN 1
            ELSE ${total_qas_completed_percentage} / NULLIF(${pom_information.PctQAsCompleted_Standard},0)
          END;;
  }

  measure: total_qas_completed_score_weighted {
    label: "Total QAs Completed Score (Weighting)"
    type: number
    sql: ${total_qas_completed_score} * ${pom_information.QACompleted_Weighting} ;;
  }






}
