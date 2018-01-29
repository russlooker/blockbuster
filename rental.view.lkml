view: rental {
  sql_table_name: rental ;;

  dimension: rental_id {
    primary_key: yes
    type: int
    sql: ${TABLE}.rental_id ;;
  }

  dimension: customer_id {
    type: int
    # hidden: true
    sql: ${TABLE}.customer_id ;;
  }

  dimension: inventory_id {
    type: int
    # hidden: true
    sql: ${TABLE}.inventory_id ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  dimension_group: rental {
    type: time
    timeframes: [time, date, week, month, day_of_week]
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: return {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.return_date ;;
  }

  dimension: is_late {
    type: yesno
    sql: CASE
        WHEN ${TABLE}.return_date IS NULL AND date_add(${TABLE}.rental_date, INTERVAL 14 DAY) > curdate() THEN 0
        WHEN ${TABLE}.return_date IS NULL AND date_add(${TABLE}.rental_date, INTERVAL 14 DAY) <= curdate() THEN 1
      END
       ;;
  }

  dimension: is_returned {
    type: yesno
    sql: coalesce(${return_date}, 0) ;;
  }

  # This is a derived date based on the rental date
  dimension_group: due_date {
    description: "This is automatically 2 weeks beyond the rental date"
    type: time
    timeframes: [time, date, week, month, day_of_week_index]
    sql: date_add(${TABLE}.rental_date, INTERVAL 14 DAY) ;;
  }

  dimension: staff_id {
    type: yesno
    # hidden: true
    sql: ${TABLE}.staff_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: late_count {
    type: count_distinct
    sql: ${rental_id} ;;

    filters: {
      field: is_late
      value: "yes"
    }
  }

  measure: late_percentage {
    type: number
    decimals: 2
    sql: (${late_count}*100.0)/nullif(${count},0) ;;
    value_format: "#.0\%"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      rental_id,
      inventory.inventory_id,
      customer.customer_id,
      customer.first_name,
      customer.last_name,
      staff.staff_id,
      staff.first_name,
      staff.last_name,
      staff.username,
      payment.count
    ]
  }
}
