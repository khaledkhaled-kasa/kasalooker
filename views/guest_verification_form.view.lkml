view: guest_verification_form {
  derived_table: {
    sql: WITH reservations AS (select reservations.*, guest_type,
      CASE
      WHEN reservations.timezone = 'America/Chicago' THEN 'America/Chicago'
      WHEN reservations.timezone = 'America/Los_Angeles' THEN 'America/Los_Angeles'
      WHEN reservations.timezone = 'America/San_Jose' THEN 'America/Los_Angeles'
      WHEN reservations.timezone = 'America/New_York' THEN 'America/New_York'
      WHEN reservations.timezone = 'America/Phoenix' THEN 'America/Phoenix'
      WHEN reservations.timezone = 'America/Denver' THEN 'America/Denver'
      ELSE 'US/Central' ------- This needs to be adjusted?
      END revised_timezone
      from reservations
      JOIN (
      select guest,
      case when count(*) > 1 then "Repeat"
      else "First Time"
      END guest_type
      from reservations
      group by 1)a
      on reservations.guest = a.guest)

      SELECT reservations.*, reservations.status as res_status, units.*, guests.*,
      reservations_historicals.timestamp,
      reservations.revised_timezone as res_revised_timezone,
      timestamp(datetime(guests.verification.verifiedat__ts,reservations.revised_timezone)) as revised_verification_success_timezone,
      timestamp(datetime(reservations_historicals.timestamp,reservations.revised_timezone)) as revised_verification_timezone
      FROM reservations
      JOIN units  ON units._id = reservations.unit
      JOIN guests ON guests._id = reservations.guest
      LEFT JOIN reservations_historicals ON reservations_historicals.document = reservations._id
      AND diff.termsAccepted = true
       ;;
  }

  dimension: chargelogs {
    type: string
    hidden: yes
    sql: ${TABLE}.chargelogs ;;
  }

  dimension: bringingpets {
    type: string
    sql: ${TABLE}.bringingpets ;;
  }

  dimension: licenseplate {
    type: string
    sql: ${TABLE}.licenseplate ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.nickname ;;
  }

  dimension: parkingspaceneeded {
    type: string
    sql: ${TABLE}.parkingspaceneeded ;;
  }

  dimension: days_to_submit {
    label: "Number of Days*"
    description: "Number of days ahead of check-in to submit the GV form"
    type:  number
    sql:  date_diff(CAST(${checkindate} as DATE), ${correct_date_date}, DAY) ;;
  }

  measure: avg_number_of_days {
    label: "Average Number of Days before Check-in"
    description: "Average number of days ahead of check-in to submit the GV form"
    value_format: "0.0"
    type:  average
    sql:  ${days_to_submit} ;;
  }

  # This will calculate the hours by taking into consideration a fixed check-in at 15:00
  dimension: date_diff {
    label: "Number of Hours before Check-in*"
    type: number
    description: "Number of hours ahead of check-in to submit the GV form"
    sql: TIMESTAMP_DIFF(TIMESTAMP(${checkindatetime}), TIMESTAMP(${correct_date_time}), HOUR) + 15;;
  }

  dimension: hour_bins {
    label: "Hours before Check-in (Bins)*"
    type: string
    description: "Distribution of hours ahead of check-in to submit the GV form (6 hours, 12 hours, 24 hours, 48 hours) before checkin"
    sql: CASE
    WHEN ${date_diff} < 6 THEN "b1: < 6 hours"
    WHEN ${date_diff} >= 6 AND ${date_diff} < 12 THEN "b2: 6 - 12 hours"
    WHEN ${date_diff} >= 12 AND ${date_diff} < 24 THEN "b3: 12 - 24 hours"
    WHEN ${date_diff} >= 24 AND ${date_diff} < 48 THEN "b4: 24 - 48 hours"
    WHEN ${date_diff} >= 48 THEN "b5: >= 48 hours"
    ELSE "b6: Not Submitted"
    END;;
  }


  measure: avg_number_of_hours {
    label: "Average Number of Hours"
    description: "Average number of hours ahead of check-in to submit the GV form"
    value_format: "0.0"
    type:  average
    sql:  ${date_diff} ;;
  }

  measure: number_of_reservations {
    label: "Number of Reservations"
    type:  count_distinct
    sql: CONCAT(${guest}, '-', ${confirmationcode});;
  }

  dimension: termsaccepted {
    type: string
    sql: ${TABLE}.termsaccepted ;;
  }

  dimension: suspicious {
    type: string
    sql: ${TABLE}.suspicious ;;
  }


  dimension: checkindate {
    type: date
    hidden: yes
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
  }

  dimension_group: reservation_checkin {
    type: time
    label: "Check-in"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
  }

  dimension: checkindatetime {
    type: date_time
    hidden: yes
    sql: CAST(${TABLE}.checkindatelocal as TIMESTAMP);;
  }

  dimension: checkoutdate {
    type: date
    hidden: yes
    sql: CAST(${TABLE}.checkoutdatelocal as TIMESTAMP);;
  }

  dimension_group: reservation_checkout {
    type: time
    label: "Check-out"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.checkoutdatelocal as TIMESTAMP);;
  }

  # This will convert San Jose and Null values as per above derived table
  dimension: timezone {
    label: "Timezone"
    description: "Adjusted timezone to account for null and invalid values"
    type: string
    hidden: no
    sql: ${TABLE}.res_revised_timezone ;;
  }

  dimension: guestid {
    label: "Guest ID"
    hidden: yes
    type: string
    sql: ${TABLE}.guestid ;;
  }

  dimension: callboxcode {
    type: string
    sql: ${TABLE}.callboxcode ;;
  }

  dimension: listingaddress {
    type: string
    sql: ${TABLE}.listingaddress ;;
  }

  dimension_group: cancellationdate {
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
    sql: ${TABLE}.cancellationdate ;;
  }

  dimension: planneddeparture {
    type: string
    sql: ${TABLE}.planneddeparture ;;
  }

  dimension: keycafeaccess {
    type: string
    sql: ${TABLE}.keycafeaccess ;;
  }

  dimension: _sdc_table_version {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension_group: createdat {
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
    sql: ${TABLE}.createdat ;;
  }

  dimension: smartlockcodeisset {
    type: string
    sql: ${TABLE}.smartlockcodeisset ;;
  }

  dimension: earlycheckin {
    type: string
    hidden: yes
    sql: ${TABLE}.earlycheckin ;;
  }

  dimension_group: updatedat {
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
    sql: ${TABLE}.updatedat ;;
  }

  dimension: externalrefs {
    type: string
    hidden: yes
    sql: ${TABLE}.externalrefs ;;
  }

  dimension: signeddoc {
    type: string
    sql: ${TABLE}.signeddoc ;;
  }

  dimension: status {
    type: string
    label: "Reservation_Status"
    sql: ${TABLE}.res_status ;;
  }

  dimension: listingname {
    type: string
    sql: ${TABLE}.listingname ;;
  }


  dimension: confirmationcode {
    type: string
    sql: ${TABLE}.confirmationcode ;;
  }

  dimension: additionalguests {
    type: string
    sql: ${TABLE}.additionalguests ;;
  }

  dimension_group: _sdc_received_at {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: numberofpets {
    type: number
    sql: ${TABLE}.numberofpets ;;
  }

  dimension: pettype {
    type: string
    sql: ${TABLE}.pettype ;;
  }

  dimension: _id {
    type: string
    hidden: yes
    sql: ${TABLE}._id ;;
  }

  dimension_group: bookingdate {
    label: "Booking"
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
    sql: ${TABLE}.bookingdate ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: guest {
    type: string
    hidden: no
    sql: ${TABLE}.guest ;;
  }

  dimension: guestscount {
    type: number
    sql: ${TABLE}.guestscount ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  dimension_group: _sdc_batched_at {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension: cards {
    type: string
    sql: ${TABLE}.cards ;;
  }

  dimension: petfeescard {
    type: string
    sql: ${TABLE}.petfeescard ;;
  }

  dimension: pets {
    type: string
    sql: ${TABLE}.pets ;;
  }

  dimension: plannedarrival {
    type: string
    hidden: yes
    sql: ${TABLE}.plannedarrival ;;
  }

  dimension: platform {
    type: string
    hidden: yes
    sql: ${TABLE}.platform ;;
  }

  dimension_group: _sdc_extracted_at {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension: petdescription {
    type: string
    sql: ${TABLE}.petdescription ;;
  }

  dimension: apis {
    type: string
    hidden: yes
    sql: ${TABLE}.apis ;;
  }

  dimension: maybebringingpetsdespiteban {
    type: string
    hidden: yes
    sql: ${TABLE}.maybebringingpetsdespiteban ;;
  }

  dimension: specialrequest {
    type: string
    sql: ${TABLE}.specialrequest ;;
  }

  dimension: __v {
    type: number
    hidden: yes
    sql: ${TABLE}.__v ;;
  }

  dimension: smartlockcode {
    type: string
    sql: ${TABLE}.smartlockcode ;;
  }

  dimension: isverified {
    type: yesno
    sql: ${TABLE}.verification.isverified ;;
  }

  dimension_group: timestamp {
    label: "GV Submission"
    description: "This shows the timestamp for when the GV was submitted despite if it was approved or not"
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
    sql: ${TABLE}.revised_verification_timezone;;
    convert_tz: no
  }

  dimension_group: correct_date {
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
    label: "GV Submission*"
    description: "This will show the GV submission date for guests with multiple bookings and the approved guest guest verification date for guests that had a single booking"
    sql:
    CASE
    WHEN ${TABLE}.guest_type = "First Time" and extract(year from ${TABLE}.revised_verification_success_timezone) != 1969
    THEN ${TABLE}.revised_verification_success_timezone
    ELSE ${TABLE}.revised_verification_timezone
    END ;;
  }


  dimension_group: verification {
    type: time
    sql: ${TABLE}.revised_verification_success_timezone ;;
  }

  dimension: reservationrisk {
    type: string
    hidden: yes
    sql: ${TABLE}.reservationrisk ;;
  }

  dimension_group: _sdc_deleted_at {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_deleted_at ;;
  }

  dimension: infinitystones {
    type: string
    hidden: yes
    sql: ${TABLE}.infinitystones ;;
  }

  dimension: latch {
    type: string
    hidden: yes
    sql: ${TABLE}.latch ;;
  }

  dimension: sourcedetail {
    type: string
    sql: ${TABLE}.sourcedetail ;;
  }

  dimension: bookingflags {
    type: string
    hidden: yes
    sql: ${TABLE}.bookingflags ;;
  }

  dimension: property {
    type: string
    hidden: yes
    sql: ${TABLE}.property ;;
  }

  dimension: discounts {
    type: string
    sql: ${TABLE}.discounts ;;
  }

  dimension: securitydeposit {
    type: string
    sql: ${TABLE}.securitydeposit ;;
  }

  dimension: latecheckout {
    type: string
    sql: ${TABLE}.latecheckout ;;
  }

  dimension: smartlocktype {
    type: string
    sql: ${TABLE}.smartlocktype ;;
  }

  dimension: guesty {
    type: string
    hidden: yes
    sql: ${TABLE}.guesty ;;
  }

  dimension: guest_type {
    type: string
    sql: ${TABLE}.guest_type ;;
  }

  dimension: floor {
    type: string
    hidden: yes
    sql: ${TABLE}.floor ;;
  }

  dimension: floor__it {
    type: number
    hidden: yes
    sql: ${TABLE}.floor__it ;;
  }

  dimension: propertyexternaltitle {
    type: string
    sql: ${TABLE}.propertyexternaltitle ;;
  }

  dimension: defaultcheckin {
    type: string
    hidden: yes
    sql: ${TABLE}.defaultcheckin ;;
  }

  dimension: hassmartlock {
    type: yesno
    sql: ${TABLE}.hassmartlock ;;
  }

  dimension: bathrooms {
    type: number
    sql: ${TABLE}.bathrooms ;;
  }

  dimension: bathrooms__fl {
    type: number
    sql: ${TABLE}.bathrooms__fl ;;
  }

  dimension: nickname_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.nickname_1 ;;
  }

  dimension: parkingtype {
    type: string
    sql: ${TABLE}.parkingtype ;;
  }

  dimension: timezone_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.timezone_1 ;;
  }

  dimension: wifi {
    type: string
    sql: ${TABLE}.wifi ;;
  }

  dimension: defaultcheckouttime {
    type: string
    sql: ${TABLE}.defaultcheckouttime ;;
  }

  dimension: maps {
    type: string
    hidden: yes
    sql: ${TABLE}.maps ;;
  }

  dimension: tags {
    type: string
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: availability {
    type: string
    hidden: yes
    sql: ${TABLE}.availability ;;
  }

  dimension: bedrooms {
    type: number
    sql: ${TABLE}.bedrooms ;;
  }

  dimension: petsallowed {
    type: string
    sql: ${TABLE}.petsallowed ;;
  }

  dimension: door {
    type: string
    sql: ${TABLE}.door ;;
  }

  dimension: _sdc_table_version_1 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_table_version_1 ;;
  }

  dimension_group: createdat_1 {
    type: time
    hidden: yes
    sql: ${TABLE}.createdat_1 ;;
  }

  dimension: propertyinternaltitle {
    type: string
    sql: ${TABLE}.propertyinternaltitle ;;
  }

  dimension_group: updatedat_1 {
    type: time
    hidden: yes
    sql: ${TABLE}.updatedat_1 ;;
  }

  dimension: housekeepers {
    type: string
    hidden: yes
    sql: ${TABLE}.housekeepers ;;
  }

  dimension: externalrefs_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.externalrefs_1 ;;
  }

  dimension: address {
    type: string
    hidden: yes
    sql: ${TABLE}.address ;;
  }


  dimension: callbox {
    type: string
    sql: ${TABLE}.callbox ;;
  }

  dimension: keycafe {
    type: string
    sql: ${TABLE}.keycafe ;;
  }

  dimension: backupsmartlockcodes {
    type: string
    sql: ${TABLE}.backupsmartlockcodes ;;
  }

  dimension: facilities {
    type: string
    hidden: yes
    sql: ${TABLE}.facilities ;;
  }

  dimension_group: _sdc_received_at_1 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_received_at_1 ;;
  }

  dimension: amenities {
    type: string
    sql: ${TABLE}.amenities ;;
  }

  dimension: _sdc_sequence_1 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_sequence_1 ;;
  }

  dimension: baseprice {
    type: number
    hidden: yes
    sql: ${TABLE}.baseprice ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: askadditionalguests {
    type: string
    hidden: yes
    sql: ${TABLE}.askadditionalguests ;;
  }

  dimension: propertyheroimage {
    type: string
    hidden: yes
    sql: ${TABLE}.propertyheroimage ;;
  }

  dimension: _id_1 {
    type: string
    hidden: yes
    sql: ${TABLE}._id_1 ;;
  }

  dimension: building {
    type: string
    hidden: yes
    sql: ${TABLE}.building ;;
  }

  dimension: buildingexternaltitle {
    type: string
    sql: ${TABLE}.buildingexternaltitle ;;
  }

  dimension: photos {
    type: string
    hidden: yes
    sql: ${TABLE}.photos ;;
  }

  dimension: checkindetails {
    type: string
    hidden: yes
    sql: ${TABLE}.checkindetails ;;
  }

  dimension: nexiaid {
    type: string
    hidden: no
    sql: ${TABLE}.nexiaid ;;
  }

  dimension: lock_id {
    type: string
    hidden: no
    sql: ${TABLE}.lock_id ;;
  }

  dimension: defaultcheckout {
    type: string
    hidden: yes
    sql: ${TABLE}.defaultcheckout ;;
  }

  dimension: accomodates {
    type: number
    hidden: yes
    sql: ${TABLE}.accomodates ;;
  }

  dimension_group: _sdc_batched_at_1 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_batched_at_1 ;;
  }

  dimension: complex {
    type: string
    sql: ${TABLE}.complex ;;
  }

  dimension: defaultcheckintime {
    type: string
    hidden: yes
    sql: ${TABLE}.defaultcheckintime ;;
  }

  dimension: hashighriskneighbor {
    type: string
    hidden: yes
    sql: ${TABLE}.hashighriskneighbor ;;
  }

  dimension_group: _sdc_extracted_at_1 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_extracted_at_1 ;;
  }

  dimension: buildinginternaltitle {
    type: string
    hidden: yes
    sql: ${TABLE}.buildinginternaltitle ;;
  }

  dimension: internaltitle {
    type: string
    hidden: no
    sql: ${TABLE}.internaltitle ;;
  }

  dimension: cleaningstatus {
    type: string
    sql: ${TABLE}.cleaningstatus ;;
  }

  dimension: islisted {
    type: string
    sql: ${TABLE}.islisted ;;
  }

  dimension: rooms {
    type: string
    hidden: yes
    sql: ${TABLE}.rooms ;;
  }

  dimension: __v_1 {
    type: number
    hidden: yes
    sql: ${TABLE}.__v_1 ;;
  }

  dimension: trustandsafety {
    type: string
    hidden: yes
    sql: ${TABLE}.trustandsafety ;;
  }

  dimension: parkingfee {
    type: number
    sql: ${TABLE}.parkingfee ;;
  }

  dimension: roomtype {
    type: string
    sql: ${TABLE}.roomtype ;;
  }

  dimension: externaltitle {
    type: string
    sql: ${TABLE}.externaltitle ;;
  }

  dimension: internalpropertymanager {
    type: string
    sql: ${TABLE}.internalpropertymanager ;;
  }

  dimension: accessitems {
    type: string
    sql: ${TABLE}.accessitems ;;
  }

  dimension: propertymanager {
    type: string
    sql: ${TABLE}.propertymanager ;;
  }

  dimension_group: _sdc_deleted_at_1 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_deleted_at_1 ;;
  }

  dimension: latch_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.latch_1 ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: verification {
    hidden: yes
    type: string
    sql: ${TABLE}.verification ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: _sdc_table_version_2 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_table_version_2 ;;
  }

  dimension_group: createdat_2 {
    type: time
    hidden: yes
    sql: ${TABLE}.createdat_2 ;;
  }

  dimension_group: dateofbirth {
    type: time
    hidden: yes
    sql: ${TABLE}.dateofbirth ;;
  }

  dimension_group: updatedat_2 {
    type: time
    hidden: yes
    sql: ${TABLE}.updatedat_2 ;;
  }

  dimension: externalrefs_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.externalrefs_2 ;;
  }

  dimension: address_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.address_1 ;;
  }

  dimension: additional_info {
    type: string
    hidden: yes
    sql: ${TABLE}.additional_info ;;
  }

  dimension: emailmarketingaccepted {
    type: string
    sql: ${TABLE}.emailmarketingaccepted ;;
  }

  dimension_group: _sdc_received_at_2 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_received_at_2 ;;
  }

  dimension: _sdc_sequence_2 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_sequence_2 ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: _id_2 {
    type: string
    hidden: yes
    sql: ${TABLE}._id_2 ;;
  }

  dimension: notes_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.notes_1 ;;
  }

  dimension: additionalinfo {
    type: string
    sql: ${TABLE}.additionalinfo ;;
  }

  dimension_group: _sdc_batched_at_2 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_batched_at_2 ;;
  }

  dimension_group: _sdc_extracted_at_2 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_extracted_at_2 ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: __v_2 {
    type: number
    hidden: yes
    sql: ${TABLE}.__v_2 ;;
  }

  dimension: phonelookup {
    type: string
    sql: ${TABLE}.phonelookup ;;
  }

  dimension_group: _sdc_deleted_at_2 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_deleted_at_2 ;;
  }

  dimension: middlename {
    type: string
    sql: ${TABLE}.middlename ;;
  }


  dimension: diff {
    type: string
    sql: ${TABLE}.diff ;;
  }

  dimension: document {
    type: string
    sql: ${TABLE}.document ;;
  }

  dimension: _sdc_table_version_3 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_table_version_3 ;;
  }

  dimension_group: _sdc_received_at_3 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_received_at_3 ;;
  }

  dimension: _sdc_sequence_3 {
    type: number
    hidden: yes
    sql: ${TABLE}._sdc_sequence_3 ;;
  }

  dimension: _id_3 {
    type: string
    hidden: yes
    sql: ${TABLE}._id_3 ;;
  }

  dimension_group: _sdc_batched_at_3 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_batched_at_3 ;;
  }

  dimension_group: _sdc_extracted_at_3 {
    type: time
    hidden: yes
    sql: ${TABLE}._sdc_extracted_at_3 ;;
  }

  dimension: __v_3 {
    type: number
    hidden: yes
    sql: ${TABLE}.__v_3 ;;
  }

  set: detail {
    fields: [
      chargelogs,
      bringingpets,
      licenseplate,
      nickname,
      parkingspaceneeded,
      termsaccepted,
      suspicious,
      checkindate,
      timezone,
      guestid,
      callboxcode,
      listingaddress,
      cancellationdate_time,
      planneddeparture,
      keycafeaccess,
      _sdc_table_version,
      createdat_time,
      smartlockcodeisset,
      earlycheckin,
      updatedat_time,
      externalrefs,
      checkoutdate,
      signeddoc,
      status,
      listingname,
      confirmationcode,
      additionalguests,
      _sdc_received_at_time,
      _sdc_sequence,
      source,
      numberofpets,
      pettype,
      _id,
      bookingdate_time,
      unit,
      guest,
      guestscount,
      notes,
      _sdc_batched_at_time,
      cards,
      petfeescard,
      pets,
      plannedarrival,
      platform,
      _sdc_extracted_at_time,
      petdescription,
      apis,
      maybebringingpetsdespiteban,
      specialrequest,
      __v,
      smartlockcode,
      isverified,
      reservationrisk,
      _sdc_deleted_at_time,
      infinitystones,
      latch,
      sourcedetail,
      bookingflags,
      property,
      discounts,
      securitydeposit,
      latecheckout,
      smartlocktype,
      guesty,
      guest_type,
      floor,
      floor__it,
      propertyexternaltitle,
      defaultcheckin,
      hassmartlock,
      bathrooms,
      bathrooms__fl,
      nickname_1,
      parkingtype,
      timezone_1,
      wifi,
      defaultcheckouttime,
      maps,
      tags,
      availability,
      bedrooms,
      petsallowed,
      door,
      _sdc_table_version_1,
      createdat_1_time,
      propertyinternaltitle,
      updatedat_1_time,
      housekeepers,
      externalrefs_1,
      address,
      callbox,
      keycafe,
      backupsmartlockcodes,
      facilities,
      _sdc_received_at_1_time,
      amenities,
      _sdc_sequence_1,
      baseprice,
      title,
      askadditionalguests,
      propertyheroimage,
      _id_1,
      building,
      buildingexternaltitle,
      photos,
      checkindetails,
      nexiaid,
      lock_id,
      defaultcheckout,
      accomodates,
      _sdc_batched_at_1_time,
      complex,
      defaultcheckintime,
      hashighriskneighbor,
      _sdc_extracted_at_1_time,
      buildinginternaltitle,
      internaltitle,
      cleaningstatus,
      islisted,
      rooms,
      __v_1,
      trustandsafety,
      parkingfee,
      roomtype,
      externaltitle,
      internalpropertymanager,
      accessitems,
      propertymanager,
      _sdc_deleted_at_1_time,
      latch_1,
      lastname,
      verification,
      country,
      email,
      _sdc_table_version_2,
      createdat_2_time,
      dateofbirth_time,
      updatedat_2_time,
      externalrefs_2,
      address_1,
      additional_info,
      emailmarketingaccepted,
      _sdc_received_at_2_time,
      _sdc_sequence_2,
      phone,
      _id_2,
      notes_1,
      additionalinfo,
      _sdc_batched_at_2_time,
      _sdc_extracted_at_2_time,
      firstname,
      __v_2,
      phonelookup,
      _sdc_deleted_at_2_time,
      middlename,
      timestamp_time,
      diff,
      document,
      _sdc_table_version_3,
      _sdc_received_at_3_time,
      _sdc_sequence_3,
      _id_3,
      _sdc_batched_at_3_time,
      _sdc_extracted_at_3_time,
      __v_3
    ]
  }
}
