USE fifa_historical_analytics;

SELECT hc.*, t.team_name
FROM host_countries AS hc
INNER JOIN teams AS t
  ON hc.team_id = t.team_id;


SELECT
    t.team_name,
    COUNT(DISTINCT ta.tournament_id) AS team_total_appearances,
    COUNT(DISTINCT hc.tournament_id) AS Hosting_times
FROM teams t
LEFT JOIN team_appearances ta 
    ON t.team_id = ta.team_id
LEFT JOIN host_countries hc 
    ON t.team_id = hc.team_id 
   AND ta.tournament_id = hc.tournament_id
GROUP BY t.team_name
ORDER BY hosting_times DESC, team_total_appearances DESC;



