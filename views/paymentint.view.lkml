view: paymentint {
  derived_table: {
    sql:
      SELECT reservation
            ,STRING_AGG(stripeId) as paymentintentStripeID
      FROM mongo.paymentintents
      Group by 1

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: reservation {
    primary_key: yes
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: payment_intent_stripe_id {
    type: string
    sql: ${TABLE}.paymentintentStripeID ;;
  }

  set: detail {
    fields: [reservation, payment_intent_stripe_id]
  }
}
