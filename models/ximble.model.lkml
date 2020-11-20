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
