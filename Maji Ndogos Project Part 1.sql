-- Maji Ndog Water Project-Part1

-- Let Us See  The sources with Very Long Queue Times
-- We looked for visits where people waited more than 500 times (Over 8 hours):

SELECT *
	FROM visits
WHERE 
	time_in_queue > 500;

			-- We got that 105 water Sources had abnormally long waiting times
			-- This identifies potential bottlenecks in water access.

-- Checking Water Quality Scores / Invalid Revisits
-- Survey rules state that only shared taps should have multiple visits. We checked for perfect water scores (10) with more than one visit:

SELECT *
     FROM water_quality
WHERE 
	subjective_quality_score = 10
AND 
visit_count != 1;

				/* All of these sources scored 10 (excellent water) but were visited multiple times.
				This should not happen for high-quality sources like home taps.
                Finding:
				There are invalid revisit records, likely due to duplicate entries or surveyor errors.
                */
/* Checking for Dangerous Errors / Contamination Issues
Rule: If biological > 0.01, the water is contaminated.
Some wells were misclassified as “Clean” even though they had contamination. To check: */

SELECT *
FROM well_pollution
WHERE biological > 0.01
  AND results = 'Clean';
  
			/* Result: 64 wells marked as “Clean” despite contamination.
			Cause: Staff copied “Clean” from descriptions without checking the actual contamination measurements.
			*/

/* Let us Fix Mistakes Safely
Step 1: Create a copy of the table
*/
CREATE TABLE well_pollution_copy AS
SELECT * FROM well_pollution;

-- Step 2: Fix description errors

-- Turn off safe updates
SET SQL_SAFE_UPDATES = 0;

-- Run your updates
UPDATE well_pollution_copy
	SET description = 'Bacteria: E. coli'
WHERE 
	description = 'Clean Bacteria: E. coli';

UPDATE well_pollution_copy
	SET description = 'Bacteria: Giardia Lamblia'
WHERE 
	description = 'Clean Bacteria: Giardia Lamblia';

-- Turn safe updates back on
SET SQL_SAFE_UPDATES = 1;

-- Step 3: Correct classification based on biological contamination

-- Turn off safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Run your update
UPDATE well_pollution_copy
SET results = 'Contaminated: Biological'
WHERE biological > 0.01 AND results = 'Clean';

-- Turn safe update mode back on
SET SQL_SAFE_UPDATES = 1;

-- Step 4: Verify corrections
SELECT *
FROM well_pollution_copy
WHERE results = 'Contaminated: Biological'
;




	/* 	Summary of Part 1
		Understood water source types
		Found extreme queue times
		Detected invalid revisit data for home taps
		Found contamination classification errors
		Corrected issues safely in a copy of the table before applying to the real data
        */








