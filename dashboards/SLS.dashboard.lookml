- dashboard: weekly_performance_report_sola_station_sls
  title: Weekly Performance Report Sola Station (SLS)
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - name: Past Month Performance Metrics
    type: text
    title_text: Past Month Performance Metrics
    row: 26
    col: 0
    width: 24
    height: 2
  - name: Current Month Performance Metrics
    type: text
    title_text: Current Month Performance Metrics
    subtitle_text: Data includes all reservations currently booked for this month.   May
      change daily as reservations are altered, added or cancelled.
    body_text: ''
    row: 5
    col: 0
    width: 24
    height: 2
  - title: This Month's ADR
    name: This Month's ADR
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      Building Filter: complexes.title
    row: 10
    col: 8
    width: 8
    height: 3
  - title: Untitled
    name: Untitled
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [financials_v3.night_date]
    fill_fields: [financials_v3.night_date]
    filters:
      financials_v3.night_date: 1 days
    sorts: [financials_v3.night_date desc]
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#4276BE"
    single_value_title: Today's date
    series_types: {}
    show_view_names: false
    defaults_version: 1
    listen:
      Building Filter: complexes.title
    row: 0
    col: 0
    width: 24
    height: 2
  - title: This Month's Occupancy
    name: This Month's Occupancy
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [reservations_v3.occupancy, complexes.title]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      Building Filter: complexes.title
    row: 7
    col: 16
    width: 8
    height: 6
  - title: This Month's RevPAR
    name: This Month's RevPAR
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.revpar]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      Building Filter: complexes.title
    row: 10
    col: 0
    width: 8
    height: 3
  - title: Historical ADR
    name: Historical ADR
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [complexes.title, financials_v3.adr, capacities_v3.night_month]
    pivots: [complexes.title]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: financials_v3.adr, id: Whitley
              - financials_v3.adr, name: Whitley}], showLabels: true, showValues: true,
        maxValue: 240, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    listen:
      Building Filter: complexes.title
    row: 28
    col: 8
    width: 8
    height: 8
  - title: Historical Occupancy
    name: Historical Occupancy
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [reservations_v3.occupancy, complexes.title, capacities_v3.night_month]
    pivots: [complexes.title]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations_v3.occupancy,
            id: Whitley - reservations_v3.occupancy, name: Whitley}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
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
    listen:
      Building Filter: complexes.title
    row: 28
    col: 0
    width: 8
    height: 8
  - title: Airbnb ratings
    name: Airbnb ratings
    model: kasametrics
    explore: reservations
    type: table
    fields: [financials_v3.night_month, airbnb_reviews.count, airbnb_reviews.overall_rating_avg]
    filters:
      reservations_v3.status: confirmed,"checked_in"
      financials_v3.night_date: 6 months ago for 6 months
    sorts: [financials_v3.night_month desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    stacking: normal
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb_reviews.overall_rating_avg,
            id: airbnb_reviews.overall_rating_avg, name: Overall Rating Avg}, {axisId: airbnb_reviews.count,
            id: airbnb_reviews.count, name: Airbnb Reviews}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Month
    series_types: {}
    series_labels:
      airbnb - reservations_v3.num_reservations: Airbnb
      booking.com - reservations_v3.num_reservations: Booking.com
      direct - reservations_v3.num_reservations: Direct
      expedia - reservations_v3.num_reservations: Expedia
      other - reservations_v3.num_reservations: Other
    x_axis_datetime_label: "%b %Y"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [direct, airbnb, expedia, bookingcom, other]
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    listen:
      Building Filter: complexes.title
    row: 13
    col: 12
    width: 12
    height: 6
  - title: Historical RevPAR
    name: Historical RevPAR
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [complexes.title, capacities_v3.night_month, financials_v3.revpar]
    pivots: [complexes.title]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: financials_v3.revpar, id: Whitley
              - financials_v3.revpar, name: Whitley}], showLabels: true, showValues: true,
        maxValue: 125, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    listen:
      Building Filter: complexes.title
    row: 28
    col: 16
    width: 8
    height: 8
  - title: Capacity
    name: Capacity
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_column
    fields: [capacities_v3.night_date, reservations_v3.reservation_night, capacities_v3.capacity,
      complexes.title]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_date: this month
      financials_v3.types_filtered: 'Yes'
      reservations_v3.status_booked: 'Yes'
    sorts: [capacities_v3.night_date, complexes.title 0]
    limit: 500
    dynamic_fields: [{table_calculation: unoccupied_nights, label: Unoccupied Nights,
        expression: "${capacities_v3.capacity} - ${reservations_v3.reservation_night}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
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
    hidden_series: [Whitley - capacities_v3.capacity]
    series_types:
      Whitley - reservations_v3.reservation_night: area
    series_colors:
      Whitley - capacities_v3.capacity: "#C2DD67"
      Whitley - unoccupied_nights: "#B1399E"
    series_labels:
      Whitley - reservations_v3.reservation_night: Occupied Nights
      Whitley - unoccupied_nights: Available Nights
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [capacities_v3.capacity]
    listen:
      Building Filter: complexes.title
    row: 19
    col: 0
    width: 24
    height: 7
  - title: Total Reservations This Month and Next Month
    name: Total Reservations This Month and Next Month
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_column
    fields: [financials_v3.night_month, financials_v3.types_filtered, reservations_v3.num_reservations,
      complexes.title]
    filters:
      financials_v3.night_month: 0 months from now for 2 months
      financials_v3.types_filtered: 'Yes'
    sorts: [financials_v3.night_month, reservations_v3.num_reservations desc]
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
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    series_column_widths:
      reservations_v3.num_reservations: 488
    column_order: []
    show_null_points: true
    interpolation: linear
    hidden_fields: [financials_v3.types_filtered]
    listen:
      Building Filter: complexes.title
    row: 13
    col: 0
    width: 12
    height: 6
  - title: ADR 1BR
    name: ADR 1BR
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
      units.bedrooms: '1'
    sorts: [complexes.title]
    limit: 500
    column_limit: 50
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
    listen:
      Building Filter: complexes.title
    row: 7
    col: 0
    width: 8
    height: 3
  - title: ADR 2BR
    name: ADR 2BR
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
      units.bedrooms: '2'
    sorts: [complexes.title]
    limit: 500
    column_limit: 50
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
    listen:
      Building Filter: complexes.title
    row: 7
    col: 8
    width: 8
    height: 3
  - title: Overview of Units
    name: Overview of Units
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_grid
    fields: [complexes.title, capacities_v3.capacity, units.bedrooms]
    pivots: [units.bedrooms]
    filters:
      capacities_v3.night_month: today
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, units.bedrooms]
    limit: 500
    column_limit: 50
    row_total: right
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '18'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    series_labels: {}
    series_column_widths:
      capacities_v3.capacity: 110
    series_cell_visualizations:
      capacities_v3.capacity:
        is_active: false
    series_text_format:
      capacities_v3.capacity:
        align: left
        bold: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    header_font_color: "#592EC2"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    series_types: {}
    up_color: "#3EB0D5"
    down_color: "#B1399E"
    total_color: "#C2DD67"
    show_value_labels: false
    show_x_axis_ticks: true
    show_x_axis_label: true
    x_axis_scale: auto
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_gridlines: true
    truncate_column_names: false
    x_axis_gridlines: false
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    label_density: 25
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Building Filter: complexes.title
    row: 2
    col: 4
    width: 16
    height: 3
  filters:
  - name: Building Filter
    title: Building Filter
    type: field_filter
    default_value: SolaStation
    allow_multiple_values: true
    required: false
    model: kasametrics_v3
    explore: capacities_v3
    listens_to_filters: []
    field: complexes.title
