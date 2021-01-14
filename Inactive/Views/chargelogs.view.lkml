view: chargelogs {
  sql_table_name: `bigquery-analytics-272822.mongo.chargelogs`
    ;;

  dimension: _id {
    type: string
    hidden:  yes
    primary_key: yes
    sql: ${TABLE}._id ;;
  }

  measure: charged_amount {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.amount / 100;;
  }

  dimension: chargeid {
    type: string
    sql: ${TABLE}.chargeid ;;
  }


  dimension_group: createdat {
    label: "Charged Date"
    description: "Date of a given charge"
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
    sql: ${TABLE}.createdat ;;
  }

  dimension: createdat__st {
    type: string
    sql: ${TABLE}.createdat__st ;;
  }

  dimension: customerid {
    type: string
    sql: ${TABLE}.customerid ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: error {
    hidden: yes
    sql: ${TABLE}.error ;;
  }

  dimension: financials {
    hidden: yes
    sql: ${TABLE}.financials ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: paymentintentid {
    type: string
    sql: ${TABLE}.paymentintentid ;;
  }

  dimension: paymentmethodid {
    type: string
    sql: ${TABLE}.paymentmethodid ;;
  }

  dimension: refundid {
    type: string
    sql: ${TABLE}.refundid ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: risk {
    hidden: yes
    sql: ${TABLE}.risk ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: striperesponse {
    hidden: yes
    sql: ${TABLE}.striperesponse ;;
  }

  dimension: striperesponse__st {
    type: string
    sql: ${TABLE}.striperesponse__st ;;
  }

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }

  dimension: updatedat__st {
    type: string
    sql: ${TABLE}.updatedat__st ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: chargelogs__metadata {
  dimension: accountid {
    type: string
    sql: ${TABLE}.accountid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: guestname {
    type: string
    sql: ${TABLE}.guestname ;;
  }

  dimension: listingid {
    type: string
    sql: ${TABLE}.listingid ;;
  }

  dimension: ota {
    type: string
    sql: ${TABLE}.ota ;;
  }

  dimension: reservationid {
    type: string
    sql: ${TABLE}.reservationid ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: chargelogs__error {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }
}

view: chargelogs__striperesponse__metadata {
  dimension: accountid {
    type: string
    sql: ${TABLE}.accountid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: guestname {
    type: string
    sql: ${TABLE}.guestname ;;
  }

  dimension: listingid {
    type: string
    sql: ${TABLE}.listingid ;;
  }

  dimension: ota {
    type: string
    sql: ${TABLE}.ota ;;
  }

  dimension: reservationid {
    type: string
    sql: ${TABLE}.reservationid ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: chargelogs__striperesponse__billing_details__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__billing_details {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: chargelogs__striperesponse {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: amount_capturable {
    type: number
    sql: ${TABLE}.amount_capturable ;;
  }

  dimension: amount_captured {
    type: number
    sql: ${TABLE}.amount_captured ;;
  }

  dimension: amount_received {
    type: number
    sql: ${TABLE}.amount_received ;;
  }

  dimension: amount_refunded {
    type: number
    sql: ${TABLE}.amount_refunded ;;
  }

  dimension: application {
    type: string
    sql: ${TABLE}.application ;;
  }

  dimension: balance_transaction {
    type: string
    sql: ${TABLE}.balance_transaction ;;
  }

  dimension: billing_details {
    hidden: yes
    sql: ${TABLE}.billing_details ;;
  }

  dimension: calculated_statement_descriptor {
    type: string
    sql: ${TABLE}.calculated_statement_descriptor ;;
  }

  dimension: capture_method {
    type: string
    sql: ${TABLE}.capture_method ;;
  }

  dimension: captured {
    type: yesno
    sql: ${TABLE}.captured ;;
  }

  dimension: charge {
    type: string
    sql: ${TABLE}.charge ;;
  }

  dimension: charges {
    hidden: yes
    sql: ${TABLE}.charges ;;
  }

  dimension: client_secret {
    type: string
    sql: ${TABLE}.client_secret ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: confirmation_method {
    type: string
    sql: ${TABLE}.confirmation_method ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: disputed {
    type: yesno
    sql: ${TABLE}.disputed ;;
  }

  dimension: headers {
    hidden: yes
    sql: ${TABLE}.headers ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: outcome {
    hidden: yes
    sql: ${TABLE}.outcome ;;
  }

  dimension: paid {
    type: yesno
    sql: ${TABLE}.paid ;;
  }

  dimension: param {
    type: string
    sql: ${TABLE}.param ;;
  }

  dimension: payment_intent {
    type: string
    sql: ${TABLE}.payment_intent ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_method_details {
    hidden: yes
    sql: ${TABLE}.payment_method_details ;;
  }

  dimension: payment_method_options {
    hidden: yes
    sql: ${TABLE}.payment_method_options ;;
  }

  dimension: payment_method_types {
    hidden: yes
    sql: ${TABLE}.payment_method_types ;;
  }

  dimension: raw {
    hidden: yes
    sql: ${TABLE}.raw ;;
  }

  dimension: rawtype {
    type: string
    sql: ${TABLE}.rawtype ;;
  }

  dimension: receipt_url {
    type: string
    sql: ${TABLE}.receipt_url ;;
  }

  dimension: refunded {
    type: yesno
    sql: ${TABLE}.refunded ;;
  }

  dimension: refunds {
    hidden: yes
    sql: ${TABLE}.refunds ;;
  }

  dimension: requestid {
    type: string
    sql: ${TABLE}.requestid ;;
  }

  dimension: review {
    type: string
    sql: ${TABLE}.review ;;
  }

  dimension: shipping {
    hidden: yes
    sql: ${TABLE}.shipping ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: stack {
    type: string
    sql: ${TABLE}.stack ;;
  }

  dimension: statement_descriptor {
    type: string
    sql: ${TABLE}.statement_descriptor ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: statuscode {
    type: number
    sql: ${TABLE}.statuscode ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__shipping__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__shipping {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
}

view: chargelogs__striperesponse__payment_method_details {
  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__payment_method_details__card {
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: checks {
    hidden: yes
    sql: ${TABLE}.checks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }
}

view: chargelogs__striperesponse__payment_method_details__card__checks {
  dimension: address_line1_check {
    type: string
    sql: ${TABLE}.address_line1_check ;;
  }

  dimension: address_postal_code_check {
    type: string
    sql: ${TABLE}.address_postal_code_check ;;
  }
}

view: chargelogs__striperesponse__raw {
  dimension: charge {
    type: string
    sql: ${TABLE}.charge ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: decline_code {
    type: string
    sql: ${TABLE}.decline_code ;;
  }

  dimension: doc_url {
    type: string
    sql: ${TABLE}.doc_url ;;
  }

  dimension: headers {
    hidden: yes
    sql: ${TABLE}.headers ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: param {
    type: string
    sql: ${TABLE}.param ;;
  }

  dimension: payment_intent {
    hidden: yes
    sql: ${TABLE}.payment_intent ;;
  }

  dimension: payment_method {
    hidden: yes
    sql: ${TABLE}.payment_method ;;
  }

  dimension: requestid {
    type: string
    sql: ${TABLE}.requestid ;;
  }

  dimension: statuscode {
    type: number
    sql: ${TABLE}.statuscode ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__headers {
  dimension: access_control_allow_credentials {
    type: string
    sql: ${TABLE}.access_control_allow_credentials ;;
  }

  dimension: access_control_allow_methods {
    type: string
    sql: ${TABLE}.access_control_allow_methods ;;
  }

  dimension: access_control_allow_origin {
    type: string
    sql: ${TABLE}.access_control_allow_origin ;;
  }

  dimension: access_control_expose_headers {
    type: string
    sql: ${TABLE}.access_control_expose_headers ;;
  }

  dimension: access_control_max_age {
    type: string
    sql: ${TABLE}.access_control_max_age ;;
  }

  dimension: cache_control {
    type: string
    sql: ${TABLE}.cache_control ;;
  }

  dimension: connection {
    type: string
    sql: ${TABLE}.connection ;;
  }

  dimension: content_length {
    type: string
    sql: ${TABLE}.content_length ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: request_id {
    type: string
    sql: ${TABLE}.request_id ;;
  }

  dimension: server {
    type: string
    sql: ${TABLE}.server ;;
  }

  dimension: strict_transport_security {
    type: string
    sql: ${TABLE}.strict_transport_security ;;
  }

  dimension: stripe_version {
    type: string
    sql: ${TABLE}.stripe_version ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: amount_capturable {
    type: number
    sql: ${TABLE}.amount_capturable ;;
  }

  dimension: amount_received {
    type: number
    sql: ${TABLE}.amount_received ;;
  }

  dimension: capture_method {
    type: string
    sql: ${TABLE}.capture_method ;;
  }

  dimension: charges {
    hidden: yes
    sql: ${TABLE}.charges ;;
  }

  dimension: client_secret {
    type: string
    sql: ${TABLE}.client_secret ;;
  }

  dimension: confirmation_method {
    type: string
    sql: ${TABLE}.confirmation_method ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: last_payment_error {
    hidden: yes
    sql: ${TABLE}.last_payment_error ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: payment_method_options {
    hidden: yes
    sql: ${TABLE}.payment_method_options ;;
  }

  dimension: payment_method_types {
    hidden: yes
    sql: ${TABLE}.payment_method_types ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__metadata {
  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__payment_method_types {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__metadata {
  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__billing_details__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__billing_details {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: amount_captured {
    type: number
    sql: ${TABLE}.amount_captured ;;
  }

  dimension: amount_refunded {
    type: number
    sql: ${TABLE}.amount_refunded ;;
  }

  dimension: billing_details {
    hidden: yes
    sql: ${TABLE}.billing_details ;;
  }

  dimension: calculated_statement_descriptor {
    type: string
    sql: ${TABLE}.calculated_statement_descriptor ;;
  }

  dimension: captured {
    type: yesno
    sql: ${TABLE}.captured ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: disputed {
    type: yesno
    sql: ${TABLE}.disputed ;;
  }

  dimension: failure_code {
    type: string
    sql: ${TABLE}.failure_code ;;
  }

  dimension: failure_message {
    type: string
    sql: ${TABLE}.failure_message ;;
  }

  dimension: fraud_details {
    hidden: yes
    sql: ${TABLE}.fraud_details ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: outcome {
    hidden: yes
    sql: ${TABLE}.outcome ;;
  }

  dimension: paid {
    type: yesno
    sql: ${TABLE}.paid ;;
  }

  dimension: payment_intent {
    type: string
    sql: ${TABLE}.payment_intent ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_method_details {
    hidden: yes
    sql: ${TABLE}.payment_method_details ;;
  }

  dimension: refunded {
    type: yesno
    sql: ${TABLE}.refunded ;;
  }

  dimension: refunds {
    hidden: yes
    sql: ${TABLE}.refunds ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__fraud_details {
  dimension: stripe_report {
    type: string
    sql: ${TABLE}.stripe_report ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__refunds {
  dimension: has_more {
    type: yesno
    sql: ${TABLE}.has_more ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__outcome {
  dimension: network_status {
    type: string
    sql: ${TABLE}.network_status ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: risk_level {
    type: string
    sql: ${TABLE}.risk_level ;;
  }

  dimension: risk_score {
    type: number
    sql: ${TABLE}.risk_score ;;
  }

  dimension: rule {
    type: string
    sql: ${TABLE}.rule ;;
  }

  dimension: seller_message {
    type: string
    sql: ${TABLE}.seller_message ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__payment_method_details {
  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__payment_method_details__card {
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: checks {
    hidden: yes
    sql: ${TABLE}.checks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data__value__payment_method_details__card__checks {
  dimension: address_line1_check {
    type: string
    sql: ${TABLE}.address_line1_check ;;
  }

  dimension: address_postal_code_check {
    type: string
    sql: ${TABLE}.address_postal_code_check ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.data ;;
  }

  dimension: has_more {
    type: yesno
    sql: ${TABLE}.has_more ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error {
  dimension: charge {
    type: string
    sql: ${TABLE}.charge ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: decline_code {
    type: string
    sql: ${TABLE}.decline_code ;;
  }

  dimension: doc_url {
    type: string
    sql: ${TABLE}.doc_url ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: param {
    type: string
    sql: ${TABLE}.param ;;
  }

  dimension: payment_method {
    hidden: yes
    sql: ${TABLE}.payment_method ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__billing_details__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__billing_details {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: billing_details {
    hidden: yes
    sql: ${TABLE}.billing_details ;;
  }

  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__card {
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: checks {
    hidden: yes
    sql: ${TABLE}.checks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: networks {
    hidden: yes
    sql: ${TABLE}.networks ;;
  }

  dimension: three_d_secure_usage {
    hidden: yes
    sql: ${TABLE}.three_d_secure_usage ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__card__three_d_secure_usage {
  dimension: supported {
    type: yesno
    sql: ${TABLE}.supported ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__card__checks {
  dimension: address_line1_check {
    type: string
    sql: ${TABLE}.address_line1_check ;;
  }

  dimension: address_postal_code_check {
    type: string
    sql: ${TABLE}.address_postal_code_check ;;
  }

  dimension: cvc_check {
    type: string
    sql: ${TABLE}.cvc_check ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__card__networks__available {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__payment_method_options__card {
  dimension: request_three_d_secure {
    type: string
    sql: ${TABLE}.request_three_d_secure ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__billing_details__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__billing_details {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: billing_details {
    hidden: yes
    sql: ${TABLE}.billing_details ;;
  }

  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__card {
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: checks {
    hidden: yes
    sql: ${TABLE}.checks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: networks {
    hidden: yes
    sql: ${TABLE}.networks ;;
  }

  dimension: three_d_secure_usage {
    hidden: yes
    sql: ${TABLE}.three_d_secure_usage ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__card__three_d_secure_usage {
  dimension: supported {
    type: yesno
    sql: ${TABLE}.supported ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__card__checks {
  dimension: address_line1_check {
    type: string
    sql: ${TABLE}.address_line1_check ;;
  }

  dimension: address_postal_code_check {
    type: string
    sql: ${TABLE}.address_postal_code_check ;;
  }

  dimension: cvc_check {
    type: string
    sql: ${TABLE}.cvc_check ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__card__networks__available {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__striperesponse__charges__data__value {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: amount_captured {
    type: number
    sql: ${TABLE}.amount_captured ;;
  }

  dimension: amount_refunded {
    type: number
    sql: ${TABLE}.amount_refunded ;;
  }

  dimension: application {
    type: string
    sql: ${TABLE}.application ;;
  }

  dimension: balance_transaction {
    type: string
    sql: ${TABLE}.balance_transaction ;;
  }

  dimension: billing_details {
    hidden: yes
    sql: ${TABLE}.billing_details ;;
  }

  dimension: calculated_statement_descriptor {
    type: string
    sql: ${TABLE}.calculated_statement_descriptor ;;
  }

  dimension: captured {
    type: yesno
    sql: ${TABLE}.captured ;;
  }

  dimension: created {
    type: number
    sql: ${TABLE}.created ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: disputed {
    type: yesno
    sql: ${TABLE}.disputed ;;
  }

  dimension: livemode {
    type: yesno
    sql: ${TABLE}.livemode ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: outcome {
    hidden: yes
    sql: ${TABLE}.outcome ;;
  }

  dimension: paid {
    type: yesno
    sql: ${TABLE}.paid ;;
  }

  dimension: payment_intent {
    type: string
    sql: ${TABLE}.payment_intent ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_method_details {
    hidden: yes
    sql: ${TABLE}.payment_method_details ;;
  }

  dimension: receipt_url {
    type: string
    sql: ${TABLE}.receipt_url ;;
  }

  dimension: refunded {
    type: yesno
    sql: ${TABLE}.refunded ;;
  }

  dimension: refunds {
    hidden: yes
    sql: ${TABLE}.refunds ;;
  }

  dimension: shipping {
    hidden: yes
    sql: ${TABLE}.shipping ;;
  }

  dimension: source {
    hidden: yes
    sql: ${TABLE}.source ;;
  }

  dimension: statement_descriptor {
    type: string
    sql: ${TABLE}.statement_descriptor ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__billing_details__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__billing_details {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__metadata {
  dimension: accountid {
    type: string
    sql: ${TABLE}.accountid ;;
  }

  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: guestname {
    type: string
    sql: ${TABLE}.guestname ;;
  }

  dimension: listingid {
    type: string
    sql: ${TABLE}.listingid ;;
  }

  dimension: ota {
    type: string
    sql: ${TABLE}.ota ;;
  }

  dimension: reservationid {
    type: string
    sql: ${TABLE}.reservationid ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__source {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: address_country {
    type: string
    sql: ${TABLE}.address_country ;;
  }

  dimension: address_zip {
    type: string
    sql: ${TABLE}.address_zip ;;
  }

  dimension: address_zip_check {
    type: string
    sql: ${TABLE}.address_zip_check ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
  }

  dimension: cvc_check {
    type: string
    sql: ${TABLE}.cvc_check ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__refunds {
  dimension: has_more {
    type: yesno
    sql: ${TABLE}.has_more ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__shipping__address {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}.line1 ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__shipping {
  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__outcome {
  dimension: network_status {
    type: string
    sql: ${TABLE}.network_status ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: risk_level {
    type: string
    sql: ${TABLE}.risk_level ;;
  }

  dimension: risk_score {
    type: number
    sql: ${TABLE}.risk_score ;;
  }

  dimension: rule {
    type: string
    sql: ${TABLE}.rule ;;
  }

  dimension: seller_message {
    type: string
    sql: ${TABLE}.seller_message ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__payment_method_details {
  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__payment_method_details__card {
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: checks {
    hidden: yes
    sql: ${TABLE}.checks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: exp_month {
    type: number
    sql: ${TABLE}.exp_month ;;
  }

  dimension: exp_year {
    type: number
    sql: ${TABLE}.exp_year ;;
  }

  dimension: fingerprint {
    type: string
    sql: ${TABLE}.fingerprint ;;
  }

  dimension: funding {
    type: string
    sql: ${TABLE}.funding ;;
  }

  dimension: last4 {
    type: string
    sql: ${TABLE}.last4 ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }
}

view: chargelogs__striperesponse__charges__data__value__payment_method_details__card__checks {
  dimension: address_line1_check {
    type: string
    sql: ${TABLE}.address_line1_check ;;
  }

  dimension: address_postal_code_check {
    type: string
    sql: ${TABLE}.address_postal_code_check ;;
  }

  dimension: cvc_check {
    type: string
    sql: ${TABLE}.cvc_check ;;
  }
}

view: chargelogs__striperesponse__charges {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.data ;;
  }

  dimension: has_more {
    type: yesno
    sql: ${TABLE}.has_more ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: chargelogs__striperesponse__refunds {
  dimension: has_more {
    type: yesno
    sql: ${TABLE}.has_more ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: total_count {
    type: number
    sql: ${TABLE}.total_count ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: chargelogs__striperesponse__payment_method_options__card {
  dimension: request_three_d_secure {
    type: string
    sql: ${TABLE}.request_three_d_secure ;;
  }
}

view: chargelogs__striperesponse__outcome {
  dimension: network_status {
    type: string
    sql: ${TABLE}.network_status ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: risk_level {
    type: string
    sql: ${TABLE}.risk_level ;;
  }

  dimension: risk_score {
    type: number
    sql: ${TABLE}.risk_score ;;
  }

  dimension: rule {
    type: string
    sql: ${TABLE}.rule ;;
  }

  dimension: seller_message {
    type: string
    sql: ${TABLE}.seller_message ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: chargelogs__striperesponse__headers {
  dimension: access_control_allow_credentials {
    type: string
    sql: ${TABLE}.access_control_allow_credentials ;;
  }

  dimension: access_control_allow_methods {
    type: string
    sql: ${TABLE}.access_control_allow_methods ;;
  }

  dimension: access_control_allow_origin {
    type: string
    sql: ${TABLE}.access_control_allow_origin ;;
  }

  dimension: access_control_expose_headers {
    type: string
    sql: ${TABLE}.access_control_expose_headers ;;
  }

  dimension: access_control_max_age {
    type: string
    sql: ${TABLE}.access_control_max_age ;;
  }

  dimension: cache_control {
    type: string
    sql: ${TABLE}.cache_control ;;
  }

  dimension: connection {
    type: string
    sql: ${TABLE}.connection ;;
  }

  dimension: content_length {
    type: string
    sql: ${TABLE}.content_length ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: request_id {
    type: string
    sql: ${TABLE}.request_id ;;
  }

  dimension: server {
    type: string
    sql: ${TABLE}.server ;;
  }

  dimension: strict_transport_security {
    type: string
    sql: ${TABLE}.strict_transport_security ;;
  }

  dimension: stripe_version {
    type: string
    sql: ${TABLE}.stripe_version ;;
  }
}

view: chargelogs__striperesponse__payment_method_types {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__financials {
  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__risk {
  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__charges__data {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__last_payment_error__payment_method__card__networks {
  dimension: available {
    hidden: yes
    sql: ${TABLE}.available ;;
  }
}

view: chargelogs__striperesponse__raw__payment_intent__payment_method_options {
  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }
}

view: chargelogs__striperesponse__raw__payment_method__card__networks {
  dimension: available {
    hidden: yes
    sql: ${TABLE}.available ;;
  }
}

view: chargelogs__striperesponse__charges__data {
  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: chargelogs__striperesponse__payment_method_options {
  dimension: card {
    hidden: yes
    sql: ${TABLE}.card ;;
  }
}
