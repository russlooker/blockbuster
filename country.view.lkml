view: country {
  dimension: country_id {
    primary_key: yes
    type: int
    sql: ${TABLE}.country_id ;;
  }

  dimension: country {
    sql: ${TABLE}.country ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  measure: count {
    type: count
    drill_fields: [country_id, city.count]
  }
}
