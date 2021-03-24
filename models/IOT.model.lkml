connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: devices {
  group_label: "Product & Tech"
  label: "IoT Devices"
  join: units {
    type: left_outer
    relationship: many_to_one
    sql_on: ${devices.unit} = ${units._id} ;;
  }

  join: sensors {
    type: left_outer
    relationship: one_to_one
    sql_on: ${sensors.unit} = ${units._id} ;;
  }

  join: sensorreadings {
    type: left_outer
    relationship: one_to_many
    sql_on: (${sensors._id} = ${sensorreadings.sensor})
    and (${sensors.unit} = ${sensorreadings.unit});;
  }

  join: noisebreachlogs {
    type: full_outer
    relationship: one_to_many
    sql_on: (${devices.unit} = ${noisebreachlogs.unit})
    and (${devices.devicetype} = 'Minut_v1');;
  }

  join: sensorevents {
    type: full_outer
    relationship: one_to_many
    sql_on: (${devices.deviceid} = ${sensorevents.deviceid});;
  }
}

explore: sensorevents {
  group_label: "Product & Tech"
  label: "IoT Sensor Events"
  }
