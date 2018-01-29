view: film_actor {
  dimension: actor_id {
    type: int
    # hidden: true
    sql: ${TABLE}.actor_id ;;
  }

  dimension: film_id {
    type: int
    # hidden: true
    sql: ${TABLE}.film_id ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  measure: count {
    type: count
    drill_fields: [actor.actor_id, actor.first_name, actor.last_name, film.film_id]
  }
}
