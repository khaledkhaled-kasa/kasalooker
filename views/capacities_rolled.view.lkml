
view: capacities_rolled {
# If necessary, uncomment the line below to include explore_source.
# include: "capacities.model.lkml"
derived_table: {
  sql:

    SELECT
      TIMESTAMP(capacities.night) AS night, -- KK
       -- capacities.bedroomtype as bedroom, -- KK

      {% if complexes.title._is_selected %}
        complex,
      {% endif %}
      COALESCE(SUM(capacities.capacity ), 0) AS capacity
    FROM
      capacities  AS capacities
    GROUP BY 1
      {% if complexes.title._is_selected %}
        ,2 -- KK
        --3
      {% endif %}
;;
}

# KK
dimension_group: night {
  view_label: "Date Dimensions"
  group_label: "Night"
  description: "A night at a Kasa"
  type: time
  timeframes: [
    date,
    week,
    month,
    day_of_week
    ]
  sql: ${TABLE}.night ;;
}

# KK
dimension: night {
  hidden: yes
  sql: ${TABLE}.night ;;
  primary_key: yes
  type: date
}

# KK
dimension: bedroom {
  hidden: yes
  type: number
  sql: ${TABLE}.bedroom ;;
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
  #drill_fields: [night, complexes.title, capacity]
}
}
