CREATE DATABASE shiptivity;
USE shiptivity;
SOURCE shiptivity.dump;

-- before feature
SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2018-06-02" GROUP BY date ;

-- after feature
SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2019-02-02" GROUP BY date ;

-- average logins before feature
SELECT FLOOR(AVG(no_of_logins)) AS average_logins_before_feature FROM (SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2018-06-02" GROUP BY date ) AS login_counts;

-- average logins after feature
SELECT FLOOR(AVG(no_of_logins)) AS average_logins_after_feature FROM (SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2019-02-02" GROUP BY date ) AS login_counts;

-- combining both queries

SELECT 'Before Feature' AS period, FLOOR(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, 
           COUNT(*) AS no_of_logins 
    FROM login_history 
    WHERE DATE(FROM_UNIXTIME(login_timestamp)) BETWEEN '2018-02-03' AND '2018-06-02'
    GROUP BY date
) AS login_counts

UNION

SELECT 'After Feature' AS period, FLOOR(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, 
           COUNT(*) AS no_of_logins 
    FROM login_history 
    WHERE DATE(FROM_UNIXTIME(login_timestamp)) BETWEEN '2018-02-03' AND '2019-02-02'
    GROUP BY date
) AS login_counts;


-- card status change 
select count(*) as no_of_status_change from card_change_history where oldStatus != newStatus;

SELECT cardID, COUNT(*) AS num_status_changes FROM card_change_history where oldStatus != newStatus GROUP BY cardID ORDER BY cardID;

-- using sqlite

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

-- Combining both queries
SELECT 'Before Feature' AS period, FLOOR(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
    FROM login_history
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2018-06-02'
    GROUP BY date
)
UNION
SELECT 'After Feature' AS period, FLOOR(AVG(no_of_logins)) AS average_logins
FROM (
    SELECT strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) AS date, COUNT(*) AS no_of_logins
    FROM login_history
    WHERE strftime('%Y-%m-%d', datetime(login_timestamp, 'unixepoch')) BETWEEN '2018-02-03' AND '2019-02-02'
    GROUP BY date
);

-- Card Status Change
SELECT count(*) AS no_of_status_change FROM card_change_history WHERE oldStatus != newStatus;

SELECT cardID, COUNT(*) AS num_status_changes FROM card_change_history WHERE oldStatus != newStatus GROUP BY cardID ORDER BY cardID;
