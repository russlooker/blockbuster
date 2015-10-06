- connection: video_store

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: actor

- explore: actor_info
  joins:
    - join: actor
      type: left_outer
      sql_on: ${actor_info.actor_id} = ${actor.actor_id}
      relationship: many_to_one


- explore: address
  joins:
    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: category

- explore: city
  joins:
    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: country

- explore: customer
  joins:
    - join: store
      type: left_outer
      sql_on: ${customer.store_id} = ${store.store_id}
      relationship: many_to_one

    - join: address
      type: left_outer
      sql_on: ${customer.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: customer_list

- explore: film
  joins:
    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one


- explore: film_actor
  joins:
    - join: actor
      type: left_outer
      sql_on: ${film_actor.actor_id} = ${actor.actor_id}
      relationship: many_to_one

    - join: film
      type: left_outer
      sql_on: ${film_actor.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one


- explore: film_category
  joins:
    - join: film
      type: left_outer
      sql_on: ${film_category.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: category
      type: left_outer
      sql_on: ${film_category.category_id} = ${category.category_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one


- explore: film_list

- explore: film_text
  joins:
    - join: film
      type: left_outer
      sql_on: ${film_text.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one


- explore: inventory
  joins:
    - join: film
      type: left_outer
      sql_on: ${inventory.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: store
      type: left_outer
      sql_on: ${inventory.store_id} = ${store.store_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one

    - join: address
      type: left_outer
      sql_on: ${store.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: language

- explore: nicer_but_slower_film_list

- explore: payment
  joins:
    - join: customer
      type: left_outer
      sql_on: ${payment.customer_id} = ${customer.customer_id}
      relationship: many_to_one

    - join: staff
      type: left_outer
      sql_on: ${payment.staff_id} = ${staff.staff_id}
      relationship: many_to_one

    - join: rental
      type: left_outer
      sql_on: ${payment.rental_id} = ${rental.rental_id}
      relationship: many_to_one

    - join: store
      type: left_outer
      sql_on: ${customer.store_id} = ${store.store_id}
      relationship: many_to_one

    - join: address
      type: left_outer
      sql_on: ${customer.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one

    - join: inventory
      type: left_outer
      sql_on: ${rental.inventory_id} = ${inventory.inventory_id}
      relationship: many_to_one

    - join: film
      type: left_outer
      sql_on: ${inventory.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one


- explore: rental
  joins:
    - join: inventory
      type: left_outer
      sql_on: ${rental.inventory_id} = ${inventory.inventory_id}
      relationship: many_to_one

    - join: customer
      type: left_outer
      sql_on: ${rental.customer_id} = ${customer.customer_id}
      relationship: many_to_one

    - join: staff
      type: left_outer
      sql_on: ${rental.staff_id} = ${staff.staff_id}
      relationship: many_to_one

    - join: film
      type: left_outer
      sql_on: ${inventory.film_id} = ${film.film_id}
      relationship: many_to_one

    - join: store
      type: left_outer
      sql_on: ${inventory.store_id} = ${store.store_id}
      relationship: many_to_one

    - join: language
      type: left_outer
      sql_on: ${film.language_id} = ${language.language_id}
      relationship: many_to_one

    - join: address
      type: left_outer
      sql_on: ${store.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: sales_by_film_category

- explore: sales_by_store

- explore: staff
  joins:
    - join: address
      type: left_outer
      sql_on: ${staff.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: store
      type: left_outer
      sql_on: ${staff.store_id} = ${store.store_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


- explore: staff_list

- explore: store
  joins:
    - join: address
      type: left_outer
      sql_on: ${store.address_id} = ${address.address_id}
      relationship: many_to_one

    - join: city
      type: left_outer
      sql_on: ${address.city_id} = ${city.city_id}
      relationship: many_to_one

    - join: country
      type: left_outer
      sql_on: ${city.country_id} = ${country.country_id}
      relationship: many_to_one


