view: film_list {
  dimension: actors {
    sql: ${TABLE}.actors ;;
  }

  dimension: category {
    sql: ${TABLE}.category ;;
  }

  dimension: description {
    sql: ${TABLE}.description ;;
  }

  dimension: fid {
    type: int
    sql: ${TABLE}.FID ;;
  }

  dimension: length {
    type: number
    sql: ${TABLE}.length ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: rating {
    sql: ${TABLE}.rating ;;
  }

  dimension: title {
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
