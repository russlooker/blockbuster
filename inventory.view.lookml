- view: inventory
  fields:

  - dimension: inventory_id
    primary_key: true
    type: int
    sql: ${TABLE}.inventory_id

  - dimension: film_id
    type: int
    # hidden: true
    sql: ${TABLE}.film_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: store_id
    type: yesno
    # hidden: true
    sql: ${TABLE}.store_id

  - measure: count
    type: count
    drill_fields: [inventory_id, film.film_id, store.store_id, rental.count]

