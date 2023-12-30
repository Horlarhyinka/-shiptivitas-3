-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

-- Using strftime for date formatting


-- Before Feature
SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
FROM login_history
WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2018-06-02'
GROUP BY date;

-- After Feature
SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
FROM login_history
WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2019-02-02'
GROUP BY date;

-- Average Logins Before Feature
SELECT FLOOR(AVG(no_of_logins)) AS average_logins_before_feature
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
    FROM login_history
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2018-06-02'
    GROUP BY date
);

-- Average Logins After Feature
SELECT FLOOR(AVG(no_of_logins)) AS average_logins_after_feature
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
    FROM login_history
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2019-02-02'
    GROUP BY date
);

-- combining before and after

SELECT 'Before Feature' AS period, ROUND(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, 
           COUNT(*) AS no_of_logins 
    FROM login_history 
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2018-06-02'
    GROUP BY date
) AS login_counts

UNION

SELECT 'After Feature' AS period, ROUND(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, 
           COUNT(*) AS no_of_logins 
    FROM login_history 
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2019-02-02'
    GROUP BY date
) AS login_counts;


-- PART 2: Create a SQL query that indicates the number of status changes by card
SELECT count(*) AS no_of_status_change
FROM card_change_history
WHERE oldStatus != newStatus;

SELECT cardID, COUNT(*) AS num_status_changes
FROM card_change_history
WHERE oldStatus != newStatus
GROUP BY cardID
ORDER BY cardID;