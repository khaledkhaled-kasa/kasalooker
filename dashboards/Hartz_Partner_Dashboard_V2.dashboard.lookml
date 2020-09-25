- dashboard: hartz_partner_dashboard__whitley_V2
  title: Hartz Partner Dashboard - Whitley - V2
  layout: newspaper
  elements:
  - title: September 2020 Occupancy
    name: September 2020 Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy, complexes.title]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    row: 2
    col: 0
    width: 5
    height: 2
  - title: September 2020 ADR
    name: September 2020 ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 2
    col: 5
    width: 5
    height: 2
  - title: September 2020 RevPAR
    name: September 2020 RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.revpar]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 2
    col: 10
    width: 5
    height: 2
  - name: Arrival Report - All Future Arrivals
    type: text
    title_text: Arrival Report - All Future Arrivals
    row: 16
    col: 0
    width: 24
    height: 2
  - title: September 2020 ADR - 1BD
    name: September 2020 ADR - 1BD
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '1'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 4
    col: 5
    width: 5
    height: 2
  - title: September 2020 ADR - 2BD
    name: September 2020 ADR - 2BD
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '2'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 4
    col: 10
    width: 5
    height: 2
  - title: September 2020 ADR - Studio
    name: September 2020 ADR - Studio
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '0'
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 4
    col: 0
    width: 5
    height: 2
  - title: Room Nights Sold - September 2020
    name: Room Nights Sold - September 2020
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [capacities_rolled.night_date, reservations.reservation_night, capacities_rolled.capacity_measure,
      complexes.title]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_date]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_date: 2020/09/01 to 2020/10/01
    sorts: [capacities_rolled.night_date, complexes.title 0]
    limit: 500
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    row: 6
    col: 0
    width: 24
    height: 6
  - name: Past Month Performance Metrics
    type: text
    title_text: Past Month Performance Metrics
    row: 27
    col: 0
    width: 24
    height: 2
  - title: Historical Occupancy
    name: Historical Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_month]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 29
    col: 0
    width: 8
    height: 6
  - title: Historical ADR
    name: Historical ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [complexes.title, financials.adr, capacities_rolled.night_month]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 29
    col: 8
    width: 8
    height: 6
  - title: Historical RevPAR
    name: Historical RevPAR
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [complexes.title, capacities_rolled.night_month, financials.revpar]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 29
    col: 16
    width: 8
    height: 6
  - name: Current Month Performance Metrics (based on reservations to date)
    type: text
    title_text: Current Month Performance Metrics (based on reservations to date)
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Prior Night Metrics
    type: text
    title_text: Prior Night Metrics
    row: 12
    col: 0
    width: 24
    height: 2
  - title: Historical ADR by room type
    name: Historical ADR by room type
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [complexes.title, financials.adr, capacities_rolled.night_month, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 35
    col: 8
    width: 8
    height: 6
  - title: Historical Occupancy by room type
    name: Historical Occupancy by room type
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_month, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
      units.bedrooms: ''
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 35
    col: 0
    width: 8
    height: 6
  - title: September 2020 Occupancy (copy)
    name: September 2020 Occupancy (copy)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy, complexes.title]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      reservations.status_booked: 'Yes'
      capacities_rolled.night_date: 1 days ago for 1 days
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Occupancy
    defaults_version: 1
    listen: {}
    row: 14
    col: 0
    width: 4
    height: 2
  - title: September 2020 ADR (copy)
    name: September 2020 ADR (copy)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      capacities_rolled.night_date: 1 days ago for 1 days
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: ADR
    defaults_version: 1
    listen: {}
    row: 14
    col: 4
    width: 5
    height: 2
  - title: September 2020 ADR - Studio (copy)
    name: September 2020 ADR - Studio (copy)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr, capacities_rolled.night_date]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_date]
    filters:
      complexes.title: Whitley
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '0'
      capacities_rolled.night_date: 1 days ago for 1 days
    sorts: [complexes.title, capacities_rolled.night_date desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Studio ADR
    defaults_version: 1
    listen: {}
    row: 14
    col: 9
    width: 5
    height: 2
  - title: September 2020 ADR - 1BD (copy)
    name: September 2020 ADR - 1BD (copy)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr, capacities_rolled.night_date]
    pivots: [complexes.title]
    fill_fields: [capacities_rolled.night_date]
    filters:
      complexes.title: Whitley
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '1'
      capacities_rolled.night_date: 1 days ago for 1 days
    sorts: [complexes.title, capacities_rolled.night_date desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 1BD ADR
    defaults_version: 1
    listen: {}
    row: 14
    col: 14
    width: 5
    height: 2
  - title: September 2020 ADR - 2BD (copy)
    name: September 2020 ADR - 2BD (copy)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    pivots: [complexes.title]
    filters:
      complexes.title: Whitley
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      units.bedrooms: '2'
      capacities_rolled.night_date: 1 days ago for 1 days
    sorts: [complexes.title]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 2BD ADR
    defaults_version: 1
    listen: {}
    row: 14
    col: 19
    width: 5
    height: 2
  - title: Future Reservation Information - 1BD Units
    name: Future Reservation Information - 1BD Units
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [units.internaltitle, reservations.checkindate, units.bedrooms, reservations.reservation_night,
      financials.adr, reservations.source, reservations.guestscount]
    filters:
      complexes.title: Whitley
      reservations.checkindate: after 0 minutes ago
      reservations.status_booked: 'Yes'
      financials.type: "-ToT,-ToTInflowNonLiability,-ToTInflow,-ToTOutflowNonLiability,-channelFee"
      units.bedrooms: '1'
    sorts: [reservations.checkindate]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      reservations.reservation_night:
        is_active: false
    defaults_version: 1
    series_types: {}
    hidden_fields: [units.bedrooms]
    column_order: ["$$$_row_numbers_$$$", units.internaltitle, reservations.checkindate,
      reservations.reservation_night, reservations.source, reservations.guestscount,
      financials.adr]
    listen: {}
    row: 21
    col: 0
    width: 24
    height: 3
  - title: Future Reservation Information - Studio Units
    name: Future Reservation Information - Studio Units
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [units.internaltitle, reservations.checkindate, units.bedrooms, reservations.reservation_night,
      financials.adr, reservations.source, reservations.guestscount]
    filters:
      complexes.title: Whitley
      reservations.checkindate: after 0 minutes ago
      reservations.status_booked: 'Yes'
      financials.type: "-ToT,-ToTInflowNonLiability,-ToTInflow,-ToTOutflowNonLiability,-channelFee"
      units.bedrooms: '0'
    sorts: [reservations.reservation_night desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      reservations.reservation_night:
        is_active: false
    defaults_version: 1
    series_types: {}
    series_column_widths:
      financials.adr: 221
      reservations.guestscount: 222
      units.internaltitle: 228
      reservations.checkindate: 224
      reservations.reservation_night: 369
      reservations.source: 180
    hidden_fields: [units.bedrooms]
    column_order: ["$$$_row_numbers_$$$", units.internaltitle, reservations.checkindate,
      reservations.reservation_night, reservations.source, reservations.guestscount,
      financials.adr]
    listen: {}
    row: 18
    col: 0
    width: 24
    height: 3
  - title: Future Reservation Information - 2BD Units
    name: Future Reservation Information - 2BD Units
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [units.internaltitle, reservations.checkindate, units.bedrooms, reservations.reservation_night,
      financials.adr, reservations.source, reservations.guestscount]
    filters:
      complexes.title: Whitley
      reservations.checkindate: after 0 minutes ago
      reservations.status_booked: 'Yes'
      financials.type: "-ToT,-ToTInflowNonLiability,-ToTInflow,-ToTOutflowNonLiability,-channelFee"
      units.bedrooms: '2'
    sorts: [financials.adr desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      reservations.reservation_night:
        is_active: false
    defaults_version: 1
    series_types: {}
    column_order: ["$$$_row_numbers_$$$", units.internaltitle, reservations.checkindate,
      reservations.reservation_night, reservations.source, reservations.guestscount,
      financials.adr]
    hidden_fields: [units.bedrooms]
    listen: {}
    row: 24
    col: 0
    width: 24
    height: 3
  - title: Historical RevPAR by room type
    name: Historical RevPAR by room type
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [complexes.title, capacities_rolled.night_month, financials.revpar, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_rolled.night_month]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 6 months
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_rolled.night_month desc]
    limit: 500
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
    defaults_version: 1
    listen: {}
    row: 35
    col: 16
    width: 8
    height: 6
  - title: September 2020 Occupancy by room type
    name: September 2020 Occupancy by room type
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.occupancy, complexes.title, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    filters:
      complexes.title: Whitley
      capacities_rolled.night_month: 2020/09/01 to 2020/10/01
      reservations.status_booked: 'Yes'
    sorts: [complexes.title, units.bedrooms]
    limit: 500
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
    legend_position: right
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    column_spacing_ratio: 0.5
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 2
    col: 15
    width: 9
    height: 4
