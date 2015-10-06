- view: city
  fields:

  - dimension: city_id
    primary_key: true
    type: int
    sql: ${TABLE}.city_id

  - dimension: city
    sql: ${TABLE}.city

  - dimension: country_id
    type: int
    # hidden: true
    sql: ${TABLE}.country_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - measure: count
    type: count
    drill_fields: [city_id, country.country_id, address.count]

