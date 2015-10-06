- view: rental
  fields:

  - dimension: rental_id
    primary_key: true
    type: int
    sql: ${TABLE}.rental_id

  - dimension: customer_id
    type: int
    # hidden: true
    sql: ${TABLE}.customer_id

  - dimension: inventory_id
    type: int
    # hidden: true
    sql: ${TABLE}.inventory_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension_group: rental
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.rental_date

  - dimension_group: return
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.return_date

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
    - rental_id
    - inventory.inventory_id
    - customer.customer_id
    - customer.first_name
    - customer.last_name
    - staff.staff_id
    - staff.first_name
    - staff.last_name
    - staff.username
    - payment.count

