connection: "bigquery"
include: "../views/*"


datagroup: breezeway_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: breezeway_default_datagroup
label: "Kasa Reviews"
explore: breezeway_export {
  from: breezeway_export
}
