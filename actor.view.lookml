- view: actor
  fields:

  - dimension: actor_id
    primary_key: true
    type: int
    sql: ${TABLE}.actor_id

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: last_name
    sql: ${TABLE}.last_name

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - measure: count
    type: count
    drill_fields: [actor_id, first_name, last_name, actor_info.count, film_actor.count]

