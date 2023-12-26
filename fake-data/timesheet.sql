CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (user_id, username, email, password) VALUES
    (gen_random_uuid(), 'john_doe', 'john.doe@email.com', 'hashed_password_123'),
    (gen_random_uuid(),  'jane_smith', 'jane.smith@email.com', 'hashed_password_456'),
    (gen_random_uuid(),  'anna_jones', 'anna.jones@email.com', 'hashed_password_789');


CREATE TABLE timesheets (
    timesheet_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    email VARCHAR(100) NOT NULL,
    hours_worked DECIMAL(10, 2) NOT NULL,
    date_worked DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

DO $$ 
DECLARE 
    start_date DATE := '2024-01-01';
    end_date DATE := '2024-12-31';
    user_row RECORD;
    date_row DATE;
BEGIN
    FOR user_row IN SELECT user_id, email FROM users
    LOOP
        FOR date_row IN SELECT generate_series(start_date, end_date, '1 day'::interval)::date AS date_worked
        LOOP
            INSERT INTO timesheets (timesheet_id,user_id, email, hours_worked, date_worked)
            VALUES (gen_random_uuid(), user_row.user_id, user_row.email, random() * 8 + 1, date_row);
        END LOOP;
    END LOOP;
END $$;
