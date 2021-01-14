connection: "bigquery"
include: "../views/*"


# datagroup: blacklineexport_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }


# persist_with: blacklineexport_default_datagroup
# label: "Developer View"
# explore: blacklineexport {
#   from: blacklineexport
# }
