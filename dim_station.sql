CREATE EXTERNAL TABLE [dbo].[dim_station] WITH(
    LOCATION = 'star/dim_station',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        station_id,
        name,
        latitude,
        longitude
    FROM staging_station
);
