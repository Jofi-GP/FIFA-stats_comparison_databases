USE fifa_historical_analytics;

SELECT 
   tou.tournament_name,
   tou.`year`,
   g.match_period,
   t.team_name,
   p.family_name,
   p.given_name,
   g.minute_label
FROM goals g
LEFT JOIN players p ON g.player_id = p.player_id
LEFT JOIN teams t ON g.team_id = t.team_id
LEFT JOIN tournaments tou ON g.tournament_id = tou.tournament_id
WHERE g.minute_label >= 80
AND tou.tournament_name NOT LIKE "%Women's%"
ORDER BY g.minute_label DESC;


SELECT 
    t.team_name,
    COUNT(DISTINCT tou.`year`) AS distinct_tournaments,
    COUNT(g.minute_label) AS number_of_late_goals
FROM goals g
LEFT JOIN teams t ON g.team_id = t.team_id
LEFT JOIN tournaments tou ON g.tournament_id = tou.tournament_id
WHERE g.minute_label >= 80
AND tou.tournament_name NOT LIKE "%Women's%"
group by t.team_name 
ORDER BY number_of_late_goals DESC;
