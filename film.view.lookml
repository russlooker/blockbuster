- view: film
  fields:

  - dimension: film_id
    primary_key: true
    type: number
    sql: ${TABLE}.film_id

  - dimension: description
    sql: ${TABLE}.description

  - dimension: language_id
    type: yesno
    # hidden: true
    sql: ${TABLE}.language_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: length
    type: number
    sql: ${TABLE}.length

  - dimension: original_language_id
    type: yesno
    sql: ${TABLE}.original_language_id

  - dimension: rating
    sql: ${TABLE}.rating

  - dimension_group: release_year
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.release_year

  - dimension: rental_duration
    type: yesno
    sql: ${TABLE}.rental_duration

  - dimension: rental_rate
    type: number
    sql: ${TABLE}.rental_rate
    value_format_name: usd

  - dimension: replacement_cost
    type: number
    sql: ${TABLE}.replacement_cost
    value_format_name: usd

  - dimension: special_features
    sql: ${TABLE}.special_features

  - dimension: title
    sql: ${TABLE}.title

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - film_id
    - language.language_id
    - language.name
    - film_actor.count
    - film_category.count
    - film_text.count
    - inventory.count

