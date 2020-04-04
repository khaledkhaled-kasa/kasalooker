
view: capacities_rolled {
# If necessary, uncomment the line below to include explore_source.
# include: "capacities.model.lkml"
derived_table: {
  sql:

    SELECT
      capacities.night AS night,


      {% if complexes.title._is_selected %}
        complex,
      {% endif %}
      COALESCE(SUM(capacities.capacity ), 0) AS capacity
    FROM
      capacities  AS capacities
    GROUP BY 1
      {% if complexes.title._is_selected %}
        ,2
      {% endif %}
;;
}
dimension: night {
  hidden:  yes
  sql: ${TABLE}.night ;;
  primary_key: yes
  type: date
}

dimension: complex {
  hidden:  yes
  sql: ${TABLE}.complex;;
}
dimension: capacity {
  hidden:  yes
  type: number
  sql: ${TABLE}.capacity ;;
}

measure: capacity_measure  {
  view_label: "Metrics"
  label: "Capacity"
  description: "Number of available room nights bookable"
  type: sum
  sql: ${capacity} ;;
}
}
