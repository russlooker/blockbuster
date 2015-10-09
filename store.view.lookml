- view: store
  fields:

  - dimension: store_id
    primary_key: true
    type: number
    sql: ${TABLE}.store_id

#Verify the store ID vs name casing with Bob    
  - dimension: store_name
    type: string
    sql: |
      CASE 
        WHEN ${store_id} = 1 THEN 'Westcoast'
        WHEN ${store_id} = 2 THEN 'Eastcoast'
        ELSE 'Unknown'
      END

  - dimension: address_id
    type: int
    # hidden: true
    sql: ${TABLE}.address_id

  - dimension_group: last_update
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update

  - dimension: manager_staff_id
    type: yesno
    sql: ${TABLE}.manager_staff_id

  - measure: count
    type: count
    drill_fields: [store_id, address.address_id, customer.count, inventory.count, staff.count]

