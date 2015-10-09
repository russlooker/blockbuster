- view: category
  fields:

  - dimension: category_id
    primary_key: true
    type: number
    sql: ${TABLE}.category_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: name
    sql: ${TABLE}.name

  - measure: count
    type: count
    drill_fields: [category_id, name, film_category.count]

