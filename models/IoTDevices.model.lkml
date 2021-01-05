connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: devices {
  join: units {
    relationship: many_to_one
    sql_on: ${devices.unit} = ${units._id} ;;
  }
}
