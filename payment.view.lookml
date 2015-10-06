- view: payment
  fields:

  - dimension: payment_id
    primary_key: true
    type: int
    sql: ${TABLE}.payment_id

  - dimension: amount
    type: number
    sql: ${TABLE}.amount

  - dimension: customer_id
    type: int
    # hidden: true
    sql: ${TABLE}.customer_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension_group: payment
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.payment_date

  - dimension: rental_id
    type: int
    # hidden: true
    sql: ${TABLE}.rental_id

  - dimension: staff_id
    type: yesno
    # hidden: true
    sql: ${TABLE}.staff_id

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - payment_id
    - customer.customer_id
    - customer.first_name
    - customer.last_name
    - staff.staff_id
    - staff.first_name
    - staff.last_name
    - staff.username
    - rental.rental_id

