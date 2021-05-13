view: pom_weighting_standards_initial {
  sql_table_name: `bigquery-analytics-272822.POM_Standards.POM_Weighting_Standards_Initial`
    ;;

  dimension: standard_type {
    type: string
    sql: ${TABLE}.StandardType ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.Weight ;;

    action: {
      label: "Update"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_weight_writeback"
      param: {
        name: "WeightingCategory"
        value: "{{pom_weighting_standards_initial.weighting_category._value}}"
      }
      param: {
        name: "UpdateType"
        value: "{{pom_weighting_standards_initial.standard_type._value}}"
      }
      form_param: {
        name: "Update"
        type: string
        label: "New Weight"
        description: "Enter new weighting"
        required: yes
      }
    }
  }

  dimension: weighting_category {
    type: string
    sql: ${TABLE}.WeightingCategory ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: actual_weight {
    type: average
    sql: ${weight} ;;
    value_format_name: decimal_0

    action: {
      label: "Update"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_weight_writeback"
      param: {
        name: "WeightingCategory"
        value: "{{pom_weighting_standards_initial.weighting_category._value}}"
      }
      param: {
        name: "UpdateType"
        value: "{{pom_weighting_standards_initial.standard_type._value}}"
      }
      form_param: {
        name: "Update"
        type: string
        label: "New Weight"
        description: "Enter new weighting"
        required: yes
      }
    }
  }
}
