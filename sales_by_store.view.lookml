- view: sales_by_store
  fields:

  - dimension: manager
    sql: ${TABLE}.manager

  - dimension: store
    sql: ${TABLE}.store

  - dimension: total_sales
    type: number
    sql: ${TABLE}.total_sales

  - measure: count
    type: count
    drill_fields: []

