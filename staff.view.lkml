view: staff {
  dimension: staff_id {
    primary_key: yes
    type: yesno
    sql: ${TABLE}.staff_id ;;
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

  dimension: password {
    sql: ${TABLE}.password ;;
  }

  dimension: picture {
    sql: ${TABLE}.picture ;;
  }

  dimension: store_id {
    type: yesno
    # hidden: true
    sql: ${TABLE}.store_id ;;
  }

  dimension: username {
    sql: ${TABLE}.username ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      staff_id,
      first_name,
      last_name,
      username,
      address.address_id,
      store.store_id,
      payment.count,
      rental.count
    ]
  }
}
