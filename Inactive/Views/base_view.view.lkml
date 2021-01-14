view: base_view
{
  derived_table: {
    explore_source: capacities_v3 {
      column: _id {}
      column: night_date {}
      column: unit {}
      column: complex_id { field: complexes._id }
    }

    persist_for: "1 hour"
    # datagroup_trigger: kasametrics_v3_default_datagroup
    # indexes: ["night","transaction"]
    # publish_as_db_view: yes
  }
  dimension: _id {
    label: "Capacities  ID"
  }
  dimension: night_date {
    type: date
  }
  dimension: unit {
    label: "Capacities Unit"
  }
  dimension: complex_id {
    label: "zBuildings  ID"
  }
}
