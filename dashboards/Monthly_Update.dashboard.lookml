- dashboard: august_2020_monthly_financial_review
  title: August 2020 Monthly Financial Review
  layout: newspaper
  elements:
  - title: August 2020 Occupancy
    name: August 2020 Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_month: 2020/08/01 to 2020/09/01
      reservations.status_booked: 'Yes'
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
    row: 5
    col: 0
    width: 8
    height: 3
  - title: August 2020 ADR
    name: August 2020 ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 5
    col: 8
    width: 8
    height: 3
  - title: August 2020 RevPar
    name: August 2020 RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 5
    col: 16
    width: 8
    height: 3
  - title: August 2020 RevPAR by Property
    name: August 2020 RevPAR by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [complexes.title, financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      complexes.title: "-Strata"
    sorts: [financials.revpar desc]
    limit: 500
    column_limit: 50
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
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: '100'}]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      capacities_rolled.capacity_measure:
        is_active: false
      reservations.occupancy:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    listen: {}
    row: 19
    col: 0
    width: 24
    height: 6
  - title: Lead Time Trends by Stay Date
    name: Lead Time Trends by Stay Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_lead_time, reservations.median_lead_time, capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.status_booked: 'Yes'
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
    sorts: [capacities_rolled.night_month desc]
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
      palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
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
    listen: {}
    row: 64
    col: 0
    width: 8
    height: 6
  - title: LOS Trends by Stay Date
    name: LOS Trends by Stay Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_length_of_stay, reservations.median_length_of_stay,
      capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month desc]
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
      palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
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
    listen: {}
    row: 64
    col: 8
    width: 8
    height: 6
  - title: Channel Segmentation Trends T12M - % of Revenue
    name: Channel Segmentation Trends T12M - % of Revenue
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [financials.amount, reservations.source, capacities_rolled.night_month]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 12 months
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.amount desc 0, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${financials.amount}/${financials.amount:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    hidden_series: []
    series_types: {}
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
    hidden_fields: [financials.amount]
    listen: {}
    row: 57
    col: 16
    width: 8
    height: 5
  - title: T12M Metrics by Month
    name: T12M Metrics by Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_line
    fields: [financials.revpar, capacities_rolled.night_month, financials.adr, reservations.occupancy]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      capacities_rolled.night_month: 2019/08/01 to 2020/09/01
    sorts: [capacities_rolled.night_month]
    limit: 500
    column_limit: 50
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        maxValue: 0.9, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: financials.revpar,
            id: financials.revpar, name: RevPar}, {axisId: financials.adr, id: financials.adr,
            name: ADR}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      financials.revpar: "#FBB555"
      reservations.occupancy: "#592EC2"
    series_point_styles:
      reservations.occupancy: triangle-down
      financials.adr: diamond
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
    row: 33
    col: 0
    width: 24
    height: 7
  - title: Ancillary Revenue
    name: Ancillary Revenue
    model: kasametrics_v2
    explore: capacities_rolled
    type: table
    fields: [financials.type, capacities_rolled.night_month, financials.amount]
    pivots: [capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/03/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [financials.type, capacities_rolled.night_month 0]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
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
    stacking: ''
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
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen: {}
    row: 72
    col: 16
    width: 8
    height: 4
  - title: August 2019 Occupancy
    name: August 2019 Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_month: 2019/07/01 to 2019/08/01
      reservations.status_booked: 'Yes'
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
    row: 8
    col: 0
    width: 8
    height: 3
  - title: August 2019 ADR
    name: August 2019 ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr]
    filters:
      capacities_rolled.night_date: 2019/07/01 to 2019/08/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 8
    col: 8
    width: 8
    height: 3
  - title: August 2019 RevPar
    name: August 2019 RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar]
    filters:
      capacities_rolled.night_date: 2019/07/01 to 2019/08/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 8
    col: 16
    width: 8
    height: 3
  - title: August vs July Pick Up by Stay Month
    name: August vs July Pick Up by Stay Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.reservation_night, capacities_rolled.night_month, reservations.bookingdate_month]
    pivots: [reservations.bookingdate_month]
    fill_fields: [capacities_rolled.night_month, reservations.bookingdate_month]
    filters:
      reservations.bookingdate_date:  to 2020/09/01
      capacities_rolled.night_month: after 2020/07/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month]
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    series_column_widths:
      capacities_rolled.night_month: 124
    listen: {}
    row: 40
    col: 0
    width: 24
    height: 5
  - title: Channel Segmentation Trends - % of Revenue
    name: Channel Segmentation Trends - % of Revenue
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [financials.amount, capacities_rolled.night_month, reservations.source]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [capacities_rolled.night_month 0, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: of_revenue, label: "% of Revenue", expression: "${financials.amount}/${financials.amount:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
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
    header_font_size: 12
    rows_font_size: 12
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    series_types: {}
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [financials.amount]
    hidden_series: [reservations.platform___null - calculation_1, bookingCom - calculation_1,
      Manual (Extension) - calculation_1, Manual (extension) - calculation_1, Manual-comp'ed
        - calculation_1, Maunal Extension - calculation_1, Manual-Repeat Guest - calculation_1,
      Manual (Email) - calculation_1, Manual (ex Booking) - calculation_1, Booking.com
        - Manual - calculation_1, reservations.source___null - calculation_1]
    listen: {}
    row: 52
    col: 8
    width: 8
    height: 5
  - title: 2020 RevPAR by Property
    name: 2020 RevPAR by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [complexes.title, financials.revpar, capacities_rolled.night_month]
    pivots: [capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
      complexes.title: "-2222Smith,-Aperture,-Astor,-AvenueR,-Boathouse,-CadenceSF,-Centerra,-Cortesian,-Elan,-Franklin,-Goldtex,-Linq,-Luxor,-Madrone,-Marin,-Moreland,-Nine15,-PearlWDL,-Pearlmkt,-Peninsula,-Stella"
    sorts: [capacities_rolled.night_month, complexes.title 0]
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
    series_types: {}
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
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    column_order: []
    listen: {}
    row: 64
    col: 16
    width: 8
    height: 8
  - title: June 2020 Occupancy
    name: June 2020 Occupancy
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reservations.occupancy]
    filters:
      capacities_rolled.night_month: 2020/07/01 to 2020/08/01
      reservations.status_booked: 'Yes'
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
    col: 0
    width: 8
    height: 3
  - title: June 2020 ADR
    name: June 2020 ADR
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.adr]
    filters:
      capacities_rolled.night_date: 2020/07/01 to 2020/08/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 2
    col: 8
    width: 8
    height: 3
  - title: June 2020 RevPar
    name: June 2020 RevPar
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.revpar]
    filters:
      capacities_rolled.night_date: 2020/07/01 to 2020/08/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
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
    listen: {}
    row: 2
    col: 16
    width: 8
    height: 3
  - title: Channel Segmentation Trends - % of Room Nights
    name: Channel Segmentation Trends - % of Room Nights
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [capacities_rolled.night_month, reservations.source, reservations.reservation_night]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [capacities_rolled.night_month 0, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: of_rooms_nights, label: "% of Rooms Nights",
        expression: "${reservations.reservation_night}/${reservations.reservation_night:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
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
    header_font_size: 12
    rows_font_size: 12
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    series_types: {}
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [reservations.reservation_night]
    hidden_series: [reservations.platform___null - calculation_1, bookingCom - calculation_1,
      Manual (Extension) - calculation_1, Manual (extension) - calculation_1, Manual-comp'ed
        - calculation_1, Maunal Extension - calculation_1, Manual-Repeat Guest - calculation_1,
      Manual (Email) - calculation_1, Manual (ex Booking) - calculation_1, Booking.com
        - Manual - calculation_1, reservations.source___null - calculation_1]
    listen: {}
    row: 57
    col: 0
    width: 8
    height: 5
  - title: Channel Segmentation Trends - % of Reservations
    name: Channel Segmentation Trends - % of Reservations
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [capacities_rolled.night_month, reservations.source, reservations.num_reservations]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 2020/01/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
    sorts: [capacities_rolled.night_month 0, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: of_reservations, label: "% of Reservations",
        expression: "${reservations.num_reservations}/${reservations.num_reservations:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
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
    header_font_size: 12
    rows_font_size: 12
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    series_types: {}
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [reservations.num_reservations]
    hidden_series: [reservations.platform___null - calculation_1, bookingCom - calculation_1,
      Manual (Extension) - calculation_1, Manual (extension) - calculation_1, Manual-comp'ed
        - calculation_1, Maunal Extension - calculation_1, Manual-Repeat Guest - calculation_1,
      Manual (Email) - calculation_1, Manual (ex Booking) - calculation_1, Booking.com
        - Manual - calculation_1, reservations.source___null - calculation_1]
    listen: {}
    row: 52
    col: 0
    width: 8
    height: 5
  - title: August vs July Cancellations by Stay Month
    name: August vs July Cancellations by Stay Month
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.reservation_night, capacities_rolled.night_month, reservations.cancellationdate_month]
    pivots: [reservations.cancellationdate_month]
    fill_fields: [capacities_rolled.night_month, reservations.cancellationdate_month]
    filters:
      reservations.cancellationdate_month: 2020/07/01 to 2020/09/01
      capacities_rolled.night_month: after 2020/07/01
      financials.types_filtered: 'Yes'
      reservations.status: canceled
    sorts: [capacities_rolled.night_month]
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
    point_style: circle_outline
    show_value_labels: false
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
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
    series_types: {}
    series_colors:
      reservations.reservation_night: "#B1399E"
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
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    series_column_widths:
      capacities_rolled.night_month: 124
    listen: {}
    row: 45
    col: 0
    width: 24
    height: 5
  - title: Lead Time Trends by Booking Date
    name: Lead Time Trends by Booking Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_lead_time, reservations.median_lead_time, reservations.bookingdate_month]
    fill_fields: [reservations.bookingdate_month]
    filters:
      reservations.status_booked: 'Yes'
      reservations.bookingdate_month: 2020/01/01 to 2020/09/01
    sorts: [reservations.bookingdate_month desc]
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
      palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
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
    listen: {}
    row: 70
    col: 0
    width: 8
    height: 6
  - title: LOS Trends by Booking Date
    name: LOS Trends by Booking Date
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [reservations.avg_length_of_stay, reservations.median_length_of_stay,
      reservations.bookingdate_month]
    fill_fields: [reservations.bookingdate_month]
    filters:
      reservations.bookingdate_month: 2020/01/01 to 2020/09/01
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
      palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: reservations.occupancy,
            id: reservations.occupancy, name: Occupancy}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 30, type: linear}]
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
    listen: {}
    row: 70
    col: 8
    width: 8
    height: 6
  - title: August 2020 Occupancy by Property
    name: August 2020 Occupancy by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [complexes.title, reservations.occupancy]
    filters:
      capacities_rolled.night_date: 2020/08/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      complexes.title: "-Strata"
    sorts: [reservations.occupancy desc]
    limit: 500
    column_limit: 50
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
    series_colors:
      reservations.occupancy: "#4276BE"
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: ".7"}]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      capacities_rolled.capacity_measure:
        is_active: false
      reservations.occupancy:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    listen: {}
    row: 13
    col: 0
    width: 24
    height: 6
  - title: Channel Segmentation Trends - % of Revenue - July Bookings
    name: Channel Segmentation Trends - % of Revenue - July Bookings
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [financials.amount, capacities_rolled.night_month, reservations.source]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      reservations.bookingdate_date: 2020/08/01 to 2020/09/01
      capacities_rolled.night_month: 2020/08/01 to 2021/01/01
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [capacities_rolled.night_month, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: of_revenue, label: "% of Revenue", expression: "${financials.amount}/${financials.amount:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
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
    header_font_size: 12
    rows_font_size: 12
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    series_types: {}
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [financials.amount]
    hidden_series: [reservations.platform___null - calculation_1, bookingCom - calculation_1,
      Manual (Extension) - calculation_1, Manual (extension) - calculation_1, Manual-comp'ed
        - calculation_1, Maunal Extension - calculation_1, Manual-Repeat Guest - calculation_1,
      Manual (Email) - calculation_1, Manual (ex Booking) - calculation_1, Booking.com
        - Manual - calculation_1, reservations.source___null - calculation_1]
    listen: {}
    row: 57
    col: 8
    width: 8
    height: 5
  - name: Monthly Metrics
    type: text
    title_text: Monthly Metrics
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Portfolio Performance Charts
    type: text
    title_text: Portfolio Performance Charts
    row: 11
    col: 0
    width: 24
    height: 2
  - name: LOS Trends
    type: text
    title_text: LOS Trends
    row: 62
    col: 0
    width: 16
    height: 2
  - name: Channel Segmentation Trends
    type: text
    title_text: Channel Segmentation Trends
    row: 50
    col: 0
    width: 24
    height: 2
  - title: Channel Segmentation Trends - % of Revenue
    name: Channel Segmentation Trends - % of Revenue (2)
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [financials.amount, reservations.source, capacities_rolled.night_month]
    pivots: [reservations.source]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_month: 6 months
      financials.types_filtered: 'Yes'
      reservations.status_booked: 'Yes'
    sorts: [financials.amount desc 0, reservations.source]
    limit: 500
    row_total: right
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${financials.amount}/${financials.amount:row_total}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle_outline
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: airbnb - calculation_1,
            id: airbnb - calculation_1, name: airbnb}, {axisId: airbnb2 - calculation_1,
            id: airbnb2 - calculation_1, name: airbnb2}, {axisId: manual - calculation_1,
            id: manual - calculation_1, name: manual}, {axisId: rentalsUnited - calculation_1,
            id: rentalsUnited - calculation_1, name: rentalsUnited}, {axisId: reservations.platform___null
              - calculation_1, id: reservations.platform___null - calculation_1, name: "∅"}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    hidden_series: []
    series_types: {}
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
    hidden_fields: [financials.amount]
    listen: {}
    row: 52
    col: 16
    width: 8
    height: 5
  - title: July vs August 2020 RevPAR by Property
    name: July vs August 2020 RevPAR by Property
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_column
    fields: [complexes.title, financials.revpar, capacities_rolled.night_month]
    pivots: [capacities_rolled.night_month]
    fill_fields: [capacities_rolled.night_month]
    filters:
      capacities_rolled.night_date: 2020/07/01 to 2020/09/01
      reservations.status_booked: 'Yes'
      financials.types_filtered: 'Yes'
      complexes.title: "-Strata"
    sorts: [capacities_rolled.night_month 0, mom_variance desc 1]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: mom_variance, label: MoM Variance %, expression: "(${financials.revpar}\
          \ / pivot_offset(${financials.revpar}, -1)) - 1", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
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
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: '100'}]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
      capacities_rolled.capacity_measure:
        is_active: false
      reservations.occupancy:
        is_active: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [financials.revpar]
    listen: {}
    row: 25
    col: 0
    width: 24
    height: 8
  - name: Misc
    type: text
    title_text: Misc.
    row: 62
    col: 16
    width: 8
    height: 2
