CREATE EXTERNAL TABLE [dbo].[dim_rider] WITH(
    LOCATION = 'star/dim_rider',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        CAST(rider_id AS bigint) AS rider_id,
        CONCAT(firstname, ' ', lastname) AS rider_name,
        birthday,
        account_start_id AS rider_join_date
    FROM staging_rider
);
