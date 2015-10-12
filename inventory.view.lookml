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
    
  - dimension_group: entered_circulation
    type: time 
    timeframes: [time, date, week, month]
    sql: |
      (
        SELECT MIN(${rental.rental_date})
        FROM
         rental
        WHERE
        ${rental.inventory_id} = ${inventory_id}
        )
        
  - dimension: time_in_inventory
    type: number
    sql: DATEDIFF(${entered_circulation_date}, curdate())*1.0/365
    
  - dimension: total_times_rented
    type: int
    sql: |
        (
        SELECT COUNT(*)
        FROM
         rental
        WHERE
        ${rental.inventory_id} = ${inventory_id}
        )

  - measure: possible_revenue_by_rental_rate
    type: sum
    decimals: 2
    sql: ${total_times_rented} * ${film.rental_rate}
    value_format: '$#,##0.00'
    
  - measure: count_older_than_10
    type: count
    filters:
      time_in_inventory: '>10'
  
  - measure: percent_older_than_10_years
    type: number
    decimals: 2
    sql: ${count_older_than_10}*1.0/${count}
    value_format: '#0.00%'

  - dimension: number_of_rentals_tier
    type: tier
    sql: ${total_times_rented}
    tiers: [0, 3, 5]
    style: integer

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: store_id
    type: int
    # hidden: true
    sql: ${TABLE}.store_id

  - measure: count
    type: count
    drill_fields: [inventory_id, film.film_id, store.store_id, rental.count]

