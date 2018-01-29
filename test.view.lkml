explore: dashboard_run_history_facts {}

explore: dashboard_performance {
  from: dashboard_run_event_stats
  fields: [ALL_FIELDS*, -user.roles]
  view_label: "Dashboard Performance"

  always_filter: {
    filters: {
      field: dashboard_performance.raw_data_timeframe
      value: "2 hours"
    }
  }

  join: dashboard_run_history_facts {
    view_label: "Dashboard Performance"
    sql_on: ${dashboard_performance.dashboard_run_session} = ${dashboard_run_history_facts.dashboard_run_session_id} ;;
    relationship: one_to_one
  }

  join: dashboard_page_event_stats {
    view_label: "Dashboard Performance"
    sql_on: ${dashboard_performance.dashboard_page_session} = ${dashboard_page_event_stats.dashboard_page_session} ;;
    relationship: many_to_one
  }

  join: dashboard_filters {
    view_label: "Dashboard Performance"
    relationship: many_to_one
    sql_on: ${dashboard_filters.run_session_id} = ${dashboard_performance.dashboard_run_session} ;;
  }

  join: user {
    relationship: many_to_one
    sql_on: ${dashboard_performance.user_id} = ${user.id} ;;
    fields: [id, email, name, count]
  }
}
