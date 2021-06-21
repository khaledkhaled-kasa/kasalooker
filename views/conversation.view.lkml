view: conversation {
  label: "Conversation"

  derived_table: {
    sql:

WITH conversation_reservation_mapped as
(WITH prioritized_table AS (SELECT distinct customer_id, conversation_id, kobject_id_mapped, priority, row_number() OVER(PARTITION BY customer_id, conversation_id ORDER BY priority asc) AS rank
FROM
(SELECT c.id AS customer_id, custom_complex_title_str AS complex, custom_confirmation_code_str AS confirmationcode, cast(custom_booking_date_at AS DATE) AS booking_date,
cast(custom_check_in_date_local_at AS DATE) AS checkin_date, cast(custom_check_out_date_local_at AS DATE) AS checkout_date, t1.conversation_id, t1.conversation_created, t1.conversation_text,

CASE WHEN ((t1.conversation_created >= cast(custom_check_in_date_local_at AS DATE) AND t1.conversation_created < cast(custom_check_out_date_local_at AS DATE))
AND custom_status_str IN ("confirmed","checked_in")) THEN kor.id
WHEN (t1.conversation_created >= cast(custom_check_in_date_local_at AS DATE) AND t1.conversation_created < cast(custom_check_out_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created = cast(custom_check_out_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created = cast(custom_booking_date_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN cast(custom_booking_date_at AS DATE) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 5)) AND custom_status_str IN ("confirmed","checked_in")) THEN kor.id
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 15)) AND custom_status_str IN ("confirmed","checked_in")) THEN kor.id
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 30)) AND custom_status_str IN ("confirmed","checked_in")) THEN kor.id
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 45)) AND custom_status_str IN ("confirmed","checked_in")) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_booking_date_at AS DATE)-10) AND cast(custom_booking_date_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-10) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-20) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-30) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-45) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-60) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-90) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-120) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-150) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-180) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-210) AND cast(custom_check_in_date_local_at AS DATE)) THEN kor.id
ELSE "No Reservation in Range"
END kobject_id_mapped,

CASE WHEN ((t1.conversation_created >= cast(custom_check_in_date_local_at AS DATE) AND t1.conversation_created < cast(custom_check_out_date_local_at AS DATE))
AND custom_status_str IN ("confirmed","checked_in")) THEN "a"
WHEN (t1.conversation_created >= cast(custom_check_in_date_local_at AS DATE) AND t1.conversation_created < cast(custom_check_out_date_local_at AS DATE)) THEN "b"
WHEN (t1.conversation_created = cast(custom_check_out_date_local_at AS DATE)) THEN "c"
WHEN (t1.conversation_created = cast(custom_booking_date_at AS DATE)) THEN "d"
WHEN (t1.conversation_created BETWEEN cast(custom_booking_date_at AS DATE) AND cast(custom_check_in_date_local_at AS DATE)) THEN "e"
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 5)) AND custom_status_str IN ("confirmed","checked_in")) THEN "f"
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 15)) AND custom_status_str IN ("confirmed","checked_in")) THEN "g"
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 30)) AND custom_status_str IN ("confirmed","checked_in")) THEN "h"
WHEN ((t1.conversation_created BETWEEN cast(custom_check_in_date_local_at AS DATE) AND (cast(custom_check_out_date_local_at AS DATE) + 45)) AND custom_status_str IN ("confirmed","checked_in")) THEN "i"
WHEN (t1.conversation_created BETWEEN (cast(custom_booking_date_at AS DATE)-10) AND cast(custom_booking_date_at AS DATE)) THEN "j"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-10) AND cast(custom_check_in_date_local_at AS DATE)) THEN "k"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-20) AND cast(custom_check_in_date_local_at AS DATE)) THEN "l"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-30) AND cast(custom_check_in_date_local_at AS DATE)) THEN "m"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-45) AND cast(custom_check_in_date_local_at AS DATE)) THEN "n"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-60) AND cast(custom_check_in_date_local_at AS DATE)) THEN "o"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-90) AND cast(custom_check_in_date_local_at AS DATE)) THEN "p"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-120) AND cast(custom_check_in_date_local_at AS DATE)) THEN "q"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-150) AND cast(custom_check_in_date_local_at AS DATE)) THEN "r"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-180) AND cast(custom_check_in_date_local_at AS DATE)) THEN "s"
WHEN (t1.conversation_created BETWEEN (cast(custom_check_in_date_local_at AS DATE)-210) AND cast(custom_check_in_date_local_at AS DATE)) THEN "t"
ELSE "u"
END priority

FROM kustomer.customer c
join kustomer.kobject_reservation kor on c.id = kor.customer_id
join
(SELECT conv.customer_id AS cust_id, conv.id AS conversation_id, cast(conv.created_at AS DATE) AS conversation_created, conv.name AS conversation_text
FROM kustomer.conversation conv
)t1
ON c.id = t1.cust_id
--AND custom_confirmation_code_str is not null
)t2
ORDER BY 1,2,4)
SELECT prioritized_table.*
FROM prioritized_table
WHERE prioritized_table.rank = 1)
SELECT conversation.*, conversation_reservation_mapped.kobject_id_mapped, DATE(_fivetran_synced) as partition_date
FROM kustomer.conversation left join conversation_reservation_mapped
ON conversation.customer_id = conversation_reservation_mapped.customer_id
AND conversation.id = conversation_reservation_mapped.conversation_id

