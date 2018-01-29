view: customer_cohorting {
  derived_table: {
    sql: SELECT
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
        ifnull(DATA.count_of_rentals,0) count_of_rentals,
        CASE
        WHEN         DATE_FORMAT(
              (
                SELECT
                  MIN(r.rental_date)
                FROM
                  rental r
                WHERE
                  r.customer_id = c.customer_id
              )
              , '%Y-%m-01') = month_list.activity_month THEN 1
        ELSE
        (
        /* corellated subquery that will count
        the distinct months in which they had rentals within 90 days,
        if this goes above 3 then show as "inactive for customer-month*/
        SELECT
          CASE
            WHEN count(distinct date_format(r2.rental_date,'%Y-%m-01')) > 0 THEN 1
            ELSE 0
          END IS_ACTIVE
        FROM
          rental r2
        WHERE
          1=1
          AND r2.rental_date <= month_list.activity_month  -- month_list.activity_month
          AND r2.rental_date >= DATE_ADD(month_list.activity_month,INTERVAL -3 MONTH) -- month_list.activity_month -- - 3 months interval
          AND r2.customer_id = c.customer_id
            )
            END
            is_active
      FROM
        customer c
        LEFT JOIN (
                      -- SELECT
                      -- DISTINCT DATE_FORMAT(rental_date, '%Y-%m-01') as activity_month
                      -- FROM rental
                  SELECT str_to_date('2005-05-01','%Y-%m-%d') activity_month UNION ALL
                  SELECT str_to_date('2005-06-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-07-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-08-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-09-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-10-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-11-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2005-12-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2006-01-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2006-02-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2006-03-01','%Y-%m-%d') UNION ALL
                  SELECT str_to_date('2006-04-01','%Y-%m-%d')

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
                  -- rental_id,
                  count(distinct rental_id) count_of_rentals
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
       ;;
    persist_for: "24 hours"
    indexes: ["customer_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customer_id {
    type: int
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: first_rental {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.first_rental ;;
  }

  dimension_group: activity_month {
    type: time
    timeframes: [date, year, month, week, day_of_week]
    sql: ${TABLE}.activity_month ;;
  }

  dimension: count_of_rentals {
    type: int
    sql: ${TABLE}.count_of_rentals ;;
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
  }

  measure: count_inactive {
    type: count_distinct
    sql: ${TABLE}.customer_id ;;

    filters: {
      field: is_active
      value: "yes"
    }

    drill_fields: [detail*]
  }

  measure: count_total_users {
    type: count_distinct
    sql: ${TABLE}.customer_id ;;
    drill_fields: [detail*]
  }

  measure: percent_of_cohort_active {
    type: number
    decimals: 2
    sql: (${count_inactive}*1.0)/nullif(${count_total_users},0) ;;
    value_format: "#0.0%"
    drill_fields: [detail*]
  }

  dimension: months_since_signup {
    type: int
    decimals: 2
    sql: round(datediff(${activity_month_date}, ${first_rental_date})/30.0,0) ;;
    value_format: "##0"
  }

  set: detail {
    fields: [customer_id, first_rental, activity_month, count_of_rentals]
  }
}
