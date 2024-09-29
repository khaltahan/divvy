CREATE EXTERNAL TABLE [dbo].[fact_payment] WITH(
    LOCATION = 'star/fact_payment',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        CAST(p.payment_id AS bigint) AS payment_id,
        p.amount,
        p.rider_id,
        d.date_id AS payment_date
    FROM staging_payment p
    JOIN dim_date d ON CAST(p.date AS DATE) = d.date
);
