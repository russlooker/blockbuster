- view: film_text
  fields:

  - dimension: description
    sql: ${TABLE}.description

  - dimension: film_id
    type: int
    # hidden: true
    sql: ${TABLE}.film_id

  - dimension: title
    sql: ${TABLE}.title

  - measure: count
    type: count
    drill_fields: [film.film_id]

