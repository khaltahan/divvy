CREATE EXTERNAL TABLE [dbo].[dim_rider] WITH(
    LOCATION = 'star/dim_rider',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        CAST(rider_id AS bigint) AS rider_id,
        firstname AS first_name,
        lastname AS last_name,
        address,
        birthday,
        account_start_id AS account_start_date,
        account_end_id AS account_end_date,
        is_member
    FROM staging_rider
);
