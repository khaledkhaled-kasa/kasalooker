connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: devices {
  group_label: "Product & Tech"
  label: "IoT Devices"
  join: units {
    relationship: many_to_one
    sql_on: ${devices.unit} = ${units._id} ;;
  }

  join: sensors {
    relationship: one_to_one
    sql_on: ${sensors.unit} = ${units._id} ;;
  }
}
