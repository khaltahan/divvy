-- Extra Credit: Rides per Month and Ride Duration
CREATE EXTERNAL TABLE [dbo].[fact_member_activity] WITH(
    LOCATION = 'star/fact_member_activity',
    DATA_SOURCE = [azure_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        r.rider_id,
        YEAR(t.start_at) AS ride_year,
        MONTH(t.start_at) AS ride_month,
        COUNT(t.trip_id) AS total_rides_per_month,
        SUM(DATEDIFF(MINUTE, t.start_at, t.ended_at)) AS total_ride_duration_minutes_per_month,
        p.amount AS total_money_spent_per_month
    FROM staging_trip t
    JOIN dim_rider r ON t.rider_id = r.rider_id
    JOIN dim_payment p ON r.rider_id = p.rider_id
    GROUP BY r.rider_id, YEAR(t.start_at), MONTH(t.start_at), p.amount
);
