-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change


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


-- PART 2: Create a SQL query that indicates the number of status changes by card
select count(*) as no_of_status_change from card_change_history where old
Status != newStatus;

