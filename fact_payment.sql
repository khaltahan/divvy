CREATE EXTERNAL TABLE [dbo].[fact_payment] WITH(
    LOCATION = 'star/fact_payment',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        p.payment_id,
        p.amount AS payment_amount,
        p.date,
        YEAR(p.date) AS payment_year,
        DATEPART(QUARTER, p.date) AS payment_quarter,
        MONTH(p.date) AS payment_month,
        r.birthday,
        YEAR(GETDATE()) - YEAR(r.birthday) AS rider_age_at_account_start,
        r.is_member,
        r.account_start_date
    FROM staging_payment p
    JOIN dim_rider r ON p.rider_id = r.rider_id
);
