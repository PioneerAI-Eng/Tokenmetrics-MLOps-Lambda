{% set max_request_timestamp_query %}
    SELECT MAX(last_processed_request_timestamp) AS val
    FROM {{ ref('dbt_processes') }}
    LIMIT 1
{% endset %}
{% set results = run_query(max_request_timestamp_query) %}

{% if execute %}
    {% set last_processed_request_timestamp = results[0][0] %}
{% else %}
    {% set last_processed_request_timestamp = '' %}
{% endif %}

{{
    select_logs(
        from_date=last_processed_request_timestamp,
        to_date=env_var('DBT_STAGE_1_MAX_DATE')
    )
}}
