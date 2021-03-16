view: all_guest_alerts {
  derived_table: {
    sql:
      SELECT createdat AS createdat, source AS eventtype, meta.reservationconfirmationcode AS reservation_id
      FROM messages
      -- where source IN ("kasa-automessages-production-smokeAlert","kasa-automessages-production-noiseBreach", "kasa-automessages-production-noiseBreach|kasa-airbnb-sync-production-sendAirbnbMessageWorker")

      UNION DISTINCT
      (SELECT createdat AS createdat, messagetype AS eventtype, reservation AS reservation_id
      FROM textmessages)
      -- where messagetype IN ("smokeAlert", "noiseBreach2", "noiseBreach"))

      ;;

    #datagroup_trigger: reviews_default_datagroup
      persist_for: "12 hours"
    }

    dimension_group: createdat {
      label: ""
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
      # convert_tz: no
      datatype: date
      sql: ${TABLE}.createdat ;;
    }

    dimension: reservation_id {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.reservation_id ;;
    }

    dimension: eventtype {
      label: "Event Type"
      type: string
      sql: ${TABLE}.eventtype ;;
    }

    dimension: eventtype_smoke{
      # hidden: yes
      description: "This will filter all eventtypes corresponding to smoke alerts from the messages and textmessages table"
      type: yesno
      sql: ${TABLE}.eventtype IN ("kasa-automessages-production-smokeAlert", "smokeAlert");;
    }

    dimension: eventtype_noise{
      # hidden:yes
      description: "This will filter all eventtypes corresponding to noise alerts from the messages and textmessages table"
      type: yesno
      sql: ${TABLE}.eventtype LIKE ("%noise%");;
    }

    measure: alerts_smoke {
      label: "# of Smoke Alerts"
      description: "This will pull all smoke alerts from the messages and textmessages table"
      type: count_distinct
      sql: ${reservation_id} ;;
      filters: [eventtype_smoke: "yes"]
    }

    measure: alerts_noise {
      label: "# of Noise Alerts"
      description: "This will pull all noise alerts from the messages and textmessages table"
      type: count_distinct
      sql: ${reservation_id} ;;
      filters: [eventtype_noise: "yes"]
    }

    measure: alerts_smoke_noise {
     label: "# of Smoke / Noise Alerts"
     description: "This will pull all noise alerts from the messages and textmessages table"
      type: count_distinct
      sql: ${reservation_id} ;;
      filters: [eventtype_noise: "yes", eventtype_smoke: "yes"]
    }

  }
