CREATE EXTERNAL TABLE [dbo].[dim_station] WITH(
    LOCATION = 'star/dim_station',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        CAST(station_id AS bigint) AS station_id,
        name AS station_name,
        CONCAT(latitude, ',', longitude) AS station_location
    FROM staging_station
);
