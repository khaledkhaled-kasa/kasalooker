connection: "bigquery"
include: "../views/*"


datagroup: aircalls_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hours"
}


persist_with: aircalls_default_datagroup
label: "Aircall"
explore: aircall {
  label: "Aircalls Export (Historical Data)"
  from: aircall
}


explore: aircall_segment {
  label: "Aircalls"
}
