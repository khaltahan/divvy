CREATE EXTERNAL TABLE [dbo].[fact_trip] WITH(
    LOCATION = 'star/fact_trip',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        CAST(t.trip_id AS bigint) AS trip_id,
        DATEDIFF(MINUTE, t.start_at, t.ended_at) AS trip_duration,
        t.rider_id,
        t.start_station_id AS station_id,
        YEAR(d.date) - YEAR(r.birthday) AS rider_age,
        d.date_id AS trip_date
    FROM staging_trip t
    JOIN rider_dim r ON t.rider_id = r.rider_id
    JOIN date_dim d ON CAST(t.start_at AS DATE) = d.date
);