;;


      datagroup_trigger: kustomer_default_datagroup
      # indexes: ["night","transaction"]
      publish_as_db_view: yes
      partition_keys: ["partition_date"]

    }
    drill_fields: [id, name, median_first_response_time]

    dimension: id {
      primary_key: yes
      hidden: no
      type: string
      sql: ${TABLE}.id ;;
    }

    dimension: conversation_trip_phase {
      type: string
      description: "This will identify the trip phase based on the time the conversation was created. Reservations not picked up within range of the customer's conversations would not be assigned a trip phase."
      sql: CASE
          WHEN ${created_date} < ${reservations_kustomer.checkin_date} THEN "Pre-Trip"
          WHEN ${created_date} = ${reservations_kustomer.checkin_date} THEN "Day of Check-in"
          WHEN ${created_date} > ${reservations_kustomer.checkin_date} AND ${created_date} < ${reservations_kustomer.checkout_date} THEN "On-Trip"
          WHEN ${created_date} = ${reservations_kustomer.checkout_date} THEN "Day of Check-out"
          WHEN ${created_date} > ${reservations_kustomer.checkout_date} THEN "Post-Trip"
          ELSE "No Reservation in Range"
          END
          ;;
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
      type: time
      group_label: "Conversation Created Date"
      label: ""
      timeframes: [
        raw,
        time,
        date,
        day_of_week,
        week,
        month,
        quarter,
        year,
        time_of_day
      ]
      sql: ${TABLE}.created_at ;;
    }

    dimension: created_by {
      hidden: yes
      type: string
      sql: ${TABLE}.created_by ;;
    }

    dimension: kobject_id_mapped {
      hidden: no
      type: string
      sql: ${TABLE}.kobject_id_mapped ;;
    }

    dimension: kobject_id_mapped_star {
      label: "Kobject Mapping Category"
      hidden: no
      type: string
      sql: CASE WHEN ${TABLE}.kobject_id_mapped is null AND ${company.title_modified} is null then null
            WHEN ${TABLE}.kobject_id_mapped = 'No Reservation in Range' THEN 'No Reservation in Range'
            WHEN ${TABLE}.kobject_id_mapped is not null AND ${TABLE}.kobject_id_mapped != 'No Reservation in Range' AND ${units._id} is null THEN "No Units Tied"
            ELSE "Available Units Mapped"
            END;;
    }

    dimension: custom_air_bnb_thread_id_num {
      type: number
      hidden: yes
      value_format_name: id
      sql: ${TABLE}.custom_air_bnb_thread_id_num ;;
    }

    dimension: custom_airbnb_link_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_airbnb_link_str ;;
    }

    dimension: custom_airbnb_thread_id_str {
      type: number
      hidden: yes
      value_format_name: id
      sql: ${TABLE}.custom_airbnb_thread_id_str ;;
    }

    dimension: custom_airbnb_user_id_str {
      type: number
      hidden: yes
      value_format_name: id
      sql: ${TABLE}.custom_airbnb_user_id_str ;;
    }

    dimension: custom_background_check_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_background_check_str ;;
    }

    dimension: custom_background_check_tree {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_background_check_tree ;;
    }

    dimension: custom_billing_new_str {
      type: string
      hidden: yes
      sql: ${TABLE}.custom_billing_new_str ;;
    }

    dimension: billing_channel {
      type: string
      sql: CASE
          WHEN ${custom_billing_new_tree} LIKE "airbnb%" THEN "Airbnb"
          WHEN ${custom_billing_new_tree} LIKE "non_airbnb%" THEN "Non Airbnb"
          ELSE ${custom_billing_new_tree}
          END ;;
    }

    dimension: is_billing_category {
      type: yesno
      label: "Billing Category"
      description: "This will pull all 'Billing' related-issues from the old and new issue categorization."
      sql:
          ${custom_issue_category_tree_sub_renamed} LIKE "%billing%"
          OR
          lower(${custom_issue_category_1_tree_main_clean}) LIKE "%billing%"
          OR
          lower(${custom_issue_category_2_tree_main_clean}) LIKE "%billing%"
          OR
          lower(${custom_issue_category_3_tree_main_clean}) LIKE "%billing%"
          ;;

          # CASE
          # WHEN custom_issue_category_tree_sub_renamed LIKE "%billing%" THEN "Yes"
          # WHEN lower(${custom_issue_category_1_tree_main_clean}) LIKE "%billing%" THEN "Yes"
          # WHEN lower(${custom_issue_category_2_tree_main_clean}) LIKE "%billing%" THEN "Yes"
          # WHEN lower(${custom_issue_category_3_tree_main_clean}) LIKE "%billing%" THEN "Yes"
          # ELSE "No"
          # END
          # ;;
      }

      dimension: custom_billing_new_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_billing_new_tree ;;
      }

      dimension: custom_billing_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_billing_tree ;;
      }

      dimension: custom_booking_channel_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_booking_channel_str ;;
      }

      dimension: custom_booking_date_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_booking_date_str ;;
      }

      dimension: custom_ci_review_rating_num {
        type: number
        hidden: yes
        sql: ${TABLE}.custom_ci_review_rating_num ;;
      }

      dimension: custom_dates_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_dates_str ;;
      }

      dimension: custom_escalate_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_escalate_bool ;;
      }

      dimension: custom_escalation_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_escalation_tree ;;
      }

      dimension: custom_finance_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_finance_tree ;;
      }

      dimension: custom_guesty_link_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_guesty_link_str ;;
      }

      dimension: custom_handover_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_handover_bool ;;
      }

      dimension: custom_hk_operations_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_hk_operations_bool ;;
      }

      dimension: custom_housekeeping_new_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_housekeeping_new_tree ;;
      }

      dimension: custom_is_verified_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_is_verified_bool ;;
      }

      dimension: custom_issue_category_tree {
        group_label: "Issue Category (Old)"
        description: "This was applicable before rolling out of the new issue categorization in late March-2021."
        type: string
        sql: custom_issue_category_tree ;;
      }

      dimension: custom_issue_category_tree_main {
        group_label: "Issue Category (Old)"
        description: "This was applicable before rolling out of the new issue categorization in late March-2021."
        label: "Main Issue Category"
        type: string
        sql:CASE
          WHEN ${custom_issue_category_tree} is null then "Blank"
          WHEN ${custom_issue_category_tree} LIKE 'background_check%' THEN "Guest Verification"
          WHEN ${custom_issue_category_tree} LIKE "department_transfer%" THEN "Department Transfer"
          WHEN ${custom_issue_category_tree} LIKE "no_response_other%" THEN "No response / other"
          WHEN ${custom_issue_category_tree} LIKE "on_trip%" THEN "On Trip"
          WHEN ${custom_issue_category_tree} LIKE "post_trip%" THEN "Post Trip"
          WHEN ${custom_issue_category_tree} LIKE "pre_trip%" THEN "Pre Trip"
          WHEN ${custom_issue_category_tree} LIKE "reservation_changes%" THEN "Reservation Changes"
          WHEN ${custom_issue_category_tree} LIKE "unit_access%" THEN "Unit Access"
          WHEN ${custom_issue_category_tree} LIKE "ls_guest_issues%" THEN "PS Guest Issues"
          WHEN ${custom_issue_category_tree} LIKE "ls_operations%" THEN "PS Operations"
          ELSE "Requires Label"
          END ;;
      }

      dimension: custom_issue_category_tree_sub {
        label: "Sub Issue Category"
        group_label: "Issue Category (Old)"
        description: "This was applicable before rolling out of the new issue categorization in late March-2021."
        hidden: yes
        type: string
        sql: regexp_replace(${custom_issue_category_tree}, '^[^.]*.', '') ;;
      }

      dimension: custom_issue_category_tree_sub_renamed {
        label: "Sub Issue Category"
        group_label: "Issue Category (Old)"
        description: "Renamed Sub Issue Category - This was applicable before rolling out of the new issue categorization in late March-2021."
        type: string
        sql:  CASE
          WHEN ${custom_issue_category_tree_sub} = 'billing1' THEN "partner_success"
          WHEN ${custom_issue_category_tree_sub} = "prop_ops1" THEN "billing"
          WHEN ${custom_issue_category_tree_sub} = "prop_ops2" THEN "maintenance"
          WHEN ${custom_issue_category_tree_sub} = "failed_check" THEN "id_verification_follow-up"
          WHEN ${custom_issue_category_tree_sub} = "needs_check" THEN "gv_tech_issue"
          WHEN ${custom_issue_category_tree_sub} = "passed_check" THEN "successful_gv_special_requests"
          WHEN ${custom_issue_category_tree_sub} = "account_credentials" THEN "account_credentials_&_passcodes"
          WHEN ${custom_issue_category_tree_sub} = "no_response_needed" THEN "other_no_applicable_category"
          WHEN ${custom_issue_category_tree_sub} = "passcodes" THEN "property_notifications"
          WHEN ${custom_issue_category_tree_sub} = "kasa_kandidates1" THEN "update_request_FROM_hk"
          WHEN ${custom_issue_category_tree_sub} = "order_confirmations" THEN "order_confirmations_update_no_action"
          WHEN ${custom_issue_category_tree_sub} = "unsure" THEN "booking_platform_notification"
          WHEN ${custom_issue_category_tree_sub} = "ac_heat_thermostat_troubleshooting" THEN "hvac_issues_no_follow-up"
          WHEN ${custom_issue_category_tree_sub} IN ("guest_alerts1.noise_alert1","guest_alerts1.other_alert1","guest_alerts1.smoking_alert1", "guest_alerts1.no_fly") THEN "guest_alerts"
          WHEN ${custom_issue_category_tree_sub} = "late_check_out_request" THEN "complaint_about_guest"
          WHEN ${custom_issue_category_tree_sub} = "noise_complaints_FROM_the_guest" THEN "complaint_about_neighbor"
          WHEN ${custom_issue_category_tree_sub} = "packages" THEN "towing_license_plate"
          WHEN ${custom_issue_category_tree_sub} = "packages1" THEN "packages_and_mail"
          WHEN ${custom_issue_category_tree_sub} = "missing_item" THEN "missing_access_item_check-out"
          WHEN ${custom_issue_category_tree_sub} = "airbnb_pre_approval" THEN "airbnb_inquiries_request"
          WHEN ${custom_issue_category_tree_sub} IN ("alerts.double_booking","alerts.party_risk","alerts.same_day_reservation","alerts.same_day_reservation", "alerts.suspicious_booking") THEN "alerts"
          WHEN ${custom_issue_category_tree_sub} = "airbnb_pre_approval" THEN "airbnb_inquiries_request"
          WHEN ${custom_issue_category_tree_sub} = "airbnb_pre_approval" THEN "airbnb_inquiries_request"
          WHEN ${custom_issue_category_tree_sub} = "airbnb_pre_approval" THEN "airbnb_inquiries_request"
          WHEN ${custom_issue_category_tree_sub} = "airbnb_pre_approval" THEN "airbnb_inquiries_request"
          WHEN ${custom_issue_category_tree_sub} IN ("crime_ls","crime_serious_disturbance") THEN "crime_serious_disturbance"
          WHEN ${custom_issue_category_tree_sub} = "extensions1" THEN "alterations_extensions"
          WHEN ${custom_issue_category_tree_sub} = "fob_missing" THEN "access_item_missing"
          WHEN ${custom_issue_category_tree_sub} = "keycard_fob_not_working" THEN "access_item_not_working"
          ELSE ${custom_issue_category_tree_sub}
          END ;;
      }

      dimension: drop_down_menu_section {
        label: "Drop Down Menu Section"
        group_label: "Issue Category (Old)"
        description: "Trust & Safety, GX Escalation or Department Transfer. This was applicable before rolling out of the new issue categorization in late March-2021."
        type: string
        sql:  CASE
          WHEN ${custom_background_check_tree} is not null THEN "Trust & Safety"
          WHEN ${custom_escalation_tree} is not null THEN "GX Escalation"
          WHEN ${custom_reservations_tree} is not null THEN "GX Escalation"
          WHEN ${custom_missing_access_item_tree} is true THEN "GX Escalation"
          WHEN ${custom_property_issue_tree} is not null THEN "Department Transfer"
          WHEN ${custom_housekeeping_new_tree} is not null THEN "Department Transfer"
          WHEN ${custom_billing_new_tree} is not null THEN "Department Transfer"
          WHEN ${custom_finance_tree} is not null THEN "Department Transfer"
          WHEN ${custom_channel_management_tree} is not null THEN "Department Transfer"
          WHEN ${custom_coordinators_tree} is not null THEN "Department Transfer"
          ELSE NULL
          END ;;
      }

      dimension: drop_down_menu_item {
        label: "Drop Down Menu Item"
        group_label: "Issue Category (Old)"
        description: "This was applicable before rolling out of the new issue categorization in late March-2021."
        type: string
        sql:  CASE
          WHEN ${custom_background_check_tree} is not null THEN "Background Check"
          WHEN ${custom_escalation_tree} is not null THEN "Escalations"
          WHEN ${custom_reservations_tree} is not null THEN "Reservations"
          WHEN ${custom_missing_access_item_tree} is true THEN "Missing Access Items"
          WHEN ${custom_property_issue_tree} is not null THEN "Maintenance"
          WHEN ${custom_housekeeping_new_tree} is not null THEN "Housekeeping"
          WHEN ${custom_billing_new_tree} is not null THEN "GX Billing"
          WHEN ${custom_finance_tree} is not null THEN "Finance"
          WHEN ${custom_channel_management_tree} is not null THEN "Distributions"
          WHEN ${custom_coordinators_tree} is not null THEN "Coordinators"
          ELSE NULL
          END ;;
      }

      dimension: drop_down_menu_option {
        label: "Drop Down Menu Option"
        group_label: "Issue Category (Old)"
        description: "This will pull one drop down menu option per conversation. This was applicable before rolling out of the new issue categorization in late March-2021."
        type: string
        sql:  CASE
          WHEN ${custom_background_check_tree} is not null THEN ${custom_background_check_tree}
          WHEN ${custom_escalation_tree} is not null THEN ${custom_escalation_tree}
          WHEN ${custom_reservations_tree} is not null THEN ${custom_reservations_tree}
          WHEN ${custom_missing_access_item_tree} is true THEN "yes"
          WHEN ${custom_property_issue_tree} is not null THEN ${custom_property_issue_tree}
          WHEN ${custom_housekeeping_new_tree} is not null THEN ${custom_housekeeping_new_tree}
          WHEN ${custom_billing_new_tree} is not null THEN ${custom_billing_new_tree}
          WHEN ${custom_finance_tree} is not null THEN ${custom_finance_tree}
          WHEN ${custom_channel_management_tree} is not null THEN ${custom_channel_management_tree}
          WHEN ${custom_coordinators_tree} is not null THEN ${custom_coordinators_tree}
          ELSE NULL
          END ;;
      }

      dimension: custom_issue_category_1_tree {
        type: string
        label: "Issue Category #1"
        sql: CASE WHEN custom_issue_category_1_tree = 'guest_sentiment.late_arrival1' THEN 'guest_sentiment.late_arrival'
              ELSE custom_issue_category_1_tree
              END;;
      }

      dimension: custom_issue_category_1_tree_main {
        type: string
        hidden: yes
        label: "Issue Category #1 (Parent)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_1_tree}, '.')[OFFSET(0)],"_"," ")) ;;
      }

      dimension: custom_issue_category_1_tree_main_clean {
        type: string
        label: "Issue Category #1 (Parent)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  regexp_replace(${custom_issue_category_1_tree_main},"T S","T&S"),"R M","R&M"),"Io T","IoT"),"Cii","CII"),"Ps","PS"),"Kbc","KBC")
    ;;
      }

      dimension: custom_issue_category_1_tree_sub {
        type: string
        hidden: yes
        label: "Issue Category #1 (Sub)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_1_tree}, '.')[OFFSET(1)],"_"," ")) ;;
      }

      dimension: custom_issue_category_1_tree_sub_clean {
        type: string
        label: "Issue Category #1 (Sub)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  regexp_replace(
                    regexp_replace(
                      regexp_replace(
                        regexp_replace(
                          regexp_replace(${custom_issue_category_1_tree_sub},"T S","T&S"),"R M","R&M"),"3 P","3P"),"Cii","CII"),"Ps","PS"),"Kbc","KBC"),"Lts","LTS"),"Pw","PW"),"Hk","HK"),"Gv","GV")
    ;;
      }


      dimension: custom_issue_category_2_tree {
        label: "Issue Category #2"
        type: string
        sql: custom_issue_category_2_tree ;;
      }

      dimension: custom_issue_category_2_tree_main {
        type: string
        hidden: yes
        label: "Issue Category #2 (Parent)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_2_tree}, '.')[OFFSET(0)],"_"," ")) ;;
      }

      dimension: custom_issue_category_2_tree_main_clean {
        type: string
        label: "Issue Category #2 (Parent)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                 regexp_replace(${custom_issue_category_2_tree_main},"T S","T&S"),"R M","R&M"),"Io T","IoT"),"Cii","CII"),"Ps","PS"),"Kbc","KBC")
    ;;
      }

      dimension: custom_issue_category_2_tree_sub {
        type: string
        hidden: yes
        label: "Issue Category #2 (Sub)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_2_tree}, '.')[OFFSET(1)],"_"," ")) ;;
      }

      dimension: custom_issue_category_2_tree_sub_clean {
        type: string
        label: "Issue Category #2 (Sub)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  regexp_replace(
                    regexp_replace(
                      regexp_replace(
                        regexp_replace(
                          regexp_replace(${custom_issue_category_2_tree_sub},"T S","T&S"),"R M","R&M"),"3 P","3P"),"Cii","CII"),"Ps","PS"),"Kbc","KBC"),"Lts","LTS"),"Pw","PW"),"Hk","HK"),"Gv","GV")
    ;;
      }

      dimension: custom_issue_category_3_tree {
        label: "Issue Category #3"
        type: string
        sql: custom_issue_category_3_tree ;;
      }

      dimension: custom_issue_category_3_tree_main {
        type: string
        hidden: yes
        label: "Issue Category #3 (Parent)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_3_tree}, '.')[OFFSET(0)],"_"," ")) ;;
      }

      dimension: custom_issue_category_3_tree_main_clean {
        type: string
        label: "Issue Category #3 (Parent)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  regexp_replace(${custom_issue_category_3_tree_main},"T S","T&S"),"R M","R&M"),"Io T","IoT"),"Cii","CII"),"Ps","PS"),"Kbc","KBC")
    ;;
      }

      dimension: custom_issue_category_3_tree_sub {
        type: string
        hidden: yes
        label: "Issue Category #3 (Sub)"
        sql: INITCAP(regexp_replace(SPLIT(${custom_issue_category_3_tree}, '.')[OFFSET(1)],"_"," ")) ;;
      }

      dimension: custom_issue_category_3_tree_sub_clean {
        type: string
        label: "Issue Category #3 (Sub)"
        sql: regexp_replace(
          regexp_replace(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  regexp_replace(
                    regexp_replace(
                      regexp_replace(
                        regexp_replace(
                          regexp_replace(${custom_issue_category_3_tree_sub},"T S","T&S"),"R M","R&M"),"3 P","3P"),"Cii","CII"),"Ps","PS"),"Kbc","KBC"),"Lts","LTS"),"Pw","PW"),"Hk","HK"),"Gv","GV")
    ;;
      }


      dimension: custom_kasa_kandidate_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_kasa_kandidate_bool ;;
      }

      dimension: custom_channel_management_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_channel_management_tree ;;
      }

      dimension: custom_coordinators_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_coordinators_tree ;;
      }

      dimension: custom_landlord_success_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_landlord_success_bool ;;
      }

      dimension: custom_last_call_recovery_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_last_call_recovery_bool ;;
      }

      dimension: custom_long_term_stay_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_long_term_stay_bool ;;
      }

      dimension: custom_manager_follow_up_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_manager_follow_up_bool ;;
      }

      dimension: custom_missing_access_item_tree {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_missing_access_item_tree ;;
      }

      dimension: custom_my_custom_rating_thing_num {
        type: number
        hidden: yes
        sql: ${TABLE}.custom_my_custom_rating_thing_num ;;
      }

      dimension: custom_my_custom_str {
        type: number
        hidden: yes
        sql: ${TABLE}.custom_my_custom_str ;;
      }

      dimension: custom_origin_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_origin_tree ;;
      }

      dimension: custom_prop_unit_str {
        hidden: yes
        type: string
        sql: ${TABLE}.custom_prop_unit_str ;;
      }

      dimension: custom_property_issue_old_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_property_issue_old_bool ;;
      }


      dimension: custom_property_issue_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_property_issue_str ;;
      }

      dimension: custom_property_issue_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_property_issue_tree ;;
      }

      dimension: custom_reservations_tree {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_reservations_tree ;;
      }

      dimension: custom_return_to_inbox_in_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_return_to_inbox_in_str ;;
      }

      dimension: custom_rules_ran_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_rules_ran_bool ;;
      }

      dimension: custom_send_as_text_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_send_as_text_bool ;;
      }

      dimension_group: custom_set_reminder {
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
        sql: ${TABLE}.custom_set_reminder_at ;;
      }

      dimension: custom_ticket_category_str {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_ticket_category_str ;;
      }

      dimension: custom_urgent_bool {
        type: yesno
        hidden: yes
        sql: ${TABLE}.custom_urgent_bool ;;
      }

      dimension: custom_zendesk_ticket_url {
        type: string
        hidden: yes
        sql: ${TABLE}.custom_zendesk_ticket_url ;;
      }

      dimension_group: custom_zendesk_updated {
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
        sql: ${TABLE}.custom_zendesk_updated_at ;;
      }

      dimension: customer_id {
        type: string
        hidden: no
        sql: ${TABLE}.customer_id ;;
      }

      dimension: default_lang {
        hidden: yes
        type: string
        sql: ${TABLE}.default_lang ;;
      }

      dimension: deleted {
        type: yesno
        hidden: yes
        sql: ${TABLE}.deleted ;;
      }

      dimension_group: deleted {
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
        sql: ${TABLE}.deleted_at ;;
      }

      dimension: deleted_by {
        type: string
        hidden: yes
        sql: ${TABLE}.deleted_by ;;
      }

      dimension: direction {
        type: string
        sql: ${TABLE}.direction ;;
      }

      dimension: ended {
        type: yesno
        hidden: yes
        sql: ${TABLE}.ended ;;
      }

      dimension: external_id {
        type: string
        hidden: yes
        sql: ${TABLE}.external_id ;;
      }

      dimension: first_company_id {
        type: string
        hidden: yes
        sql: ${TABLE}.first_company_id ;;
      }

      dimension: first_company_name {
        type: string
        hidden: yes
        sql: ${TABLE}.first_company_name ;;
      }

      dimension_group: first_message_in_created {
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
        sql: ${TABLE}.first_message_in_created_at ;;
      }

      dimension: first_message_in_id {
        type: string
        hidden: yes
        sql: ${TABLE}.first_message_in_id ;;
      }

      dimension_group: first_message_in_sent {
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
        sql: ${TABLE}.first_message_in_sent_at ;;
      }

      dimension_group: first_response_created {
        type: time
        hidden: yes
        timeframes: [
          raw,
          time,
          date,
          hour_of_day,
          week,
          month,
          quarter,
          year
        ]
        sql: ${TABLE}.first_response_created_at ;;
      }


      dimension: first_response_id {
        type: string
        hidden: yes
        sql: ${TABLE}.first_response_id ;;
      }

      dimension: first_response_response_time {
        type: number
        hidden: yes
        sql: ${TABLE}.first_response_response_time ;;
      }

      dimension_group: first_response_sent {
        type: time
        hidden: yes
        timeframes: [
          raw,
          time,
          date,
          hour_of_day,
          week,
          month,
          quarter,
          year
        ]
        sql: ${TABLE}.first_response_sent_at ;;
      }

      dimension: first_response_time {
        type: number
        hidden: yes
        sql: ${TABLE}.first_response_time ;;
      }

      dimension_group: last_activity {
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
        sql: ${TABLE}.last_activity_at ;;
      }

      dimension_group: last_message {
        type: time
        hidden: no
        timeframes: [
          raw,
          time,
          date,
          week,
          month,
          quarter,
          year
        ]
        sql: ${TABLE}.last_message_at ;;
      }

      dimension: last_message_direction {
        hidden: yes
        type: string
        sql: ${TABLE}.last_message_direction ;;
      }

      dimension_group: last_message_out_created {
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
        sql: ${TABLE}.last_message_out_created_at ;;
      }

      dimension: last_message_out_message_id {
        type: string
        hidden: yes
        sql: ${TABLE}.last_message_out_message_id ;;
      }

      dimension_group: last_message_out_sent {
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
        sql: ${TABLE}.last_message_out_sent_at ;;
      }

      dimension: message_count {
        type: number
        hidden: yes
        sql: ${TABLE}.message_count ;;
      }

      dimension_group: modified {
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
        sql: ${TABLE}.modified_at ;;
      }

      dimension: modified_by {
        type: string
        hidden: yes
        sql: ${TABLE}.modified_by ;;
      }

      dimension: name {
        label: "Conversation Preview"
        type: string
        sql: ${TABLE}.name ;;
      }

      dimension: note_count {
        type: number
        sql: ${TABLE}.note_count ;;
      }

      dimension: org_id {
        type: string
        hidden: yes
        sql: ${TABLE}.org_id ;;
      }

      dimension: outbound_message_count {
        type: number
        sql: ${TABLE}.outbound_message_count ;;
      }

  dimension: inbound_message_count {
    type: number
    sql: ${message_count} - ${outbound_message_count} ;;
  }

      dimension: priority {
        type: number
        sql: ${TABLE}.priority ;;
      }

      dimension: reopen_count {
        type: number
        sql: ${TABLE}.reopen_count ;;
      }

      dimension: satisfaction {
        type: number
        sql: ${TABLE}.satisfaction ;;
      }

      dimension: satisfaction_level_channel {
        type: string
        sql: ${TABLE}.satisfaction_level_channel ;;
      }

      dimension_group: satisfaction_level_created {
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
        sql: ${TABLE}.satisfaction_level_created_at ;;
      }

      dimension: satisfaction_level_form {
        type: string
        hidden: yes
        sql: ${TABLE}.satisfaction_level_form ;;
      }

      dimension: satisfaction_level_form_response {
        type: string
        hidden: yes
        sql: ${TABLE}.satisfaction_level_form_response ;;
      }

      dimension: satisfaction_level_rating {
        type: number
        sql: ${TABLE}.satisfaction_level_rating ;;
      }

      dimension_group: satisfaction_level_scheduled_for {
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
        sql: ${TABLE}.satisfaction_level_scheduled_for ;;
      }

      dimension: satisfaction_level_score {
        type: number
        sql: ${TABLE}.satisfaction_level_score ;;
      }

      dimension_group: satisfaction_level_sent {
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
        sql: ${TABLE}.satisfaction_level_sent_at ;;
      }

      dimension: satisfaction_level_sent_by {
        type: string
        hidden: yes
        sql: ${TABLE}.satisfaction_level_sent_by ;;
      }

      dimension: satisfaction_level_sent_by_teams {
        type: string
        hidden: yes
        sql: ${TABLE}.satisfaction_level_sent_by_teams ;;
      }

      dimension: satisfaction_level_status {
        type: string
        sql: ${TABLE}.satisfaction_level_status ;;
      }

      dimension_group: satisfaction_level_updated {
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
        sql: ${TABLE}.satisfaction_level_updated_at ;;
      }

      dimension: sentiment_confidence {
        type: number
        sql: ${TABLE}.sentiment_confidence ;;
      }

      dimension: sentiment_polarity {
        type: number
        sql: ${TABLE}.sentiment_polarity ;;
      }

      dimension: snooze_count {
        type: number
        sql: ${TABLE}.snooze_count ;;
      }

      dimension: snooze_status {
        type: string
        sql: ${TABLE}.snooze_status ;;
      }

      dimension_group: snooze_status {
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
        sql: ${TABLE}.snooze_status_at ;;
      }

      dimension_group: snooze {
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
        sql: ${TABLE}.snooze_time ;;
      }

      dimension: status {
        type: string
        sql: ${TABLE}.status ;;
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

  dimension: issues {
    type: number
    sql: CASE
            WHEN ${custom_issue_category_1_tree} IS NOT NULL AND ${custom_issue_category_2_tree} IS NOT NULL AND ${custom_issue_category_3_tree} IS NOT NULL THEN 3
            WHEN ${custom_issue_category_1_tree} IS NOT NULL AND ${custom_issue_category_2_tree} IS NOT NULL AND ${custom_issue_category_3_tree} IS NULL THEN 2
            WHEN ${custom_issue_category_1_tree} IS NOT NULL AND ${custom_issue_category_2_tree} IS NULL AND ${custom_issue_category_3_tree} IS NULL THEN 1
          ELSE 0
          END;;

    }



####################### Average / Median First Response Time Required Dimensions

      dimension: is_first_message {
        hidden: yes
        type: yesno
        sql: message.sent_at = ${TABLE}.first_response_sent_at ;;
      }

      dimension: is_auto_false {
        hidden: yes
        type: yesno
        sql: message.auto = false ;;
      }

      dimension: is_direction_out {
        hidden: yes
        type: yesno
        sql: message.direction = 'out' ;;
      }

      dimension: is_direction_response_out {
        hidden: yes
        type: yesno
        sql: message.direction_type = 'response-out' ;;
      }

######## Team Metrics - THESE MEASURES ONLY APPLY TO KUSTOMETRICS

      ###### Messages Sent

      measure: messages_sent {
        view_label: "Metrics"
        label: "Messages Sent"
        description: "Outbound messages sent during the time period."
        type: count_distinct
        sql: ${message.id} ;;
        value_format: "###"
        filters: [is_auto_false: "yes", is_direction_out: "yes"]
      }


      measure: messages_sent_allocated {
        view_label: "Metrics"
        label: "Messages Sent (Allocated to Reservations)"
        description: "Outbound messages sent during the time period."
        type: count_distinct
        sql: ${message.id} ;;
        value_format: "###"
        filters: [is_auto_false: "yes", is_direction_out: "yes", kobject_reservation.id: "-NULL"]
      }

      measure: reservations_count {
        type: count_distinct
        view_label: "Metrics"
        label: "Unique Reservations from Messages Sent"
        description: "Number of unique reservations for messages sent"
        sql: ${kobject_reservation.id} ;;
        filters: [is_auto_false: "yes", is_direction_out: "yes"]
      }

      measure: messages_sent_per_reservation {
        type: number
        view_label: "Metrics"
        label: "Messages Sent (Allocated) / Reservations"
        description: "Number of outbound messages sent per unique reservations"
        value_format: "0.0"
        sql: ${messages_sent_allocated} / ${reservations_count} ;;
      }

###### Unique Conversations Messaged

      measure: unique_conversations_messaged {
        view_label: "Metrics"
        label: "Unique Conversations Messaged"
        description: "Unique # of conversations which contain at least one message sent by that agent."
        type: count_distinct
        sql: ${message.conversation_id} ;;
        value_format: "###"
        filters: [is_auto_false: "yes", is_direction_out: "yes"]
      }


###### Unique Conversations

      measure: unique_conversations {
        view_label: "Metrics"
        label: "Unique Conversations"
        description: "Unique # of conversations (doesn't contain at least one message sent by that agent)"
        type: count_distinct
        sql: ${message.conversation_id} ;;
        value_format: "###"
        drill_fields: [customer_id, id, created_date, message.created_date]
      }


###### Unique Conversations including notes

      measure: unique_conversations_star {
        view_label: "Metrics"
        label: "Unique Conversations (Incl. Notes)"
        description: "Unique # of conversations (including notes). This is used for issue categorization."
        type: count_distinct
        sql: ${id} ;;
        value_format: "###"
        drill_fields: [conversation.name]
      }



###### Unique Customers Messaged

      measure: unique_customers_messaged {
        view_label: "Metrics"
        label: "Unique Customers Messaged"
        description: "Unique # of customers which received at least one message FROM the agent."
        type: count_distinct
        sql: ${message.customer_id} ;;
        value_format: "###"
        filters: [message_count: ">0", is_auto_false: "yes", is_direction_out: "yes"]
      }



###### Average Sent Messages per Conversation

      measure: messages_per_conversation {
        view_label: "Metrics"
        label: "Average Sent Messages per Conversation"
        description: "Total number of messages this agent sent divided by the number of conversations they are in."
        type: number
        sql: ${messages_sent} /  nullif(${unique_conversations},0);;
        value_format: "###.0"
      }

###### Average Sent Messages per Customer

      measure: messages_per_customer {
        view_label: "Metrics"
        label: "Average Sent Messages per Customer"
        description: "Total number of messages this agent sent divided by the number of customers they were sent to."
        type: number
        sql: ${messages_sent} /  nullif(${unique_customers_messaged},0);;
        value_format: "###.0"
      }


##### Average Response Time - In Progress

      measure: average_response_time_hrs {
        view_label: "Metrics"
        label: "Average Response Time (hrs)"
        description: "Average time between each inbound message and the corresponding outbound agent's response."
        type: average
        value_format: "###0.0"
        sql: ${conversation.first_response_time} /(60*1000*60);;
        filters: [first_response_time: ">0", is_auto_false: "yes", is_direction_out: "yes"]
      }

###### Average First Response Time

      measure: average_first_response_time_mins {
        view_label: "Metrics"
        label: "Average First Response Time (mins)"
        description: "Average time between the customer's first inbound message and the agent's response."
        type: average
        value_format: "###0.0"
        sql: ${conversation.first_response_time} /(60*1000);;
        filters: [first_response_time: ">0", is_first_message: "yes", is_auto_false: "yes", is_direction_out: "yes"]
      }

      measure: average_first_response_time_hrs {
        view_label: "Metrics"
        label: "Average First Response Time (hrs)"
        description: "Average time between the customer's first inbound message and the agent's response."
        type: average
        value_format: "###0.0"
        sql: ${conversation.first_response_time} /(60*1000*60);;
        filters: [first_response_time: ">0", is_first_message: "yes", is_auto_false: "yes", is_direction_out: "yes"]
      }


####### Median First Response Time

      measure: median_first_response_time {
        view_label: "Metrics"
        label: "Median First Response Time (mins)"
        description: "Median time between the customer's first inbound message and the agent's response. (Message Level)"
        type: median
        value_format: "###0.0"
        sql: ${conversation.first_response_time} /(60*1000);;
        filters: [first_response_time: ">0", is_first_message: "yes", is_auto_false: "yes", is_direction_out: "yes"]
      }


###### Average Time to First Resolution - STILL IN PROGRESS

###### Median Time to First Resolution - STILL IN PROGRESS

###### Total Time Logged in - STILL IN PROGRESS

###### Messages Sent WITH Shortcuts

      measure: messages_with_shortcuts {
        view_label: "Metrics"
        label: "Messages WITH Shortcuts"
        description: "Outbound messages sent WITH shortcuts during the time period."
        type: count_distinct
        sql: CASE WHEN ${message_shortcut.shortcut_id} is not null
          THEN ${message.id}
          ELSE NULL
          END;;
        value_format: "###"
        filters: [is_auto_false: "yes", is_direction_out: "yes"]
      }

###### Percentage of Messages Sent WITH Shortcuts


      measure: count_messages {
        view_label: "Metrics"
        hidden: yes
        type: count_distinct
        sql: ${message.id} ;;
        value_format: "###"
        filters: [is_auto_false: "yes", is_direction_out: "yes"]
      }

      measure: percentage_message_with_shortcuts {
        view_label: "Metrics"
        label: "Percentage of Message Sent WITH Shortcuts"
        description: "Percentage of messages that were sent WITH a shortcut."
        type: number
        sql: ${messages_with_shortcuts} /  NULLIF(${count_messages},0);;
        value_format: "0.0%"
      }

      measure: count_by_channel {
        view_label: "Metrics"
        label: "Conversation by Channel Count"
        type: count_distinct
        sql: CONCAT(${conversation_channel.conversation_id},${conversation_channel.name}) ;;
        filters: [conversation.direction: "in"]
      }


      measure: total_issues {
        type: sum
        sql: ${issues} ;;
      }

      measure: total_tech_related_issues {
        type: sum
        sql: CASE WHEN ${issue_categories_1.tech_influenced}
                  OR ${issue_categories_2.tech_influenced}
                  OR ${issue_categories_3.tech_influenced} THEN ${issues}
            ELSE NULL
            END;;
      }

  measure: total_kontrol_related_issues {
    type: sum
    sql:  CASE WHEN ${issue_categories_1.kontrol_influenced}
              OR ${issue_categories_2.kontrol_influenced}
              OR ${issue_categories_3.kontrol_influenced} THEN ${issues}
        ELSE NULL
        END;;
  }

  measure: issues_per_reservation {
    type: number
    sql: ${total_issues} / NULLIF(${reservations_count},0) ;;
    value_format_name: decimal_2
  }

  measure: total_tech_related_issues_per_reservation {
    type: number
    sql: ${total_tech_related_issues} / NULLIF(${reservations_kustomer.total_reservations},0) ;;
    value_format_name: decimal_2
  }

  measure: total_kontrol_related_issues_per_reservation {
    type: number
    sql: ${total_kontrol_related_issues} / NULLIF(${reservations_kustomer.total_reservations},0) ;;
    value_format_name: decimal_2
  }




    }
