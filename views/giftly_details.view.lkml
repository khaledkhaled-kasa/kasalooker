# The name of this view in Looker is "Giftly Details"
view: giftly_details {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `data-warehouse-333815.snapshots.giftlyDetailsVw`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Billing Note" in Explore.

  dimension: billing_note {
    type: string
    sql: ${TABLE}.billingNote ;;
  }

  dimension: dbt_scd_id {
    type: string
    sql: ${TABLE}.dbt_scd_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: dbt_updated {
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
    sql: ${TABLE}.dbt_updated_at ;;
  }

  dimension_group: dbt_valid_from {
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
    sql: ${TABLE}.dbt_valid_from ;;
  }

  dimension_group: dbt_valid_to {
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
    sql: ${TABLE}.dbt_valid_to ;;
  }

  dimension: delivery_method {
    type: string
    sql: ${TABLE}.deliveryMethod ;;
  }

  dimension: fee_amt {
    type: number
    sql: ${TABLE}.feeAmt ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_fee_amt {
    type: sum
    sql: ${fee_amt} ;;
  }

  measure: average_fee_amt {
    type: average
    sql: ${fee_amt} ;;
  }

  dimension: gift_amt {
    type: number
    sql: ${TABLE}.giftAmt ;;
  }

  dimension: giftee_email {
    type: string
    sql: ${TABLE}.gifteeEmail ;;
  }

  dimension: giftee_nm {
    type: string
    sql: ${TABLE}.gifteeNm ;;
  }

  dimension: gifter_email {
    type: string
    sql: ${TABLE}.gifterEmail ;;
  }

  dimension: gifter_nm {
    type: string
    sql: ${TABLE}.gifterNm ;;
  }

  dimension: internal_data {
    type: string
    sql: ${TABLE}.internalData ;;
  }

  dimension: item {
    type: string
    sql: ${TABLE}.item ;;
  }

  dimension: order_num {
    type: string
    sql: ${TABLE}.orderNum ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.paymentMethod ;;
  }

  dimension: place {
    type: string
    sql: ${TABLE}.place ;;
  }

  dimension: purchase_type {
    type: string
    sql: ${TABLE}.purchaseType ;;
  }

  dimension_group: purchased_dt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.purchasedDt ;;
  }

  dimension: record_id {
    type: number
    sql: ${TABLE}.recordId ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: total_amt {
    type: number
    sql: ${TABLE}.totalAmt ;;
  }

  measure: giftly_total_amt {
    type: sum
    sql: ${TABLE}.totalAmt ;;
    drill_fields: [order_num,purchased_dt_date,purchase_type,delivery_method,payment_method,gift_amt,fee_amt,total_amt,giftee_nm,giftee_email,giftee_nm,giftee_email,status,item
      , place,billing_note,internal_data]
  }

  measure: count {
    type: count
    drill_fields: []
  }

}
