connection: "bigquery"
include: "../views/*"


datagroup: aircalls_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: aircalls_default_datagroup
label: "Kasa Reviews"
explore: aircall {
  from: aircall
}
