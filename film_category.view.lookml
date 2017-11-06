- view: film_category
  fields:

  - dimension: category_id
    type: yesno
    # hidden: true
    sql: ${TABLE}.category_id

  - dimension: film_id
    type: number
    # hidden: true
    sql: ${TABLE}.film_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - measure: count
    type: count
    drill_fields: [film.film_id, category.category_id, category.name]

