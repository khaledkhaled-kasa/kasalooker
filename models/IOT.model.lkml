connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: devices {
  group_label: "IoT Devices"
  join: units {
    relationship: many_to_one
    sql_on: ${devices.unit} = ${units._id} ;;
  }
}
