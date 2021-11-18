view: refund_notes {
  derived_table: {
    sql: WITH revised_notes AS (SELECT
      note.id, note.created_at, note.body, user.name,
      regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(LTRIM(LTRIM(LTRIM(LTRIM(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(note.body, r"\\",""), r"/",""),r"\[\[","["),r"\]\]","]"),r"\[","]["),r"\] \]","]"),"##"),"**"),"]")," ]"),r"\]","]["),r"\[\[","["),r"\[]",""),r"\[ ]",""),r"\[  ]","") revised_body,
      from kustomer.note note
      JOIN kustomer.user user ON note.created_by = user.id
      WHERE lower(body) LIKE "%[%refund%]%[$%]%if giftly, or kredit%"
      OR lower(body) LIKE "%[%giftly%]%[$%]%if giftly, or kredit%"
      OR lower(body) LIKE "%[%charge%]%[$%]%if giftly, or kredit%"
      OR lower(body) LIKE "%[%kasa kredit%]%[$%]%if giftly, or kredit%")

      SELECT id, created_at, body, name, revised_body,
      regexp_extract(revised_body, r'\[(.*?)\]') first_bracket,
      SUBSTR(revised_body, STRPOS(revised_body,']')+1) revised_after_first_bracket,
      regexp_extract(SUBSTR(revised_body, STRPOS(revised_body,']')+1), r'\[(.*?)\]') second_bracket,
      SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1) revised_after_second_bracket,
      regexp_extract(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), r'\[(.*?)\]') third_bracket,
      SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1) revised_after_third_bracket,
      regexp_extract(SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1), r'\[(.*?)\]') fourth_bracket,
      SUBSTR(SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1),']')+1) revised_after_fourth_bracket,
      regexp_extract(SUBSTR(SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1), STRPOS(SUBSTR(SUBSTR(revised_body, STRPOS(revised_body,']')+1), STRPOS(SUBSTR(revised_body, STRPOS(revised_body,']')+1),']')+1),']')+1),']')+1), r'\[(.*?)\]') fifth_bracket
      FROM revised_notes
       ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }


  dimension_group: created_at {
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

  dimension: body {
    label: "Original Note"
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: name {
    label: "Note Creator"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: revised_body {
    hidden: yes
    type: string
    sql: ${TABLE}.revised_body ;;
  }

  dimension: first_bracket {
    label: "Type of Refund"
    description: "This field is pulled from the body of the note based on the standard shortcut template. Notes not adhering to the standard template may not return accurate results."
    type: string
    sql: ${TABLE}.first_bracket ;;
  }

  dimension: revised_after_first_bracket {
    hidden: yes
    type: string
    sql: ${TABLE}.revised_after_first_bracket ;;
  }

  dimension: second_bracket {
    label: "Refund Amount Requested"
    description: "This field is pulled from the body of the note based on the standard shortcut template. Notes not adhering to the standard template may not return accurate results."
    type: string
    sql: ${TABLE}.second_bracket ;;
  }

  dimension: revised_after_second_bracket {
    hidden: yes
    type: string
    sql: ${TABLE}.revised_after_second_bracket ;;
  }

  dimension: third_bracket {
    label: "Reservation Code"
    description: "This field is pulled from the body of the note based on the standard shortcut template. Notes not adhering to the standard template may not return accurate results."
    type: string
    sql: TRIM(${TABLE}.third_bracket) ;;
  }

  dimension: revised_after_third_bracket {
    hidden: yes
    type: string
    sql: ${TABLE}.revised_after_third_bracket ;;
  }

  dimension: fourth_bracket {
    label: "Refund Reason"
    description: "This field is pulled from the body of the note based on the standard shortcut template. Notes not adhering to the standard template may not return accurate results."
    type: string
    sql: ${TABLE}.fourth_bracket ;;
  }

  dimension: revised_after_fourth_bracket {
    hidden: yes
    type: string
    sql: ${TABLE}.revised_after_fourth_bracket ;;
  }

  dimension: fifth_bracket {
    label: "Approved By"
    description: "This field is pulled from the body of the note based on the standard shortcut template. Notes not adhering to the standard template may not return accurate results."
    type: string
    sql: ${TABLE}.fifth_bracket ;;
  }

}
