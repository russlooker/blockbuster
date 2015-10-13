- view: customer_cohorting
  derived_table:
    sql: |
      SELECT
        c.customer_id,
        DATE_FORMAT(
              (
                SELECT 
                  MIN(r.rental_date)
                FROM
                  rental r
                WHERE
                  r.customer_id = c.customer_id
              )
              , '%Y-%m-01') first_rental,
        month_list.activity_month,
        ifnull(DATA.count_of_rentals, 0) count_of_rentals
      FROM
        customer c 
        LEFT JOIN (
                SELECT 
                        DISTINCT DATE_FORMAT(rental_date, '%Y-%m-01') as activity_month
                      FROM rental  -- could be any table that has all the months we want, 
        ) as month_list on (month_list.activity_month >=   DATE_FORMAT(
              (
                SELECT 
                  MIN(r.rental_date)
                FROM
                  rental r
                WHERE
                  r.customer_id = c.customer_id
              )
              , '%Y-%m-01'))
        LEFT JOIN (
                SELECT 
                  customer_id,
                  DATE_FORMAT(rental_date, '%Y-%m-01') order_month,
                  count(*) count_of_rentals
                FROM
                  rental
                GROUP BY
                  1,2
          ) DATA ON (
                  DATA.customer_id = c.customer_id
                AND DATA.order_month = month_list.activity_month
            )
      ORDER BY
        1,3
    persist_for: 24 hours
    indexes: [customer_id]

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: customer_id
    type: int
    sql: ${TABLE}.customer_id

  - dimension: first_rental
    type: string
    sql: ${TABLE}.first_rental

  - dimension: activity_month
    type: string
    sql: ${TABLE}.activity_month

  - dimension: count_of_rentals
    type: int
    sql: ${TABLE}.count_of_rentals

  sets:
    detail:
      - customer_id
      - first_rental
      - activity_month
      - count_of_rentals
