USE world_cup_analytics;

WITH team_stages AS (
    -- Capture every team's appearance in a Quarter-final match
    SELECT 
        season AS tournament_year,
        home_team AS team,
        competition_stage AS stage
    FROM dim_matches
    WHERE competition_stage IN ('Quarter-finals', 'Semi-finals', 'Final')
    
    UNION ALL
    
    SELECT 
        season AS tournament_year,
        away_team AS team,
        competition_stage AS stage
    FROM dim_matches
    WHERE competition_stage IN ('Quarter-finals', 'Semi-finals', 'Final')
)
SELECT 
    team,
    COUNT(DISTINCT CASE WHEN stage = 'Quarter-finals' THEN tournament_year END) AS quarter_final_appearances,
    COUNT(DISTINCT CASE WHEN stage = 'Semi-finals' THEN tournament_year END) AS semi_final_appearances,
    COUNT(DISTINCT CASE WHEN stage = 'Final' THEN tournament_year END) AS final_appearances,
    -- Combined metric for high-pressure experience
    (COUNT(DISTINCT CASE WHEN stage = 'Quarter-finals' THEN tournament_year END) +
     COUNT(DISTINCT CASE WHEN stage = 'Semi-finals' THEN tournament_year END) +
     COUNT(DISTINCT CASE WHEN stage = 'Final' THEN tournament_year END)) AS total_deep_runs
FROM team_stages
GROUP BY team
ORDER BY total_deep_runs DESC, team ASC;

