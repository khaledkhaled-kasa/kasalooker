view: company {
  derived_table: {
    sql:

    WITH company_mod as (
SELECT id, REPLACE(company.name," ","") as name_modified, title building_title, internaltitle property_short_code
FROM kustomer.company
JOIN complexes ON
(lower(company.name) LIKE CONCAT('%',lower(complexes.title),'%'))
OR company.name LIKE CONCAT('%',complexes.internaltitle,'%'))

SELECT company.*, company_mod.name_modified, company_mod.building_title, company_mod.property_short_code
FROM kustomer.company LEFT JOIN company_mod
ON company.id = company_mod.id

    ;;

      datagroup_trigger: kustomer_default_datagroup
      # indexes: ["night","transaction"]
      # publish_as_db_view: yes
    }

    dimension: title_modified {
      label: "Building Title (Kustomer Company Name)"
      description: "This building title has been modified to include Kustomer company name wherever applicable"
      type: string
      sql: CASE WHEN ${complexes.title} IS NOT NULL THEN ${complexes.title}
            WHEN ${TABLE}.building_title IS NOT NULL THEN ${TABLE}.building_title
            ELSE NULL
            END;;
    }

    dimension: propcode_modified {
      label: "Property Code (Kustomer Company Name)"
      description: "This property code has been modified to include Kustomer company name wherever applicable"
      type: string
      sql: CASE WHEN ${units.propcode} IS NOT NULL THEN ${units.propcode}
            WHEN ${TABLE}.property_short_code IS NOT NULL THEN ${TABLE}.property_short_code
            ELSE NULL
            END;;
    }

    dimension: id {
      hidden: yes
      primary_key: yes
      type: string
      sql: ${TABLE}.id ;;
    }


    dimension_group: created {
      hidden: yes
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.created_at ;;
    }

    dimension: created_by {
      hidden: yes
      type: string
      sql: ${TABLE}.created_by ;;
    }

    dimension: external_id {
      hidden: yes
      type: string
      sql: ${TABLE}.external_id ;;
    }

    dimension_group: modified {
      hidden: yes
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.modified_at ;;
    }

    dimension: modified_by {
      hidden: yes
      type: string
      sql: ${TABLE}.modified_by ;;
    }

    dimension: name {
      hidden: yes
      label: "Company"
      type: string
      sql: ${TABLE}.name ;;
    }

    dimension: name_mod {
      label: "Company"
      type: string
      sql: REPLACE(${TABLE}.name," ","") ;;
    }

    dimension: org_id {
      hidden: yes
      type: string
      sql: ${TABLE}.org_id ;;
    }

  }
