view: kobject_reservation {
  derived_table: {
    sql:

    select kobject_reservation.*, complexes.title complexes_title, internaltitle property_short_code
    from kustomer.kobject_reservation LEFT JOIN complexes ON LEFT(kobject_reservation.custom_unit_str,3) = complexes.internaltitle

    ;;

      datagroup_trigger: kustomer_default_datagroup
      # indexes: ["night","transaction"]
      # publish_as_db_view: yes
    }
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.id ;;
    }

    dimension_group: _fivetran_synced {
      type: time
      hidden: yes
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}._fivetran_synced ;;
    }

    dimension_group: created {
      hidden: yes
      type: time
      # view_label: "Date Dimensions"
      # group_label: "Kobject Reservation Created Date"
      # label: ""
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


    dimension: custom_additional_guests_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_additional_guests_str ;;
    }

    dimension_group: custom_booking_date {
      type: time
      hidden: yes
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.custom_booking_date_at ;;
    }

    dimension: custom_cancellation_date_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_cancellation_date_str ;;
    }

    dimension_group: custom_check_in_date_local {
      type: time
      hidden: yes
      # view_label: "Date Dimensions"
      # group_label: "Kobject Reservation Checkin Date"
      # label: ""
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.custom_check_in_date_local_at ;;
    }

    dimension: custom_check_in_date_local_pretty_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_check_in_date_local_pretty_str ;;
    }

    dimension: custom_check_in_day_local_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_check_in_day_local_str ;;
    }

    dimension_group: custom_check_out_date_local {
      hidden: yes
      # view_label: "Date Dimensions"
      # group_label: "Kobject Reservation Checkout Date"
      # label: ""
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
      sql: ${TABLE}.custom_check_out_date_local_at ;;
    }

    dimension: custom_check_out_date_local_pretty_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_check_out_date_local_pretty_str ;;
    }

    dimension: custom_check_out_day_local_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_check_out_day_local_str ;;
    }

    dimension: custom_complex_address_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_complex_address_str ;;
    }

    dimension: custom_complex_title_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_complex_title_str ;;
    }

    dimension: custom_confirmation_code_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_confirmation_code_str ;;
    }

    dimension: custom_guest_background_check_status_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_guest_background_check_status_str ;;
    }

    dimension: custom_guest_id_check_status_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_guest_id_check_status_str ;;
    }

    dimension: custom_guest_is_verified_bool {
      type: yesno
      hidden: yes
      sql: ${TABLE}.custom_guest_is_verified_bool ;;
    }

    dimension: custom_guest_name_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_guest_name_str ;;
    }

    dimension: custom_guests_count_num {
      hidden: yes
      type: number
      sql: ${TABLE}.custom_guests_count_num ;;
    }

    dimension: custom_guesty_id_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_guesty_id_str ;;
    }

    dimension: custom_guesty_link_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_guesty_link_str ;;
    }

    dimension: custom_is_verified_bool {
      type: yesno
      hidden: yes
      sql: ${TABLE}.custom_is_verified_bool ;;
    }

    dimension: custom_license_plate_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_license_plate_str ;;
    }

    dimension: custom_notes_txt {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_notes_txt ;;
    }

    dimension: custom_paid_status_bool {
      type: yesno
      hidden: yes
      sql: ${TABLE}.custom_paid_status_bool ;;
    }

    dimension: custom_parking_bool {
      type: yesno
      hidden: yes
      sql: ${TABLE}.custom_parking_bool ;;
    }

    dimension: custom_pets_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_pets_str ;;
    }

    dimension: custom_planned_arrival_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_planned_arrival_str ;;
    }

    dimension: custom_planned_depature_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_planned_depature_str ;;
    }

    dimension: custom_source_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_source_str ;;
    }

    dimension: custom_status_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_status_str ;;
    }

    dimension: custom_timezone_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_timezone_str ;;
    }

    dimension: custom_unit_str {
      hidden: yes
      type: string
      sql: ${TABLE}.custom_unit_str ;;
    }

    dimension: complexes_title {
      hidden: yes
      type: string
      sql: ${TABLE}.complexes_title ;;
    }

    dimension: property_short_code {
      hidden: yes
      type: string
      sql: ${TABLE}.property_short_code ;;
    }

    dimension: propertycode {
      hidden: yes
      type: string
      sql: LEFT(${TABLE}.custom_unit_str,3) ;;
    }

    dimension_group: custom_verified_at {
      type: time
      hidden: yes
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.custom_verified_at_at ;;
    }

    dimension: customer_id {
      type: string
      hidden: yes
      sql: ${TABLE}.customer_id ;;
    }

    dimension: external_id {
      type: string
      hidden: yes
      sql: ${TABLE}.external_id ;;
    }

    dimension: name {
      type: string
      hidden: yes
      sql: ${TABLE}.name ;;
    }

    dimension: org_id {
      type: string
      hidden: yes
      sql: ${TABLE}.org_id ;;
    }

    dimension: title {
      type: string
      hidden: yes
      sql: ${TABLE}.title ;;
    }

    dimension_group: updated {
      type: time
      hidden: yes
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.updated_at ;;
    }

    measure: count_reservations {
      type: count_distinct
      hidden: yes
      sql: ${TABLE}.custom_confirmation_code_str ;;
      drill_fields: [id, name]
    }
  # measure: reservations_Kontrol {
  #   type: count_distinct
  #   sql: case when ${issue_categories_1.Kontrol_Influenced}=True then
  #   ${custom_confirmation_code_str}  ELSE NULL end ;;
  #   drill_fields: [custom_confirmation_code_str]
  # }


  }
