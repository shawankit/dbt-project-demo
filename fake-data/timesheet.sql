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

INSERT INTO timesheets (timesheet_id, user_id, email, hours_worked, date_worked) VALUES
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'john_doe'), (SELECT email FROM users WHERE username = 'john_doe'), 8.00, '2020-01-01'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'john_doe'), (SELECT email FROM users WHERE username = 'john_doe'), 8.00, '2020-01-02'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'john_doe'), (SELECT email FROM users WHERE username = 'john_doe'), 8.00, '2020-01-03'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'jane_smith'), (SELECT email FROM users WHERE username = 'jane_smith'), 8.00, '2020-01-01'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'jane_smith'), (SELECT email FROM users WHERE username = 'jane_smith'), 8.00, '2020-01-02'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'jane_smith'), (SELECT email FROM users WHERE username = 'jane_smith'), 8.00, '2020-01-03'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'anna_jones'), (SELECT email FROM users WHERE username = 'anna_jones'), 8.00, '2020-01-01'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'anna_jones'), (SELECT email FROM users WHERE username = 'anna_jones'), 8.00, '2020-01-02'),
    (gen_random_uuid(), (SELECT user_id FROM users WHERE username = 'anna_jones'), (SELECT email FROM users WHERE username = 'anna_jones'), 8.00, '2020-01-03');

