- dashboard: monthly_performance_report_delray
  title: Monthly Performance Report (DelRay)
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - name: Past Month Performance Metrics
    type: text
    title_text: Past Month Performance Metrics
    row: 20
    col: 0
    width: 24
    height: 2
  - name: Next Month's Projections
    type: text
    title_text: Next Month's Projections
    subtitle_text: Data includes all reservations currently booked for next month.
      May change daily as reservations are altered, added or cancelled.
    row: 46
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
      bldg filter: complexes.title
    row: 0
    col: 0
    width: 24
    height: 2
  - title: ADR
    name: ADR
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
      bldg filter: complexes.title
    row: 8
    col: 5
    width: 5
    height: 3
  - title: RevPAR
    name: RevPAR
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
      bldg filter: complexes.title
    row: 8
    col: 10
    width: 5
    height: 3
  - title: Occupancy
    name: Occupancy
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
      bldg filter: complexes.title
    row: 8
    col: 0
    width: 5
    height: 3
  - title: Occupancy by room type
    name: Occupancy by room type
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_column
    fields: [reservations_v3.occupancy, complexes.title, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations_v3.occupancy,
            id: Whitley - 0 - reservations_v3.occupancy, name: Whitley - 0}, {axisId: reservations_v3.occupancy,
            id: Whitley - 1 - reservations_v3.occupancy, name: Whitley - 1}, {axisId: reservations_v3.occupancy,
            id: Whitley - 2 - reservations_v3.occupancy, name: Whitley - 2}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    hide_legend: false
    series_types: {}
    column_spacing_ratio: 0.5
    show_dropoff: false
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
    listen:
      bldg filter: complexes.title
    row: 8
    col: 15
    width: 9
    height: 5
  - title: ADR - 1BD
    name: ADR - 1BD
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
      bldg filter: complexes.title
    row: 11
    col: 5
    width: 5
    height: 2
  - title: ADR - Studio
    name: ADR - Studio
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: this month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      bldg filter: complexes.title
    row: 11
    col: 0
    width: 5
    height: 2
  - title: Room Nights Sold - Current Month
    name: Room Nights Sold - Current Month
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_series: [Whitley - capacities_v3.capacity]
    series_types: {}
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
      bldg filter: complexes.title
    row: 13
    col: 0
    width: 24
    height: 7
  - title: ADR - 2BD
    name: ADR - 2BD
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
      bldg filter: complexes.title
    row: 11
    col: 10
    width: 5
    height: 2
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
      bldg filter: complexes.title
    row: 22
    col: 0
    width: 8
    height: 8
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
      bldg filter: complexes.title
    row: 22
    col: 8
    width: 8
    height: 8
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
      bldg filter: complexes.title
    row: 22
    col: 16
    width: 8
    height: 8
  - title: Historical Occupancy by room type
    name: Historical Occupancy by room type
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [reservations_v3.occupancy, complexes.title, capacities_v3.night_month,
      units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      units.bedrooms: ''
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc, units.bedrooms]
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
            id: Whitley - 0 - reservations_v3.occupancy, name: Whitley - 0}, {axisId: reservations_v3.occupancy,
            id: Whitley - 1 - reservations_v3.occupancy, name: Whitley - 1}, {axisId: reservations_v3.occupancy,
            id: Whitley - 2 - reservations_v3.occupancy, name: Whitley - 2}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
      bldg filter: complexes.title
    row: 30
    col: 0
    width: 8
    height: 8
  - title: Historical ADR by room type
    name: Historical ADR by room type
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [complexes.title, financials_v3.adr, capacities_v3.night_month, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc, units.bedrooms]
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
              - 0 - financials_v3.adr, name: Whitley - 0}, {axisId: financials_v3.adr, id: Whitley
              - 1 - financials_v3.adr, name: Whitley - 1}, {axisId: financials_v3.adr, id: Whitley
              - 2 - financials_v3.adr, name: Whitley - 2}], showLabels: true, showValues: true,
        maxValue: 200, minValue: 50, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
      bldg filter: complexes.title
    row: 30
    col: 8
    width: 8
    height: 8
  - title: Historical RevPAR by room type
    name: Historical RevPAR by room type
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_line
    fields: [complexes.title, capacities_v3.night_month, financials_v3.revpar, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    fill_fields: [capacities_v3.night_month]
    filters:
      capacities_v3.night_month: 6 months
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
    sorts: [complexes.title, capacities_v3.night_month desc, units.bedrooms]
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
              - 0 - financials_v3.revpar, name: Whitley - 0}, {axisId: financials_v3.revpar,
            id: Whitley - 1 - financials_v3.revpar, name: Whitley - 1}, {axisId: financials_v3.revpar,
            id: Whitley - 2 - financials_v3.revpar, name: Whitley - 2}], showLabels: true,
        showValues: true, maxValue: 160, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
      bldg filter: complexes.title
    row: 30
    col: 16
    width: 8
    height: 8
  - title: Bookings by channel
    name: Bookings by channel
    model: kasametrics
    explore: reservations
    type: looker_column
    fields: [financials_v3.night_month, reservations_v3.num_reservations, reservations_v3.source]
    pivots: [reservations_v3.source]
    fill_fields: [financials_v3.night_month]
    filters:
      reservations_v3.status: confirmed,"checked_in"
      financials_v3.night_date: 6 months ago for 6 months
    sorts: [financials_v3.night_month desc, reservations_v3.source]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: direct, label: Direct, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Landlord\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Landlord\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"MANUAL\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"MANUAL\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"manual\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"manual\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Comp'd)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Comp'd)\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Email)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Email)\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (ex Booking)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (ex Booking)\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Extension)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Extension)\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (extension)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (extension)\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual A\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual A\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual New\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual New\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual-comp'ed\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual-comp'ed\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual-Repeat Guest\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual-Repeat Guest\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual Extension\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual Extension\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual extension\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual extension\", ${reservations_v3.num_reservations})) \n+  if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Roman's Friend\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Roman's Friend\", ${reservations_v3.num_reservations})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"website\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"website\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Website\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Website\", ${reservations_v3.num_reservations}))\n\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: airbnb, label: Airbnb, expression: "\nif(is_null(pivot_where(${reservations_v3.source}\
          \ = \"airbnb\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"airbnb\", ${reservations_v3.num_reservations})) + if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Airbnb\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Airbnb\", ${reservations_v3.num_reservations})) + if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"airbnb2\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"airbnb2\", ${reservations_v3.num_reservations}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: expedia, label: Expedia, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Expedia\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Expedia\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Expedia (Manually)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Expedia (Manually)\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"HomeAway\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"HomeAway\", ${reservations_v3.num_reservations}))\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: bookingcom, label: Booking.com, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Booking.com\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Booking.com\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Booking.com - Manual\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Booking.com - Manual\", ${reservations_v3.num_reservations}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: other, label: Other, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Disregard - Test\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Disregard - Test\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"googlesc@rentalsunited.com\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"googlesc@rentalsunited.com\", ${reservations_v3.num_reservations}))\n\
          + if(is_null(pivot_where(${reservations_v3.source} = \"Tripadvisor\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"Tripadvisor\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"TripAdvisor (Manual)\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"TripAdvisor (Manual)\", ${reservations_v3.num_reservations}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${reservations_v3.num_reservations})),0,pivot_where(${reservations_v3.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${reservations_v3.num_reservations}))",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: desc
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Number of Reservations, orientation: left, series: [{axisId: airbnb,
            id: airbnb, name: Airbnb}, {axisId: direct, id: direct, name: Direct},
          {axisId: bookingcom, id: bookingcom, name: Booking.com}, {axisId: expedia,
            id: expedia, name: Expedia}, {axisId: other, id: other, name: Other}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    listen:
      bldg filter: complexes.title
    row: 38
    col: 8
    width: 8
    height: 8
  - title: "% of revenue by channel"
    name: "% of revenue by channel"
    model: kasametrics
    explore: reservations
    type: looker_column
    fields: [financials_v3.night_month, reservations_v3.source, financials_v3.amount]
    pivots: [reservations_v3.source]
    fill_fields: [financials_v3.night_month]
    filters:
      reservations_v3.status: confirmed,"checked_in"
      financials_v3.night_date: 6 months ago for 6 months
    sorts: [reservations_v3.source 0, financials_v3.night_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: direct, label: Direct, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Landlord\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Landlord\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"MANUAL\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"MANUAL\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"manual\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"manual\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Comp'd)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Comp'd)\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Email)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Email)\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (ex Booking)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (ex Booking)\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (Extension)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (Extension)\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual (extension)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual (extension)\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual A\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual A\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual New\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual New\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual-comp'ed\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual-comp'ed\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual-Repeat Guest\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual-Repeat Guest\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual Extension\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual Extension\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Manual extension\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Manual extension\", ${financials_v3.amount})) \n+  if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Roman's Friend\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Roman's Friend\", ${financials_v3.amount})) \n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"website\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"website\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Website\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Website\", ${financials_v3.amount}))\n\n", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, _type_hint: number}, {table_calculation: airbnb,
        label: Airbnb, expression: 'if(is_null(pivot_where(${reservations_v3.source}
          = "airbnb", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}
          = "airbnb", ${financials_v3.amount})) + if(is_null(pivot_where(${reservations_v3.source}
          = "Airbnb", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}
          = "Airbnb", ${financials_v3.amount})) + if(is_null(pivot_where(${reservations_v3.source}
          = "airbnb2", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}
          = "airbnb2", ${financials_v3.amount}))', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, _type_hint: number}, {table_calculation: expedia,
        label: Expedia, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Expedia\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Expedia\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Expedia (Manually)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Expedia (Manually)\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"HomeAway\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"HomeAway\", ${financials_v3.amount}))\n\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: bookingcom, label: Booking.com, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Booking.com\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Booking.com\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Booking.com - Manual\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Booking.com - Manual\", ${financials_v3.amount}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: other, label: Other, expression: "if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Disregard - Test\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Disregard - Test\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"googlesc@rentalsunited.com\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"googlesc@rentalsunited.com\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"Tripadvisor\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"Tripadvisor\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"TripAdvisor (Manual)\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"TripAdvisor (Manual)\", ${financials_v3.amount}))\n+ if(is_null(pivot_where(${reservations_v3.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${financials_v3.amount})),0,pivot_where(${reservations_v3.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${financials_v3.amount}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number}]
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
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: airbnb - financials_v3.amount,
            id: airbnb - financials_v3.amount, name: Airbnb}, {axisId: booking.com -
              financials_v3.amount, id: booking.com - financials_v3.amount, name: Booking.com},
          {axisId: direct - financials_v3.amount, id: direct - financials_v3.amount, name: Direct},
          {axisId: expedia - financials_v3.amount, id: expedia - financials_v3.amount, name: Expedia},
          {axisId: other - financials_v3.amount, id: other - financials_v3.amount, name: Other}],
        showLabels: true, showValues: true, valueFormat: '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Month
    series_types: {}
    series_labels:
      airbnb - reservations_v3.num_reservations: Airbnb
      booking.com - reservations_v3.num_reservations: Booking.com
      direct - reservations_v3.num_reservations: Direct
      expedia - reservations_v3.num_reservations: Expedia
      other - reservations_v3.num_reservations: Other
      airbnb - financials_v3.amount: Airbnb
      booking.com - financials_v3.amount: Booking.com
      direct - financials_v3.amount: Direct
      expedia - financials_v3.amount: Expedia
      other - financials_v3.amount: Other
    x_axis_datetime_label: "%b %Y"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [direct, airbnb, expedia, bookingcom, other]
    listen:
      bldg filter: complexes.title
    row: 38
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
      bldg filter: complexes.title
    row: 38
    col: 16
    width: 8
    height: 8
  - title: Occupancy
    name: Occupancy (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [reservations_v3.occupancy, complexes.title]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
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
      bldg filter: complexes.title
    row: 48
    col: 0
    width: 5
    height: 3
  - title: ADR
    name: ADR (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
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
      bldg filter: complexes.title
    row: 48
    col: 5
    width: 5
    height: 3
  - title: Occupancy by room type
    name: Occupancy by room type (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_column
    fields: [reservations_v3.occupancy, complexes.title, units.bedrooms]
    pivots: [complexes.title, units.bedrooms]
    filters:
      capacities_v3.night_month: next month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations_v3.occupancy,
            id: Whitley - 0 - reservations_v3.occupancy, name: Whitley - 0}, {axisId: reservations_v3.occupancy,
            id: Whitley - 1 - reservations_v3.occupancy, name: Whitley - 1}, {axisId: reservations_v3.occupancy,
            id: Whitley - 2 - reservations_v3.occupancy, name: Whitley - 2}], showLabels: true,
        showValues: true, maxValue: 1, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    hide_legend: false
    series_types: {}
    column_spacing_ratio: 0.5
    show_dropoff: false
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
    listen:
      bldg filter: complexes.title
    row: 48
    col: 15
    width: 9
    height: 5
  - title: RevPAR
    name: RevPAR (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.revpar]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
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
      bldg filter: complexes.title
    row: 48
    col: 10
    width: 5
    height: 3
  - title: ADR - 1BD
    name: ADR - 1BD (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      bldg filter: complexes.title
    row: 51
    col: 5
    width: 5
    height: 2
  - title: ADR - Studio
    name: ADR - Studio (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      bldg filter: complexes.title
    row: 51
    col: 0
    width: 5
    height: 2
  - title: ADR - 2BD
    name: ADR - 2BD (2)
    model: kasametrics_v3
    explore: capacities_v3
    type: single_value
    fields: [complexes.title, financials_v3.adr]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_month: next month
      reservations_v3.status_booked: 'Yes'
      financials_v3.types_filtered: 'Yes'
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
    listen:
      bldg filter: complexes.title
    row: 51
    col: 10
    width: 5
    height: 2
  - title: Room Nights Sold - Next Month
    name: Room Nights Sold - Next Month
    model: kasametrics_v3
    explore: capacities_v3
    type: looker_column
    fields: [capacities_v3.night_date, reservations_v3.reservation_night, capacities_v3.capacity,
      complexes.title]
    pivots: [complexes.title]
    filters:
      capacities_v3.night_date: next month
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_series: [Whitley - capacities_v3.capacity]
    series_types: {}
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
      bldg filter: complexes.title
    row: 53
    col: 0
    width: 24
    height: 7
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
      bldg filter: complexes.title
    row: 2
    col: 5
    width: 15
    height: 3
  filters:
  - name: bldg filter
    title: bldg filter
    type: field_filter
    default_value: DelRay
    allow_multiple_values: true
    required: false
    model: kasametrics_v3
    explore: capacities_v3
    listens_to_filters: []
    field: complexes.title
