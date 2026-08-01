USE world_cup_analytics;
SELECT 
    team,
    COUNT(CASE WHEN under_pressure = 1 THEN 1 END) as defensive_actions_under_pressure,
    COUNT(CASE WHEN counterpress = 1 THEN 1 END) as counterpress_triggers,
    COUNT(*) as total_late_actions
FROM fact_events
WHERE minute >= 75 AND type IN ('Pressure', 'Duel', 'Interception', 'Block')
GROUP BY team
ORDER BY defensive_actions_under_pressure DESC;