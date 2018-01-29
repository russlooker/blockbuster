view: customer {
  dimension: customer_id {
    primary_key: yes
    type: int
    sql: ${TABLE}.customer_id ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: address_id {
    type: int
    # hidden: true
    sql: ${TABLE}.address_id ;;
  }

  dimension_group: create {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.create_date ;;
  }

  dimension: email {
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  dimension: store_id {
    type: yesno
    # hidden: true
    sql: ${TABLE}.store_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      customer_id,
      first_name,
      last_name,
      store.store_id,
      address.address_id,
      payment.count,
      rental.count
    ]
  }
}
