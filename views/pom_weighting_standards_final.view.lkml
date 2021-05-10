view: pom_weighting_standards_final {
  sql_table_name: `bigquery-analytics-272822.POM_Standards.POM_Weighting_Standards_Final`
    ;;

  dimension: standard_type {
    type: string
    sql: ${TABLE}.StandardType ;;

    action: {
      label: "Add New"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_new_weight_writeback"

      form_param: {
        name: "WeightingCategory"
        type: string
        label: "Weighting Category"
        description: "Enter weighting category"
        required: yes
      }

      form_param: {
        name: "StandardType"
        type: string
        label: "Enter New Standard Type"
        description: "Enter the New Standard for the Weighting Category"
        required: yes
      }

      form_param: {
        name: "NewWeight"
        type: string
        label: "Enter New Weight"
        description: "Enter the New Weighting"
        required: yes
      }

    }
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.Weight ;;

    action: {
      label: "Update"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_weight_writeback"
      param: {
        name: "WeightingCategory"
        value: "{{pom_weighting_standards_final.weighting_category._value}}"
      }
      param: {
        name: "UpdateType"
        value: "{{pom_weighting_standards_final.standard_type._value}}"
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

    action: {
      label: "Add New"
      url: "https://us-east1-bigquery-analytics-272822.cloudfunctions.net/pom_new_weight_writeback"

      form_param: {
        name: "WeightingCategory"
        type: string
        label: "Weighting Category"
        description: "Enter weighting category"
        required: yes
      }

      form_param: {
        name: "StandardType"
        type: string
        label: "Enter New Standard Type"
        description: "Enter the New Standard for the Weighting Category"
        required: yes
      }

      form_param: {
        name: "NewWeight"
        type: string
        label: "Enter New Weight"
        description: "Enter the New Weighting"
        required: yes
      }

    }
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
