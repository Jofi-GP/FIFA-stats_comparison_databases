-- transform the flat database from JSON import into a SQL readable table relationship

USE world_cup_analytics;

-- Step 1: Assign Primary Keys to Dimensions
ALTER TABLE dim_competitions 
ADD PRIMARY KEY (competition_id, season_id);

ALTER TABLE dim_matches 
ADD PRIMARY KEY (match_id);

-- Step 2: Assign Primary Key to Fact Table 
ALTER TABLE fact_events 
MODIFY id VARCHAR(255),
ADD PRIMARY KEY (id);

-- Step 3: Enforce Foreign Key Constraints
ALTER TABLE dim_matches
ADD CONSTRAINT fk_matches_competitions
FOREIGN KEY (competition_id, season_id) 
REFERENCES dim_competitions(competition_id, season_id);

ALTER TABLE fact_events
ADD CONSTRAINT fk_events_matches
FOREIGN KEY (match_id) 
REFERENCES dim_matches(match_id);
