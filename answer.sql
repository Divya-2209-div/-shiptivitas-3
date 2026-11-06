
-- PART 1: Average Daily Active Users Before and After Feature Release
-- Feature release date: 2018-06-02

WITH daily_active_users AS (
    SELECT
        DATE(login_timestamp, 'unixepoch') AS login_date,
        COUNT(DISTINCT user_id) AS daily_users
    FROM login_history
    GROUP BY DATE(login_timestamp, 'unixepoch')
)
SELECT
    CASE
        WHEN login_date < '2018-06-02' THEN 'Before Feature'
        ELSE 'After Feature'
    END AS feature_period,
    ROUND(AVG(daily_users), 2) AS average_daily_active_users
FROM daily_active_users
GROUP BY feature_period
ORDER BY feature_period;


-- PART 2: Number of Status Changes by Card

SELECT
    c.id AS card_id,
    c.name AS card_name,
    COUNT(*) AS number_of_status_changes
FROM card_change_history h
JOIN card c
    ON h.cardId = c.id
WHERE h.oldStatus IS NOT h.newStatus
GROUP BY c.id, c.name
ORDER BY number_of_status_changes DESC;
-- PART 3: Proposed Feature Improvements

-- IDEA 1: Activity History
-- Hypothesis: Users need to track changes made to cards.
-- Expected Impact: Better transparency and accountability.
-- Feature: Display a timeline of card status changes with timestamps.

-- IDEA 2: Smart Notifications
-- Hypothesis: Users may forget to follow up on cards that remain unchanged.
-- Expected Impact: Faster task completion.
-- Feature: Send notifications when cards remain in one status for too long.

-- IDEA 3: Workload Analytics
-- Hypothesis: Teams need to understand how work is distributed.
-- Expected Impact: Better workload management.
-- Feature: Show cards per status, completion times, and frequently moved cards.




