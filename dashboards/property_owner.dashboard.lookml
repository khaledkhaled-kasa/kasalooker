- dashboard: property_owner_dashboard
  title: Property Owner Dashboard
  layout: newspaper
  elements:
  - name: Key Metrics
    type: text
    title_text: Key Metrics
    row: 2
    col: 0
    width: 24
    height: 2
  - name: Last Month Occupancy
    title: Last Month Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_month]
    filters:
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
    value_format: 0%
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Property Selection: complexes.title
      Current Month: capacities_rolled.night_date
    row: 4
    col: 0
    width: 8
    height: 2
  - name: Last Month ADR
    title: Last Month ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr, capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    column_limit: 50
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
    value_format: "$0"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_null_points: true
    interpolation: linear
    hidden_fields:
    listen:
      Property Selection: complexes.title
      Current Month: capacities_rolled.night_date
    row: 4
    col: 8
    width: 8
    height: 2
  - name: Last Month RevPar
    title: Last Month RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar, complexes.title, capacities_rolled.night_month]
    filters:
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
    limit: 500
    column_limit: 50
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
    value_format: "$0"
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: financials.revpar, id: financials.revpar,
            name: RevPar}], showLabels: true, showValues: true, maxValue: 160, minValue: 0,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 23, type: linear}]
    series_types: {}
    series_colors:
      financials.revpar: "#3EB0D5"
    reference_lines: []
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    map_latitude: 38.16911413556086
    map_longitude: -26.850585937500004
    map_zoom: 4
    listen:
      Property Selection: complexes.title
      Current Month: capacities_rolled.night_date
    row: 4
    col: 16
    width: 8
    height: 2
  - name: Weekly Key Metrics
    type: text
    title_text: Weekly Key Metrics
    row: 21
    col: 0
    width: 24
    height: 2
  - name: Weekly RevPar
    title: Weekly RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [capacities_rolled.night_week, complexes.title, financials.revpar]
    filters:
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_week desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: financials.revpar, id: financials.revpar,
            name: RevPar}], showLabels: true, showValues: true, maxValue: 160, minValue: 0,
        valueFormat: "$0", unpinAxis: false, tickDensity: custom, tickDensityCustom: 23,
        type: linear}]
    x_axis_label: Date
    label_value_format: "$0"
    series_types: {}
    series_colors:
      financials.revpar: "#3EB0D5"
    x_axis_datetime_label: ''
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    map_latitude: 38.16911413556086
    map_longitude: -26.850585937500004
    map_zoom: 4
    hidden_fields: [complexes.title]
    listen:
      Property Selection: complexes.title
      Trailing 12 Weeks: capacities_rolled.night_date
    row: 23
    col: 16
    width: 8
    height: 7
  - name: Weekly Occupancy
    title: Weekly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [capacities_rolled.night_week, reservations.occupancy, complexes.title]
    filters:
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_week desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        valueFormat: 0%, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    x_axis_datetime_label: ''
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
    defaults_version: 1
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [complexes.title]
    listen:
      Property Selection: complexes.title
      Trailing 12 Weeks: capacities_rolled.night_date
    row: 23
    col: 8
    width: 8
    height: 7
  - name: Weekly ADR
    title: Weekly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [financials.adr, capacities_rolled.night_week]
    fill_fields: [capacities_rolled.night_week]
    filters:
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_week desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: financials.adr, id: financials.adr,
            name: ADR}], showLabels: true, showValues: true, valueFormat: "$0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: "$0"
    series_types: {}
    x_axis_datetime_label: ''
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    listen:
      Property Selection: complexes.title
      Trailing 12 Weeks: capacities_rolled.night_date
    row: 23
    col: 0
    width: 8
    height: 7
  - name: Monthly Key Metrics
    type: text
    title_text: Monthly Key Metrics
    row: 6
    col: 0
    width: 24
    height: 2
  - name: Monthly ADR
    title: Monthly ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [financials.adr, capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: financials.adr, id: financials.adr,
            name: ADR}], showLabels: true, showValues: true, valueFormat: "$0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: "$0"
    series_types: {}
    x_axis_datetime_label: "%b %Y"
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    listen:
      Property Selection: complexes.title
      Trailing 6 Months: capacities_rolled.night_date
    row: 8
    col: 8
    width: 8
    height: 7
  - name: Monthly Occupancy
    title: Monthly Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_month]
    filters:
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        valueFormat: 0%, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    x_axis_datetime_label: "%b %Y"
    show_null_points: true
    interpolation: linear
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
    defaults_version: 1
    hidden_fields: [complexes.title]
    listen:
      Property Selection: complexes.title
      Trailing 6 Months: capacities_rolled.night_date
    row: 8
    col: 0
    width: 8
    height: 7
  - name: Monthly RevPar
    title: Monthly RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [complexes.title, financials.revpar, capacities_rolled.night_month]
    filters:
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
    show_x_axis_label: false
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: financials.revpar, id: financials.revpar,
            name: RevPar}], showLabels: true, showValues: true, maxValue: 160, minValue: 0,
        valueFormat: "$0", unpinAxis: false, tickDensity: custom, tickDensityCustom: 23,
        type: linear}]
    x_axis_label: Date
    label_value_format: "$0"
    series_types: {}
    series_colors:
      financials.revpar: "#3EB0D5"
    x_axis_datetime_label: "%b %Y"
    reference_lines: []
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    defaults_version: 1
    map_latitude: 38.16911413556086
    map_longitude: -26.850585937500004
    map_zoom: 4
    hidden_fields: [complexes.title]
    listen:
      Property Selection: complexes.title
      Trailing 6 Months: capacities_rolled.night_date
    row: 8
    col: 16
    width: 8
    height: 7
  - name: <img src="https://uploadspoachedjobscom/wp-content/uploads/2020/05/28072024/logo-768x205jpg"
      width="200"/>
    type: text
    title_text: <img src="https://uploads.poachedjobs.com/wp-content/uploads/2020/05/28072024/logo-768x205.jpg"
      width="200"/>
    row: 0
    col: 0
    width: 4
    height: 2
  - name: Channel Breakdown
    type: text
    title_text: Channel Breakdown
    row: 42
    col: 0
    width: 24
    height: 2
  - name: Bookings
    title: Bookings
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [capacities_rolled.night_month, reservations.num_reservations, reservations.source]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc, reservations.source]
    limit: 500
    dynamic_fields: [{table_calculation: direct, label: Direct, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Landlord\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Landlord\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"MANUAL\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"MANUAL\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"manual\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"manual\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Comp'd)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Comp'd)\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Email)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Email)\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (ex Booking)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual (ex Booking)\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Extension)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Extension)\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (extension)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual (extension)\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual A\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual A\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual New\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual New\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual-comp'ed\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual-comp'ed\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual-Repeat Guest\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual-Repeat Guest\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual Extension\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual Extension\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual extension\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Manual extension\", ${reservations.num_reservations})) \n+  if(is_null(pivot_where(${reservations.source}\
          \ = \"Roman's Friend\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Roman's Friend\", ${reservations.num_reservations})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"website\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"website\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Website\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Website\", ${reservations.num_reservations}))\n\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: airbnb, label: Airbnb, expression: "\nif(is_null(pivot_where(${reservations.source}\
          \ = \"airbnb\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"airbnb\", ${reservations.num_reservations})) + if(is_null(pivot_where(${reservations.source}\
          \ = \"Airbnb\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Airbnb\", ${reservations.num_reservations})) + if(is_null(pivot_where(${reservations.source}\
          \ = \"airbnb2\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"airbnb2\", ${reservations.num_reservations}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: expedia, label: Expedia, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Expedia\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Expedia\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Expedia (Manually)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Expedia (Manually)\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"HomeAway\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"HomeAway\", ${reservations.num_reservations}))\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: bookingcom, label: Booking.com, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Booking.com\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Booking.com\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Booking.com - Manual\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Booking.com - Manual\", ${reservations.num_reservations}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: other, label: Other, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Disregard - Test\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Disregard - Test\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"googlesc@rentalsunited.com\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"googlesc@rentalsunited.com\", ${reservations.num_reservations}))\n\
          + if(is_null(pivot_where(${reservations.source} = \"Tripadvisor\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"Tripadvisor\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"TripAdvisor (Manual)\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"TripAdvisor (Manual)\", ${reservations.num_reservations}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${reservations.num_reservations})),0,pivot_where(${reservations.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${reservations.num_reservations}))",
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
      airbnb - reservations.num_reservations: Airbnb
      booking.com - reservations.num_reservations: Booking.com
      direct - reservations.num_reservations: Direct
      expedia - reservations.num_reservations: Expedia
      other - reservations.num_reservations: Other
    x_axis_datetime_label: "%b %Y"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [direct, airbnb, expedia, bookingcom, other]
    listen:
      Property Selection: complexes.title
      Trailing 6 Months: capacities_rolled.night_date
    row: 44
    col: 0
    width: 12
    height: 10
  - name: "% of Total Revenue"
    title: "% of Total Revenue"
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [capacities_rolled.night_month, reservations.source, financials.amount]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.status_booked: 'Yes'
    sorts: [reservations.source 0, capacities_rolled.night_month desc]
    limit: 500
    dynamic_fields: [{table_calculation: direct, label: Direct, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Landlord\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Landlord\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"MANUAL\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"MANUAL\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"manual\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"manual\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Comp'd)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Comp'd)\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Email)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Email)\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (ex Booking)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual (ex Booking)\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (Extension)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual (Extension)\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual (extension)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual (extension)\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual A\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual A\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual New\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual New\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual-comp'ed\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual-comp'ed\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual-Repeat Guest\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual-Repeat Guest\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual Extension\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual Extension\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Manual extension\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Manual extension\", ${financials.amount})) \n+  if(is_null(pivot_where(${reservations.source}\
          \ = \"Roman's Friend\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Roman's Friend\", ${financials.amount})) \n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"website\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"website\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Website\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Website\", ${financials.amount}))\n\n", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, _type_hint: number}, {table_calculation: airbnb,
        label: Airbnb, expression: 'if(is_null(pivot_where(${reservations.source}
          = "airbnb", ${financials.amount})),0,pivot_where(${reservations.source}
          = "airbnb", ${financials.amount})) + if(is_null(pivot_where(${reservations.source}
          = "Airbnb", ${financials.amount})),0,pivot_where(${reservations.source}
          = "Airbnb", ${financials.amount})) + if(is_null(pivot_where(${reservations.source}
          = "airbnb2", ${financials.amount})),0,pivot_where(${reservations.source}
          = "airbnb2", ${financials.amount}))', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, _type_hint: number}, {table_calculation: expedia,
        label: Expedia, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Expedia\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Expedia\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Expedia (Manually)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Expedia (Manually)\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"HomeAway\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"HomeAway\", ${financials.amount}))\n\n", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: bookingcom, label: Booking.com, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Booking.com\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Booking.com\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Booking.com - Manual\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Booking.com - Manual\", ${financials.amount}))", value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: other, label: Other, expression: "if(is_null(pivot_where(${reservations.source}\
          \ = \"Disregard - Test\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Disregard - Test\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"googlesc@rentalsunited.com\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"googlesc@rentalsunited.com\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"Tripadvisor\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"Tripadvisor\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"TripAdvisor (Manual)\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"TripAdvisor (Manual)\", ${financials.amount}))\n+ if(is_null(pivot_where(${reservations.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${financials.amount})),0,pivot_where(${reservations.source}\
          \ = \"tripadvisor2way@rentalsunited.com\", ${financials.amount}))", value_format: !!null '',
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
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: airbnb - financials.amount,
            id: airbnb - financials.amount, name: Airbnb}, {axisId: booking.com -
              financials.amount, id: booking.com - financials.amount, name: Booking.com},
          {axisId: direct - financials.amount, id: direct - financials.amount, name: Direct},
          {axisId: expedia - financials.amount, id: expedia - financials.amount, name: Expedia},
          {axisId: other - financials.amount, id: other - financials.amount, name: Other}],
        showLabels: true, showValues: true, valueFormat: '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Month
    series_types: {}
    series_labels:
      airbnb - reservations.num_reservations: Airbnb
      booking.com - reservations.num_reservations: Booking.com
      direct - reservations.num_reservations: Direct
      expedia - reservations.num_reservations: Expedia
      other - reservations.num_reservations: Other
      airbnb - financials.amount: Airbnb
      booking.com - financials.amount: Booking.com
      direct - financials.amount: Direct
      expedia - financials.amount: Expedia
      other - financials.amount: Other
    x_axis_datetime_label: "%b %Y"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [direct, airbnb, expedia, bookingcom, other]
    listen:
      Property Selection: complexes.title
      Trailing 6 Months: capacities_rolled.night_date
    row: 44
    col: 12
    width: 12
    height: 10
  - name: Next 30 Days
    type: text
    title_text: Next 30 Days
    row: 30
    col: 0
    width: 24
    height: 2
  - name: Next 30 Day Occupancy as of Start of Month
    title: Next 30 Day Occupancy as of Start of Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_area
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_date]
    filters:
      reservations.bookingdate_date: before 0 months ago
      capacities_rolled.night_date: after 0 months ago
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_date]
    limit: 30
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        maxValue: 1, minValue: 0, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#000000", value_format: 0%}]
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
    hidden_fields: [complexes.title]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    listen:
      Property Selection: complexes.title
    row: 32
    col: 0
    width: 12
    height: 8
  - name: Next 30 Day Occupancy as of Start of Last Month
    title: Next 30 Day Occupancy as of Start of Last Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_area
    fields: [reservations.occupancy, complexes.title, capacities_rolled.night_date]
    filters:
      reservations.bookingdate_date: before 1 months ago
      capacities_rolled.night_date: after 1 months ago
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_date]
    limit: 30
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        maxValue: 1, minValue: 0, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#000000", value_format: 0%}]
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
    hidden_fields: [complexes.title]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    listen:
      Property Selection: complexes.title
    row: 32
    col: 12
    width: 12
    height: 8
  - name: Next 30 Day Booked ADR as of Start of this Month
    title: Next 30 Day Booked ADR as of Start of this Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    filters:
      reservations.bookingdate_date: before 0 months ago
      reservations.status_booked: 'Yes'
    sorts: [financials.adr desc]
    limit: 30
    column_limit: 50
    filter_expression: "${capacities_rolled.night_date} >= add_days(-5,now()) AND ${capacities_rolled.night_date}\
      \ < add_days(25,now())"
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
    value_format: "$0"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        maxValue: 1, minValue: 0, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#000000", value_format: 0%}]
    defaults_version: 1
    hidden_fields: [complexes.title]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    listen:
      Property Selection: complexes.title
    row: 40
    col: 0
    width: 12
    height: 2
  - name: Next 30 Day Booked ADR as of Start of Last Month
    title: Next 30 Day Booked ADR as of Start of Last Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [complexes.title, financials.adr]
    filters:
      reservations.bookingdate_date: before 1 months ago
      reservations.status_booked: 'Yes'
    sorts: [financials.adr desc]
    limit: 30
    column_limit: 50
    filter_expression: "${capacities_rolled.night_date} >= add_days(-35,now()) AND ${capacities_rolled.night_date}\
      \ < add_days(-5,now())"
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
    value_format: "$0"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        maxValue: 1, minValue: 0, valueFormat: 0%, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Date
    label_value_format: 0%
    series_types: {}
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#000000", value_format: 0%}]
    defaults_version: 1
    hidden_fields: [complexes.title]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    ordering: none
    show_null_labels: false
    listen:
      Property Selection: complexes.title
    row: 40
    col: 12
    width: 12
    height: 2
  - name: Length of Stay by Booking Date
    title: Length of Stay by Booking Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_length_of_stay, reservations.median_length_of_stay,
      reservations.bookingdate_month]
    fill_fields: [reservations.bookingdate_month]
    filters:
      reservations.status_booked: 'Yes'
    sorts: [reservations.bookingdate_month desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: Days, orientation: left, series: [{axisId: reservations.avg_length_of_stay,
            id: reservations.avg_length_of_stay, name: Avg Length of Stay}, {axisId: reservations.median_length_of_stay,
            id: reservations.median_length_of_stay, name: Median Length of Stay}],
        showLabels: true, showValues: true, valueFormat: '0', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    label_value_format: '0'
    series_types:
      reservations.median_lead_time: scatter
      reservations.median_length_of_stay: scatter
    show_null_points: true
    interpolation: linear
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
      Property Selection: complexes.title
      Trailing 6 Months: reservations.bookingdate_month
    row: 15
    col: 12
    width: 12
    height: 6
  - name: Lead Time by Booking Date
    title: Lead Time by Booking Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_lead_time, reservations.median_lead_time, reservations.bookingdate_month]
    fill_fields: [reservations.bookingdate_month]
    filters:
      reservations.status_booked: 'Yes'
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    y_axes: [{label: Days, orientation: left, series: [{axisId: reservations.avg_lead_time,
            id: reservations.avg_lead_time, name: Avg Lead Time}, {axisId: reservations.median_lead_time,
            id: reservations.median_lead_time, name: Median Lead Time}], showLabels: true,
        showValues: true, valueFormat: '0', unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    label_value_format: '0'
    series_types:
      reservations.median_lead_time: scatter
    show_null_points: true
    interpolation: linear
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
      Property Selection: complexes.title
      Trailing 6 Months: reservations.bookingdate_month
    row: 15
    col: 0
    width: 12
    height: 6
  filters:
  - name: Property Selection
    title: Property Selection
    type: field_filter
    default_value: Legacy
    allow_multiple_values: true
    required: false
    model: kasametrics_v2
    explore: capacities_rolled
    listens_to_filters: []
    field: complexes.title
  - name: Current Month
    title: Current Month
    type: date_filter
    default_value: 1 months ago for 1 months
    allow_multiple_values: true
    required: false
  - name: Trailing 6 Months
    title: Trailing 6 Months
    type: date_filter
    default_value: 6 months ago for 6 months
    allow_multiple_values: true
    required: false
  - name: Trailing 12 Weeks
    title: Trailing 12 Weeks
    type: date_filter
    default_value: 12 weeks ago for 12 weeks
    allow_multiple_values: true
    required: false
