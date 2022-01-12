# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: tasks {
  hidden: yes

  join: tasks__auditlog {
    view_label: "Tasks: Auditlog"
    sql: LEFT JOIN UNNEST(${tasks.auditlog}) as tasks__auditlog ;;
    relationship: one_to_many
  }

  join: tasks__assignees {
    view_label: "Tasks: Assignees"
    sql: LEFT JOIN UNNEST(${tasks.assignees}) as tasks__assignees ;;
    relationship: one_to_many
  }

  join: tasks__auditlog__value__fieldschanged {
    view_label: "Tasks: Auditlog Value Fieldschanged"
    sql: LEFT JOIN UNNEST(${tasks__auditlog.value__fieldschanged}) as tasks__auditlog__value__fieldschanged ;;
    relationship: one_to_many
  }

  join: tasks__auditlog__value__fieldschanged__value__oldvalue__ar {
    view_label: "Tasks: Auditlog Value Fieldschanged Value Oldvalue Ar"
    sql: LEFT JOIN UNNEST(${tasks__auditlog__value__fieldschanged.value__oldvalue__ar}) as tasks__auditlog__value__fieldschanged__value__oldvalue__ar ;;
    relationship: one_to_many
  }

  join: tasks__auditlog__value__fieldschanged__value__newvalue__ar {
    view_label: "Tasks: Auditlog Value Fieldschanged Value Newvalue Ar"
    sql: LEFT JOIN UNNEST(${tasks__auditlog__value__fieldschanged.value__newvalue__ar}) as tasks__auditlog__value__fieldschanged__value__newvalue__ar ;;
    relationship: one_to_many
  }
}

# The name of this view in Looker is "Tasks"
view: tasks {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bigquery-analytics-272822.mongo.tasks`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called " V" in Explore.

  dimension: __v {
    type: number
    sql: ${TABLE}.__v ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total___v {
    type: sum
    sql: ${__v} ;;
  }

  measure: average___v {
    type: average
    sql: ${__v} ;;
  }

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }



  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: _sdc_batched {
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
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension_group: _sdc_extracted {
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
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension_group: _sdc_received {
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
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: assignees {
    hidden: yes
    sql: ${TABLE}.assignees ;;
  }

  dimension: auditlog {
    hidden: yes
    sql: ${TABLE}.auditlog ;;
  }

  dimension: breezewaydescription {
    type: string
    sql: ${TABLE}.breezewaydescription ;;
  }

  dimension: breezewayid {
    type: string
    sql: ${TABLE}.breezewayid ;;
  }

  dimension: breezewaystatus {
    type: string
    sql: ${TABLE}.breezewaystatus ;;
  }

  dimension: breezewaytitle {
    type: string
    sql: ${TABLE}.breezewaytitle ;;
  }

  dimension_group: createdat {
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

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: kustomerid {
    type: string
    sql: ${TABLE}.kustomerid ;;
  }

  dimension: kustomertaskurl {
    type: string
    sql: ${TABLE}.kustomertaskurl ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: reservation {
    type: string
    sql: ${TABLE}.reservation ;;
  }

  dimension: scheduleddate {
    type: string
    sql: ${TABLE}.scheduleddate ;;
  }

  dimension: scheduledtime {
    type: string
    sql: ${TABLE}.scheduledtime ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}

# The name of this view in Looker is "Tasks Auditlog"
view: tasks__auditlog {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: tasks__auditlog {
    type: string
    hidden: yes
    sql: tasks__auditlog ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Value ID" in Explore.

  dimension: value___id {
    type: string
    sql: value._id ;;
    group_label: "Value"
    group_item_label: "ID"
  }

  dimension: value__fieldschanged {
    hidden: yes
    sql: value.fieldschanged ;;
    group_label: "Value"
    group_item_label: "Fieldschanged"
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: value__timestamp {
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
    sql: value.timestamp ;;
    group_label: "Value"
    group_item_label: "Timestamp"
  }
}

# The name of this view in Looker is "Tasks Assignees"
view: tasks__assignees {
  drill_fields: [value__assigneeid]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: value__assigneeid {
    primary_key: yes
    type: string
    sql: value.assigneeid ;;
    group_label: "Value"
    group_item_label: "Assigneeid"
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: tasks__assignees {
    type: string
    hidden: yes
    sql: tasks__assignees ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Value ID" in Explore.

  dimension: value___id {
    type: string
    sql: value._id ;;
    group_label: "Value"
    group_item_label: "ID"
  }

  dimension: value__name {
    type: string
    sql: value.name ;;
    group_label: "Value"
    group_item_label: "Name"
  }

  dimension: value__status {
    type: string
    sql: value.status ;;
    group_label: "Value"
    group_item_label: "Status"
  }
}

# The name of this view in Looker is "Tasks Auditlog Value Fieldschanged"
view: tasks__auditlog__value__fieldschanged {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Value Fieldname" in Explore.

  dimension: value__fieldname {
    type: string
    sql: ${TABLE}.value.fieldname ;;
    group_label: "Value"
    group_item_label: "Fieldname"
  }

  dimension: value__newvalue {
    type: string
    sql: ${TABLE}.value.newvalue ;;
    group_label: "Value"
    group_item_label: "Newvalue"
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: value__newvalue__ar {
    hidden: yes
    sql: ${TABLE}.value.newvalue__ar ;;
    group_label: "Value Newvalue"
    group_item_label: "Ar"
  }

  dimension: value__oldvalue {
    type: string
    sql: ${TABLE}.value.oldvalue ;;
    group_label: "Value"
    group_item_label: "Oldvalue"
  }

  dimension: value__oldvalue__ar {
    hidden: yes
    sql: ${TABLE}.value.oldvalue__ar ;;
    group_label: "Value Oldvalue"
    group_item_label: "Ar"
  }
}

# The name of this view in Looker is "Tasks Auditlog Value Fieldschanged Value Oldvalue Ar"
view: tasks__auditlog__value__fieldschanged__value__oldvalue__ar {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Value ID" in Explore.

  dimension: value___id {
    type: string
    sql: ${TABLE}.value._id ;;
    group_label: "Value"
    group_item_label: "ID"
  }

  dimension: value__assigneeid {
    type: string
    sql: ${TABLE}.value.assigneeid ;;
    group_label: "Value"
    group_item_label: "Assigneeid"
  }

  dimension: value__name {
    type: string
    sql: ${TABLE}.value.name ;;
    group_label: "Value"
    group_item_label: "Name"
  }

  dimension: value__status {
    type: string
    sql: ${TABLE}.value.status ;;
    group_label: "Value"
    group_item_label: "Status"
  }
}

# The name of this view in Looker is "Tasks Auditlog Value Fieldschanged Value Newvalue Ar"
view: tasks__auditlog__value__fieldschanged__value__newvalue__ar {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Value Assigneeid" in Explore.

  dimension: value__assigneeid {
    type: number
    value_format_name: id
    sql: ${TABLE}.value.assigneeid ;;
    group_label: "Value"
    group_item_label: "Assigneeid"
  }

  dimension: value__assigneeid__st {
    type: string
    sql: ${TABLE}.value.assigneeid__st ;;
    group_label: "Value Assigneeid"
    group_item_label: "St"
  }

  dimension: value__name {
    type: string
    sql: ${TABLE}.value.name ;;
    group_label: "Value"
    group_item_label: "Name"
  }

  dimension: value__status {
    type: string
    sql: ${TABLE}.value.status ;;
    group_label: "Value"
    group_item_label: "Status"
  }
}
