view: staff_list {
  dimension: id {
    primary_key: yes
    type: yesno
    sql: ${TABLE}.ID ;;
  }

  dimension: address {
    sql: ${TABLE}.address ;;
  }

  dimension: city {
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    sql: ${TABLE}.country ;;
  }

  dimension: name {
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    sql: ${TABLE}.phone ;;
  }

  dimension: sid {
    type: yesno
    sql: ${TABLE}.SID ;;
  }

  dimension: zip_code {
    sql: ${TABLE}.`zip code` ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}