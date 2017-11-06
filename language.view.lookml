- view: language
  fields:

  - dimension: language_id
    primary_key: true
    type: yesno
    sql: ${TABLE}.language_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: name
    sql: ${TABLE}.name

  - measure: count
    type: count
    drill_fields: [language_id, name, film.count]

