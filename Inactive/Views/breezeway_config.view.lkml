view: breezeway_config {
  derived_table: {
    sql: SELECT units.nickname as units_nickname,
              case when sub.BD = "studio" then concat(sub.BD,", ",sub.BA,"BA") else
              concat(sub.BD,"BD, ",sub.BA,"BA") END as BD_BA

      FROM `bigquery-analytics-272822.mongo.units` units
      JOIN (select units1.nickname,
            case when units1.bedrooms = 0 THEN "studio" else cast(units1.bedrooms as string) end as BD,
            case when units1.bathrooms is null then "xyz" else cast(units1.bathrooms as string) end as BA
              FROM `bigquery-analytics-272822.mongo.units` as units1) sub on sub.nickname = units.nickname
      GROUP BY 1,2
      ORDER BY 1
       ;;
  }
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
 dimension: units_nickname {
     type: string
     sql: ${TABLE}.units_nickname ;;
   }
#
#   dimension: units_propertyinternaltitle {
#     type: string
#     sql: ${TABLE}.units_propertyinternaltitle ;;
#   }
#
#   dimension: units_propertyexternaltitle {
#     type: string
#     sql: ${TABLE}.units_propertyexternaltitle ;;
#   }

  dimension: BD_BA {
    type: string
    sql: ${TABLE}.BD_BA ;;
  }}


#   set: detail {
#     fields: [units_nickname, units_propertyinternaltitle, units_propertyexternaltitle, BD_BA]
#   }
# }
