connection: "bigquery"
include: "../views/*"


datagroup: ximble_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: ximble_default_datagroup
label: "Ximble"
explore: ximble_hourly_schedule {
  from: ximble_hourly_schedule
}


explore: ximble_master {
  from: ximble_master
  join: aircall_segment {
    type: full_outer
    relationship: one_to_one
    sql_on: ${ximble_master.name_adjusted} = ${aircall_segment.user_name_adjusted}
    and ${ximble_master.date_date} = ${aircall_segment.started_at_PST_date} ;;
  }
}
