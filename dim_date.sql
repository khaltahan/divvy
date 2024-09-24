CREATE EXTERNAL TABLE [dbo].[dim_date] WITH(
    LOCATION = 'star/dim_date',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY CAST([date] AS DATE)) AS date_id,
        [date],
        DATEPART(DAY, CAST([date] AS DATE)) AS day,
        DATEPART(MONTH, CAST([date] AS DATE)) AS month,
        DATEPART(QUARTER, CAST([date] AS DATE)) AS quarter,
        DATEPART(YEAR, CAST([date] AS DATE)) AS year,
        DATEPART(DAYOFYEAR, CAST([date] AS DATE)) AS day_of_year,
        DATEPART(WEEKDAY, CAST([date] AS DATE)) AS day_of_week
    FROM staging_payment
);
