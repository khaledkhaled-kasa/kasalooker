
# view: capacities_rolled_audit {
# # If necessary, uncomment the line below to include explore_source.
# # include: "capacities.model.lkml"
#   derived_table: {
#     sql:

#     SELECT
#       TIMESTAMP(capacities.night) AS night,
#         capacities.bedroomtype as bedroom,

#       {% if complexes.title._is_selected %}
#         complex,
#       {% endif %}
#       COALESCE(SUM(capacities.capacity), 0) AS capacity
#     FROM
#       capacities  AS capacities
#     GROUP BY 1
#         ,2
#         {% if complexes.title._is_selected %}
#         ,3
#       {% endif %}
# ;;
#   }

# dimension_group: night {
#   view_label: "Date Dimensions"
#   group_label: "Occupied / Unoccupied Night"
#   description: "A night at a Kasa (Occupied / Unoccupied)"
#   type: time
#   timeframes: [
#     date,
#     week,
#     month,
#     day_of_week
#   ]
#   sql: ${TABLE}.night ;;
# }


# dimension: night {
#   hidden: yes
#   sql: ${TABLE}.night ;;
#   type: date
# }


# dimension: bedroom {
#   hidden: yes
#   type: number
#   sql: ${TABLE}.bedroom ;;
# }

# dimension: complex {
#   hidden:  yes
#   sql: ${TABLE}.complex;;
# }
# dimension: capacity {
#   hidden:  yes
#   type: number
#   sql: ${TABLE}.capacity ;;
# }

# dimension: primary_key {
#   primary_key: yes
#   hidden: yes
#   sql: CONCAT(${TABLE}.night, ${TABLE}.complex, ${TABLE}.bedroom) ;;
# }

# measure: capacity_measure  {
#   view_label: "Metrics"
#   label: "Capacity"
#   description: "Number of available room nights bookable"
#   type: sum
#   sql: ${capacity} ;;
#   drill_fields: [night, complexes.title, bedroom, capacity]
# }
# }


# OLD - Backup 09-16-20
#   derived_table: {
#     sql:
#
#     SELECT
#       TIMESTAMP(capacities.night) AS night,
#         capacities.bedroomtype as bedroom,
#
#       {% if complexes.title._is_selected %}
#         complex,
#       {% endif %}
#       COALESCE(SUM(capacities.capacity), 0) AS capacity
#     FROM
#       capacities  AS capacities
#     GROUP BY 1
#       {% if complexes.title._is_selected %}
#         ,2,
#         3
#       {% endif %}
# ;;
#   }
