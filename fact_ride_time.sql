CREATE EXTERNAL TABLE [dbo].[fact_ride_time] WITH(
    LOCATION = 'star/fact_ride_time',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        t.trip_id,
        t.start_at AS start_time,
        t.ended_at AS end_time,
        DATEDIFF(MINUTE, t.start_at, t.ended_at) AS trip_duration,
        t.start_station_id,
        t.end_station_id,
        YEAR(d.date) - YEAR(r.birthday) AS rider_age_at_trip,
        r.is_member,
        d.date_id,
        d.day_of_week,
        DATEPART(HOUR, t.start_at) AS start_hour_of_day,
        s.name AS start_station_name,
        e.name AS end_station_name
    FROM staging_trip t
    JOIN dim_rider r ON t.rider_id = r.rider_id
    JOIN dim_station s ON t.start_station_id = s.station_id
    JOIN dim_station e ON t.end_station_id = e.station_id
    JOIN dim_date d ON CAST(t.start_at AS DATE) = d.date
);
