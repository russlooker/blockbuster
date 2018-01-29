view: address {
  dimension: address_id {
    primary_key: yes
    type: int
    sql: ${TABLE}.address_id ;;
  }

  dimension: address {
    sql: ${TABLE}.address ;;
  }

  dimension: address2 {
    sql: ${TABLE}.address2 ;;
  }

  dimension: city_id {
    type: int
    # hidden: true
    sql: ${TABLE}.city_id ;;
  }

  dimension: district {
    sql: ${TABLE}.district ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  dimension: phone {
    sql: ${TABLE}.phone ;;
  }

  dimension: postal_code {
    sql: ${TABLE}.postal_code ;;
  }

  measure: count {
    type: count
    drill_fields: [address_id, city.city_id, customer.count, staff.count, store.count]
  }
}
