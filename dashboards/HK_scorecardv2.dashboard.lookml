- dashboard: hk_scorecard_v2
  title: HK Scorecard V2
  layout: newspaper
  elements:
  - name: Summary Findings
    type: text
    title_text: Summary Findings
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Cleanings by Month
    type: text
    title_text: Cleanings by Month
    row: 20
    col: 0
    width: 24
    height: 2
  - name: Non-Filtered OKR Data
    type: text
    title_text: Non-Filtered OKR Data
    row: 67
    col: 0
    width: 24
    height: 2
  - title: Real time Check-in Reviews
    name: Real time Check-in Reviews
    model: kasametrics_v2
    explore: capacities_rolled
    type: table
    fields: [reviews.submitdate_date, reviews.privatereviewtext, complexes.title,
      reservations.confirmationcode, reviews.target, units.internaltitle, reservations.checkindate,
      reservations.checkoutdate, complexes.city, reviews.Rating, reservations.source]
    filters:
      reviews.submitdate_date: 1 months
      reviews.target: cleaning
    sorts: [reviews.privatereviewtext]
    limit: 500
    total: true
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
    defaults_version: 1
    listen: {}
    row: 61
    col: 0
    width: 24
    height: 6
  - name: Real-time Check-in
    type: text
    title_text: Real-time Check-in
    row: 59
    col: 0
    width: 24
    height: 2
  - name: Housekeeping % On Time Cleans - Past Month - WIP (Pending BW API integration)
    title: Housekeeping % On Time Cleans - Past Month - WIP (Pending BW API integration)
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [hk_scorecard.HK, hk_scorecard.pct_on_time, hk_scorecard.pct_day_of_checkout,
      hk_scorecard.pct_before_checkin, hk_scorecard.counted_cleans, hk_scorecard.date_cleaned_month]
    pivots: [hk_scorecard.date_cleaned_month]
    fill_fields: [hk_scorecard.date_cleaned_month]
    filters:
      hk_scorecard.HK: "-NULL"
      hk_scorecard.date_cleaned_month: 1 months
    sorts: [hk_scorecard.pct_on_time desc 0, hk_scorecard.date_cleaned_month desc]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
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
    series_column_widths:
      hk_scorecard.pct_on_time: 310
      hk_scorecard.pct_before_checkin: 332
      hk_scorecard.counted_cleans: 182
      hk_scorecard.HK: 295
      hk_scorecard.pct_day_of_checkout: 340
    series_cell_visualizations:
      hk_scorecard.pct_on_time:
        is_active: true
      hk_scorecard.pct_before_checkin:
        is_active: true
      hk_scorecard.pct_day_of_checkout:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          custom: {id: 9c84abfe-85c6-ba96-ec4d-97471285df9a, label: Custom, type: continuous,
            stops: [{color: "#e65956", offset: 0}, {color: "#fab5b5", offset: 25},
              {color: "#ffffff", offset: 50}, {color: "#58d4d6", offset: 75}, {color: "#0b9dbf",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: minimum},
              mid: {type: middle}, max: {type: maximum}}, mirror: false, reverse: false,
            stepped: false}}, bold: false, italic: false, strikethrough: false, fields: []}]
    series_value_format:
      hk_scorecard.pct_on_time:
        name: percent_0
        format_string: "#,##0%"
        label: Percent (0)
      hk_scorecard.pct_before_checkin:
        name: percent_0
        format_string: "#,##0%"
        label: Percent (0)
      hk_scorecard.pct_day_of_checkout:
        name: percent_0
        format_string: "#,##0%"
        label: Percent (0)
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
    hidden_fields: []
    listen: {}
    row: 31
    col: 0
    width: 24
    height: 6
  - name: Housekeeping Cleanliness Rating - OUTDATED (Pending BW API Integration)
    title: Housekeeping Cleanliness Rating - OUTDATED (Pending BW API Integration)
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [staffs.HK_name, airbnb_reviews.cleanliness_rating, airbnb_reviews.review_month,
      airbnb_reviews.count]
    pivots: [airbnb_reviews.review_month]
    fill_fields: [airbnb_reviews.review_month]
    filters:
      staffs.HK_name: "-Kasa System,-NULL"
      airbnb_reviews.review_month: 6 months
    sorts: [airbnb_reviews.review_month 0, staffs.HK_name]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
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
    series_labels:
      airbnb_reviews.review_month: Month
      staffs.HK_name: HouseKeeper
      airbnb_reviews.cleanliness_rating: Cleanliness Rating
    series_cell_visualizations:
      airbnb_reviews.cleanliness_rating:
        is_active: false
    series_text_format:
      airbnb_reviews.cleanliness_rating: {}
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
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 37
    col: 0
    width: 12
    height: 9
  - title: HK Cleaning Score by Building - OUTDATED (Pending BW API Integration)
    name: HK Cleaning Score by Building - OUTDATED (Pending BW API Integration)
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [hk_scorecard.HK, complexes.title, airbnb_reviews.cleanliness_rating,
      airbnb_reviews.review_month, airbnb_reviews.count]
    pivots: [airbnb_reviews.review_month]
    fill_fields: [airbnb_reviews.review_month]
    filters:
      hk_scorecard.HK: "-NULL"
      airbnb_reviews.review_month: 6 months
    sorts: [airbnb_reviews.review_month desc 0, hk_scorecard.HK]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
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
    series_labels:
      airbnb_reviews.count: Reviews
    series_cell_visualizations:
      airbnb_reviews.cleanliness_rating:
        is_active: false
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 46
    col: 0
    width: 24
    height: 7
  - name: "% $ of Cleaning Refunds"
    title: "% $ of Cleaning Refunds"
    model: kasametrics_v2
    explore: capacities_rolled
    type: table
    fields: [financials.transaction_month, financials.cleaning_refund_transactions,
      financials.clean_refund_amount, financials.cleaning_transactions, financials.cleaning_amount]
    filters:
      financials.transaction_date: after 2020/06/01
      financials.cleaning_refund_transactions: ">0"
    sorts: [financials.transaction_month desc]
    limit: 500
    dynamic_fields: [{table_calculation: refunds_to_do_hk_issues, label: Refunds to
          do HK Issues, expression: "${financials.cleaning_refund_transactions}/${financials.cleaning_transactions}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: refunded, label: "% $ Refunded",
        expression: "-${financials.clean_refund_amount} / ${financials.cleaning_amount}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
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
    defaults_version: 1
    hidden_fields: [financials.cleaning_refund_transactions, financials.cleaning_transactions,
      refunds_to_do_hk_issues]
    row: 37
    col: 12
    width: 12
    height: 9
  - title: CleanRefunded by Building
    name: CleanRefunded by Building
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [financials.transaction_month, complexes.title, financials.clean_refund_amount]
    pivots: [financials.transaction_month]
    fill_fields: [financials.transaction_month]
    filters:
      financials.transaction_date: 6 months
    sorts: [financials.transaction_month desc 0, complexes.title]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      financials.clean_refund_amount:
        is_active: false
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
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 53
    col: 0
    width: 12
    height: 6
  - title: CleanRefund $/Reservation by Building
    name: CleanRefund $/Reservation by Building
    model: kasametrics_v2
    explore: capacities_rolled
    type: looker_grid
    fields: [complexes.title, financials.clean_refund_amount, reservations.num_reservations,
      financials.transaction_month]
    pivots: [financials.transaction_month]
    fill_fields: [financials.transaction_month]
    filters:
      financials.transaction_date: 6 months
    sorts: [financials.transaction_month desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: res, label: "$/Res", expression: "${financials.clean_refund_amount}/${reservations.num_reservations}",
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      financials.clean_refund_amount:
        is_active: false
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
    defaults_version: 1
    series_types: {}
    hidden_fields: [financials.clean_refund_amount]
    listen: {}
    row: 53
    col: 12
    width: 12
    height: 6
  - title: "\U0001f44d"
    name: "\U0001f44d"
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [reviews.submitdate_date, reviews.privatereviewtext, complexes.title,
      reservations.confirmationcode, reviews.target, units.internaltitle, reservations.checkindate,
      reservations.checkoutdate, complexes.city, reviews.Rating, reservations.source]
    filters:
      reviews.target: cleaning
    sorts: [reviews.privatereviewtext]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: thumbs_up, label: "% thumbs up", expression: 'sum(if(${reviews.Rating}=10,1,0))
          / count(${reviews.Rating})', value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}]
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
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    series_types: {}
    hidden_fields: [reviews.Rating]
    listen:
      Review Submit Date: reviews.submitdate_date
    row: 2
    col: 11
    width: 4
    height: 6
  - title: Number of Cleans
    name: Number of Cleans
    model: Breezeway
    explore: breezeway_export
    type: single_value
    fields: [breezeway_export.count, breezeway_export.assigned_date_week]
    fill_fields: [breezeway_export.assigned_date_week]
    filters:
      breezeway_export.type: Cleaning
      breezeway_export.done_on_time_: On Time,Late
    sorts: [breezeway_export.assigned_date_week desc]
    limit: 500
    dynamic_fields: [{table_calculation: sum, label: sum, expression: 'sum(${breezeway_export.count})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Week
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
    defaults_version: 1
    series_types: {}
    hidden_fields: [breezeway_export.count]
    listen:
      BW Assigned Date: breezeway_export.assigned_date_date
    row: 2
    col: 17
    width: 4
    height: 6
  - title: Total Cleans per Housekeeper - Last Month (WIP - Names to be updated)
    name: Total Cleans per Housekeeper - Last Month (WIP - Names to be updated)
    model: Breezeway
    explore: breezeway_export
    type: looker_grid
    fields: [breezeway_export.completed_by, breezeway_export.count]
    filters:
      breezeway_export.type: Cleaning
      breezeway_export.done_on_time_: On Time,Late
    sorts: [breezeway_export.count desc]
    limit: 500
    total: true
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
    column_order: ["$$$_row_numbers_$$$", breezeway_export.completed_by, breezeway_export.average_completion,
      breezeway_export.count]
    show_totals: true
    show_row_totals: true
    series_labels:
      breezeway_export.count: Number of Cleans
      breezeway_export.average_completion: Average Time (Hours)
    series_cell_visualizations:
      breezeway_export.average_completion:
        is_active: true
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
    listen:
      BW Assigned Date: breezeway_export.assigned_date_date
    row: 22
    col: 12
    width: 12
    height: 9
  - title: Average Cleaning Time - Last Month (WIP - Names to be updated)
    name: Average Cleaning Time - Last Month (WIP - Names to be updated)
    model: Breezeway
    explore: breezeway_export
    type: looker_grid
    fields: [breezeway_export.completed_by, breezeway_export.average_completion, breezeway_export.count]
    filters:
      breezeway_export.type: Cleaning
    sorts: [breezeway_export.average_completion desc]
    limit: 500
    total: true
    filter_expression: "(${breezeway_export.completion_time_mins} > 30 AND ${breezeway_export.completion_time_mins}\
      \ < 240)"
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
    column_order: ["$$$_row_numbers_$$$", breezeway_export.completed_by, breezeway_export.average_completion,
      breezeway_export.count]
    show_totals: true
    show_row_totals: true
    series_labels:
      breezeway_export.count: Number of Cleans
      breezeway_export.average_completion: Average Time (Hours)
    series_cell_visualizations:
      breezeway_export.average_completion:
        is_active: true
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
    hidden_fields:
    listen:
      BW Assigned Date: breezeway_export.assigned_date_date
    row: 22
    col: 0
    width: 12
    height: 9
  - title: BW Tasks on Time
    name: BW Tasks on Time
    model: Breezeway
    explore: breezeway_export
    type: single_value
    fields: [breezeway_export.assigned_date_date, breezeway_export.pct_on_time, breezeway_export.done_on_time,
      breezeway_export.count]
    fill_fields: [breezeway_export.assigned_date_date]
    filters:
      breezeway_export.type: Cleaning
    sorts: [breezeway_export.assigned_date_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: data_available, label: data available, expression: 'if(${breezeway_export.done_on_time}
          = 0, no,yes)', value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: yesno}, {table_calculation: done_on_time_, label: done_on_time_%,
        expression: 'sum(${breezeway_export.done_on_time}) / sum(if(${data_available}=yes,${breezeway_export.count},0))',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Week
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
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
    defaults_version: 1
    series_types: {}
    hidden_fields: [breezeway_export.done_on_time, breezeway_export.count, data_available,
      breezeway_export.pct_on_time]
    hidden_points_if_no:
    listen:
      BW Assigned Date: breezeway_export.assigned_date_date
    row: 2
    col: 5
    width: 4
    height: 6
  - title: Avg Cleaning Score
    name: Avg Cleaning Score
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [airbnb_reviews.cleanliness_rating, airbnb_reviews.review_month]
    fill_fields: [airbnb_reviews.review_month]
    filters: {}
    sorts: [airbnb_reviews.review_month desc]
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
    value_format: ''
    series_types: {}
    defaults_version: 1
    listen:
      Reviews Review Date: airbnb_reviews.review_date
    row: 14
    col: 5
    width: 6
    height: 6
  - title: Bad Cleans (<4)
    name: Bad Cleans (<4)
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [airbnb_reviews.review_month, airbnb_reviews.count, airbnb_reviews.count_less_than_4_star]
    fill_fields: [airbnb_reviews.review_month]
    filters: {}
    sorts: [airbnb_reviews.review_month desc]
    limit: 500
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${airbnb_reviews.count_less_than_4_star}\
          \ / ${airbnb_reviews.count}", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, _type_hint: number}]
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
    value_format: ''
    series_types: {}
    defaults_version: 1
    hidden_fields: [airbnb_reviews.count, airbnb_reviews.count_less_than_4_star]
    listen:
      Reviews Review Date: airbnb_reviews.review_date
    row: 14
    col: 15
    width: 6
    height: 6
  - title: "% Refunded"
    name: "% Refunded"
    model: kasametrics_v2
    explore: capacities_rolled
    type: single_value
    fields: [financials.transaction_month, financials.cleaning_refund_transactions,
      financials.clean_refund_amount, financials.cleaning_transactions, financials.cleaning_amount]
    fill_fields: [financials.transaction_month]
    filters: {}
    sorts: [financials.transaction_month desc]
    limit: 500
    dynamic_fields: [{table_calculation: transactions_refunded, label: "% Transactions\
          \ Refunded", expression: "${financials.cleaning_refund_transactions}/${financials.cleaning_transactions}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: refunded, label: "% $ Refunded",
        expression: "-${financials.clean_refund_amount} / ${financials.cleaning_amount}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
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
    value_format: ''
    series_types: {}
    defaults_version: 1
    hidden_fields: [financials.cleaning_refund_transactions, financials.cleaning_transactions,
      financials.clean_refund_amount, financials.cleaning_amount, transactions_refunded]
    listen:
      Transaction Date: financials.transaction_date
    row: 8
    col: 9
    width: 8
    height: 6
  filters:

  - name: Review Submit Date
    title: Review Submit Date
    type: field_filter
    default_value: 1 months
    allow_multiple_values: true
    required: false
    model: kasametrics_v2
    explore: capacities_rolled
    listens_to_filters: []
    field: reviews.submitdate_date
  - name: Reviews Review Date
    title: Reviews Review Date
    type: field_filter
    default_value: 1 months
    allow_multiple_values: true
    required: false
    model: kasametrics_v2
    explore: capacities_rolled
    listens_to_filters: []
    field: airbnb_reviews.review_date
  - name: Transaction Date
    title: Transaction Date
    type: field_filter
    default_value: 1 months
    allow_multiple_values: true
    required: false
    model: kasametrics_v2
    explore: capacities_rolled
    listens_to_filters: []
    field: financials.transaction_date
