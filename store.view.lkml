view: store {
  dimension: store_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.store_id ;;
  }

  #   - dimension: store_name
  #     type: string
  #     sql: |
  #       CASE
  #         WHEN ${store_id} = 1 THEN 'Westcoast'
  #         WHEN ${store_id} = 2 THEN 'Eastcoast'
  #         ELSE 'Unknown'
  #       END
  #     html: |
  #       {{ linked_value }}
  #       <a href="/dashboards/95?Store%20Name={{ value | encode_uri }}" target="_new">
  #       <img src="/images/qr-graph-line@2x.png" height=20 width=20></a>

  dimension: store_name {
    case: {
      when: {
        sql: ${TABLE}.store_id = 1 ;;
        label: "Westcoast"
      }

      when: {
        sql: ${TABLE}.store_id = 2 ;;
        label: "Eastcoast"
      }

      # Option 1 for an “unknown” overflow bucket
      else: "unknown"
    }

    html: {{ linked_value }}
      <a href="/dashboards/95?Store%20Name={{ value | encode_uri }}" target="_new">
      <img src="/images/qr-graph-line@2x.png" height=20 width=20></a>
      ;;
    suggestable: yes
  }

  dimension: address_id {
    type: int
    # hidden: true
    sql: ${TABLE}.address_id ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_update ;;
  }

  dimension: manager_staff_id {
    type: yesno
    sql: ${TABLE}.manager_staff_id ;;
  }

  measure: count {
    type: count
    drill_fields: [store_id, address.address_id, customer.count, inventory.count, staff.count]
  }
}
