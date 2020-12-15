connection: "bigquery_new"
include: "../views/*"


datagroup: aircalls_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


persist_with: aircalls_default_datagroup
label: "Aircall"
explore: aircall {
  label: "Aircalls Export"
  from: aircall
}


explore: aircall_segment {
  label: "Aircalls"
}
