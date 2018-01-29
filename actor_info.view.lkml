view: actor_info {
  dimension: actor_id {
    type: int
    # hidden: true
    sql: ${TABLE}.actor_id ;;
  }

  dimension: film_info {
    sql: ${TABLE}.film_info ;;
  }

  dimension: first_name {
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    sql: ${TABLE}.last_name ;;
  }

  measure: count {
    type: count
    drill_fields: [first_name, last_name, actor.actor_id, actor.first_name, actor.last_name]
  }
}
