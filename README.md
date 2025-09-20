# Workflow Explanation – Part 1
Here’s what I did in this first part of the Maji Ndogo Water Project:
### 1.Understand the Data
First, I looked at the types of water sources in the dataset: rivers, wells, shared taps, home taps, and broken taps.
I noted which sources are generally safe versus which are high risk.
This step helped me know what “normal” data should look like.
### 2.Identify Anomalies in Queue Times
I checked for visits where people waited more than 8 hours (500 minutes).
This flagged water sources that may have access problems or data errors.
### 3.Check Water Quality Records for Invalid Revisits
I focused on records with perfect water quality scores (10) but multiple visits.
According to the survey rules, only shared taps should have multiple visits.
This step identified invalid or duplicated records in the database.
### 4.Detect Dangerous Data Errors
I looked at wells’ contamination data. The rule is: if biological > 0.01, the water is contaminated.
Some wells were mislabeled as “Clean,” so I needed to find these discrepancies.
### 5.Fix Errors Safely
Before changing the real table, I made a copy of the pollution table.
I corrected miswritten descriptions like “Clean Bacteria: E. coli” and “Clean Bacteria: Giardia Lamblia.”
Then I updated the contamination results based on the biological measurements.
Finally, I verified that the corrections worked.
### 6.Summarize Findings
I recorded all the issues I found: extreme queue times, invalid revisits, and contamination misclassifications.
This summary provides a clear picture of the current state of the water sources and sets up Part 2 for deeper analysis.
