-- A
SELECT name,
    role
FROM users;
-- B
SELECT name,
    FROM users
WHERE role = 'admin';
-- show: A) names and roles of all users, B) only names of users whose role is "manager"
-- filter condition: A) none, B) only rows where role is "admin"
-- result size: A) as many rows as in the users table, B) only the rows where role is "amdin"