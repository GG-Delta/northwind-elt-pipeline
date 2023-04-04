FROM ghcr.io/dbt-labs/dbt-snowflake:1.4.1

COPY northwind/ .

COPY docker/run_commands.sh .

ENTRYPOINT ["/bin/bash", "run_commands.sh"]