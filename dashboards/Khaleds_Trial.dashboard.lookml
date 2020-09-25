- dashboard: Khaleds_Trial_Dashboard
  title: Kasa Weekly Performance
  layout: newspaper
  elements:
  - title: 2020 Monthly Performance by Property
    name: 2020 Monthly Performance by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: table
    fields: [financials.revpar, complexes.title, capacities_rolled.night_month]
    pivots: [capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/01/01 to 2021/01/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.revpar desc 0, capacities_rolled.night_month]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    defaults_version: 1
    series_types: {}
    column_order: ["$$$_row_numbers_$$$", complexes.title, reservations.num_reservations,
      reservations.occupancy, financials.adr, financials.revpar]
    listen: {}
    row: 50
    col: 0
    width: 24
    height: 5
  - title: 2020 June Monthly ADR
    name: 2020 June Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/08/01 to 2020/07/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 44
    col: 4
    width: 4
    height: 2
  - title: 2020 June Monthly Occupancy
    name: 2020 June Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/06/01 to 2020/07/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 44
    col: 0
    width: 4
    height: 2
  - title: 2020 July Monthly ADR
    name: 2020 July Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/08/01 to 2020/08/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 46
    col: 4
    width: 4
    height: 2
  - title: 2020 July Monthly Occupancy
    name: 2020 July Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/07/01 to 2020/08/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 46
    col: 0
    width: 4
    height: 2
  - name: Weekly Metrics
    type: text
    title_text: Weekly Metrics
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Monthly Performance - Previous Months
    type: text
    title_text: Monthly Performance - Previous Months
    row: 42
    col: 0
    width: 24
    height: 2
  - name: Monthly Performance - Current Month
    type: text
    title_text: Monthly Performance - Current Month
    row: 11
    col: 0
    width: 24
    height: 2
  - name: Monthly Performance - Future Months
    type: text
    title_text: Monthly Performance - Future Months
    row: 34
    col: 0
    width: 24
    height: 2
  - title: 2020 July Monthly RevPAR
    name: 2020 July Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/08/01 to 2020/08/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 46
    col: 8
    width: 4
    height: 2
  - title: 2020 June Monthly RevPAR
    name: 2020 June Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/08/01 to 2020/07/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 44
    col: 8
    width: 4
    height: 2
  - name: Current Month - Channel and LOS Metrics
    type: text
    title_text: Current Month - Channel and LOS Metrics
    row: 26
    col: 0
    width: 24
    height: 2
  - title: Lead Time by Stay Date
    name: Lead Time by Stay Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_lead_time, capacities_rolled.night_month, reservations.median_lead_time]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/01/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types:
      reservations.median_lead_time: scatter
    series_colors:
      reservations.avg_lead_time: "#FFD95F"
      reservations.median_lead_time: "#E57947"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    listen: {}
    row: 28
    col: 16
    width: 8
    height: 6
  - title: 2020 August Monthly Occupancy
    name: 2020 August Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 48
    col: 0
    width: 4
    height: 2
  - title: 2020 August Monthly ADR
    name: 2020 August Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 48
    col: 4
    width: 4
    height: 2
  - title: 2020 August Monthly RevPAR
    name: 2020 August Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 48
    col: 8
    width: 4
    height: 2
  - title: 2020 Monthly RevPAR
    name: 2020 Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen: {}
    row: 44
    col: 12
    width: 12
    height: 6
  - title: 2020 October Monthly Occupancy
    name: 2020 October Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 36
    col: 0
    width: 5
    height: 2
  - title: 2020 October Monthly ADR
    name: 2020 October Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 36
    col: 5
    width: 5
    height: 2
  - title: 2020 October Monthly RevPAR
    name: 2020 October Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 36
    col: 10
    width: 5
    height: 2
  - title: October Monthly Performance by Property
    name: October Monthly Performance by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [complexes.title, reservations.num_reservations, reservations.occupancy,
      financials.adr, financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.revpar desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 36
    col: 16
    width: 8
    height: 6
  - title: LOS by Stay Date
    name: LOS by Stay Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_length_of_stay, reservations.median_length_of_stay,
      capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/01/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types:
      reservations.median_length_of_stay: scatter
    series_colors:
      reservations.median_length_of_stay: "#592EC2"
      reservations.avg_length_of_stay: "#3EB0D5"
    series_point_styles:
      reservations.median_length_of_stay: diamond
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    listen: {}
    row: 28
    col: 8
    width: 8
    height: 6
  - title: Monthly Channel Segmentation - % of Revenue
    name: Monthly Channel Segmentation - % of Revenue
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [financials.amount, capacities_rolled.night_month, reservations.source]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/01/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.amount desc 0, capacities_rolled.night_month, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: contribution, label: "% Contribution", expression: "${financials.amount}/${financials.amount:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: [financials.amount]
    listen: {}
    row: 28
    col: 0
    width: 8
    height: 6
  - title: September Monthly Performance by Property
    name: September Monthly Performance by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [complexes.title, reservations.num_reservations, reservations.occupancy,
      financials.adr, financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.revpar desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 13
    col: 16
    width: 8
    height: 6
  - title: 2020 September Monthly Occupancy
    name: 2020 September Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 13
    col: 0
    width: 5
    height: 2
  - title: 2020 September Monthly ADR
    name: 2020 September Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 13
    col: 5
    width: 5
    height: 2
  - title: 2020 September Monthly RevPAR
    name: 2020 September Monthly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2019/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 13
    col: 10
    width: 5
    height: 2
  - title: September vs August RevPAR by Property
    name: September vs August RevPAR by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [complexes.title, financials.revpar, capacities_rolled.night_month]
    pivots: [capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
      complexes.title: "-Strata,-Tempo,-Parker"
    sorts: [capacities_rolled.night_month 0, variance desc 1]
    limit: 500
    dynamic_fields: [{table_calculation: variance, label: "% Variance", expression: "(${financials.revpar}\
          \ / pivot_offset(${financials.revpar}, -1)) - 1", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      reservations.num_reservations:
        is_active: false
      reservations.occupancy:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: [financials.revpar]
    listen: {}
    row: 19
    col: 0
    width: 24
    height: 7
  - title: 2020 Weekly Occupancy
    name: 2020 Weekly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/09/06 to 2020/09/13
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 2
    col: 0
    width: 8
    height: 2
  - title: 2020 Weekly ADR
    name: 2020 Weekly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr]
    filters:
      capacities_rolled.night_date: 2020/09/06 to 2020/09/13
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 2
    col: 8
    width: 8
    height: 2
  - title: 2020 Weekly RevPAR
    name: 2020 Weekly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/09/06 to 2020/09/13
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 2
    col: 16
    width: 8
    height: 2
  - title: 2019 Weekly Occupancy
    name: 2019 Weekly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2019/09/08 to 2019/09/15
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 4
    col: 0
    width: 8
    height: 2
  - title: 2019 Weekly ADR
    name: 2019 Weekly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr]
    filters:
      capacities_rolled.night_date: 2019/09/08 to 2019/09/15
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 4
    col: 8
    width: 8
    height: 2
  - title: 2019 Weekly RevPAR
    name: 2019 Weekly RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar]
    filters:
      capacities_rolled.night_date: 2019/09/08 to 2019/09/15
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 4
    col: 16
    width: 8
    height: 2
  - title: Weekly Performance Metrics by Property
    name: Weekly Performance Metrics by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [financials.revpar, complexes.title]
    filters:
      capacities_rolled.night_date: 2020/09/06 to 2020/09/13
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.revpar desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_column_names: false
    defaults_version: 1
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 5
  - title: OTB Same Time Last Week
    name: OTB Same Time Last Week
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_date: 2020/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 15
    col: 0
    width: 5
    height: 2
  - title: ADR Same Time Last Week
    name: ADR Same Time Last Week
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_month: 2019/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 15
    col: 5
    width: 5
    height: 2
  - title: RevPAR Same Time Last Week
    name: RevPAR Same Time Last Week
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 15
    col: 10
    width: 5
    height: 2
  - title: OTB Same Time Last Month
    name: OTB Same Time Last Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 17
    col: 0
    width: 5
    height: 2
  - title: ADR Same Time Last Month
    name: ADR Same Time Last Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_month: 2019/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 17
    col: 5
    width: 5
    height: 2
  - title: RevPAR Same Time Last Month
    name: RevPAR Same Time Last Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_month: 2020/08/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 17
    col: 10
    width: 5
    height: 2
  - title: OTB Same Time Last Week
    name: OTB Same Time Last Week (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_date: 2020/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 38
    col: 0
    width: 5
    height: 2
  - title: ADR Same Time Last Week
    name: ADR Same Time Last Week (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_month: 2019/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 38
    col: 5
    width: 5
    height: 2
  - title: RevPAR Same Time Last Week
    name: RevPAR Same Time Last Week (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/09/09
      capacities_rolled.night_month: 2019/10/01 to 2020/11/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 38
    col: 10
    width: 5
    height: 2
  - title: OTB Same Time Last Month
    name: OTB Same Time Last Month (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_date: 2020/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 40
    col: 0
    width: 5
    height: 2
  - title: ADR Same Time Last Month
    name: ADR Same Time Last Month (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.adr]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_month: 2019/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 40
    col: 5
    width: 5
    height: 2
  - title: RevPAR Same Time Last Month
    name: RevPAR Same Time Last Month (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [capacities_rolled.night_month, financials.revpar]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: before 2020/08/15
      capacities_rolled.night_month: 2019/09/01 to 2020/10/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 40
    col: 10
    width: 5
    height: 2
