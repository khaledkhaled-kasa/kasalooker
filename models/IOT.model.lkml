connection: "bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: pom_checklist_default_datagroup {
  sql_trigger: SELECT count(*) FROM Gsheets.POM_QA_Walkthrough_Survey ;;
  max_cache_age: "1 hours"
}

explore: units_and_devices {
  fields: [ALL_FIELDS*, -pom_information.live_partners]
  from: units
  group_label: "Product & Tech"
  label: "IoT Devices"

  join: devices {
    type: left_outer
    relationship: one_to_many
    sql_on: ${devices.unit} = ${units_and_devices._id} ;;
  }

  join: pom_information {
    view_label: "POM Information"
    type: left_outer
    relationship: one_to_one
    sql_on: ${units_and_devices.propcode} = ${pom_information.Prop_Code} ;;
  }


  join: sensors {
    type: left_outer
    relationship: one_to_one
    sql_on: ${sensors.unit} = ${units_and_devices._id} ;;
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
  join: hub_devices {
    from: devices
    type: left_outer
    relationship: one_to_many
    sql_on: ${devices.unit} = ${hub_devices.unit}
      AND ${hub_devices.devicetype} IN ('Nexia_v1', 'Smartthings_v1') and ${hub_devices.active}=true;;
  }

}
