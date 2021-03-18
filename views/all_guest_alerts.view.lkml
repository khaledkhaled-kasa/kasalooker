view: all_guest_alerts {
  label: "Guest Alerts"
  derived_table: {
    sql:
      SELECT messages.createdat AS createdat, messages.source AS eventtype, meta.reservationconfirmationcode AS reservation_id, "messages" as source, reservations.unit
      FROM messages JOIN reservations ON meta.reservationconfirmationcode = reservations.confirmationcode
      -- where messages.source IN ("kasa-automessages-production-smokeAlert","kasa-automessages-production-noiseBreach", "kasa-automessages-production-noiseBreach|kasa-airbnb-sync-production-sendAirbnbMessageWorker")

      UNION DISTINCT
      (SELECT textmessages.createdat AS createdat, messagetype AS eventtype, reservation AS reservation_id, "textmessages" as source, reservations.unit
      FROM textmessages JOIN reservations ON reservation = reservations._id
      -- where messagetype IN ("smokeAlert", "noiseBreach2", "noiseBreach")
      )

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
      sql: ${TABLE}.createdat ;;
    }

    dimension: reservation_id {
      hidden: no
      type: string
      sql: ${TABLE}.reservation_id ;;
    }

  dimension: source {
    hidden: no
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: unit_ID {
    hidden: yes
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: primary_key {
    hidden: yes
    description: "A primary key has been created to calculate distinct alert occurrences for different time periods / event types / reservation IDs"
    type: string
    sql: CONCAT(${TABLE}.createdat,${TABLE}.eventtype,${TABLE}.reservation_id) ;;
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
      sql: ${primary_key}  ;;
      filters: [eventtype_smoke: "yes"]
      drill_fields: [units.internaltitle]
    }

    measure: alerts_noise {
      label: "# of Noise Alerts"
      description: "This will pull all noise alerts from the messages and textmessages table"
      type: count_distinct
      sql: ${primary_key}  ;;
      filters: [eventtype_noise: "yes"]
    }

  measure: num_monitored_units {
    label: "Num of Monitored Units"
    description: "This will # of Unique Units by internaltitle"
    type: count_distinct
    sql: ${devices._id}  ;;
    filters: [devices.active: "yes", devices.devicetype: "Minut_v1"]
    drill_fields: [units.internaltitle]
  }


  }
