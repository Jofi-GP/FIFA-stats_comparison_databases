-- Using another dataset from Statsbomb to compare results with jfjetsul database
-- This StatsBomb database fragment only has fact events from 2018 onwards

USE world_cup_analytics;

SELECT 
    c.competition_name AS tournament,
    c.season as tournament_year,
    e.team,
    e.player,
    e.minute,
    e.shot_statsbomb_xg as expected_goal_difficulty,
    e.shot_outcome
FROM fact_events e
INNER JOIN dim_matches c 
    ON e.match_id = c.match_id
WHERE e.type = 'Shot' 
  AND e.minute >= 80 
  AND e.shot_outcome IN ('Goal', 'Post', 'Saved')
ORDER BY e.minute DESC;


SELECT 
    e.Team,
    COUNT(e.player) AS number_of_late_goals,
    ROUND(AVG(e.shot_statsbomb_xg), 2) AS avg_goal_difficulty,
    e.shot_outcome
FROM fact_events e
WHERE type = 'Shot' 
  AND minute >= 80 
  AND shot_outcome IN ('Goal')
group by e.team, e.shot_outcome
ORDER BY number_of_late_goals DESC;
