connection: "bigquery"
include: "../views/*"


datagroup: ximble_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: ximble_default_datagroup
label: "Kasa Reviews"
explore: ximble_hours {
  from: ximble_hours
}
