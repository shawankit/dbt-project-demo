CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email, password) VALUES
    ('john_doe', 'john.doe@email.com', 'hashed_password_123'),
    ('jane_smith', 'jane.smith@email.com', 'hashed_password_456'),
    ('bob_jones', 'bob.jones@email.com', 'hashed_password_789');




-- Path: fake-data/payroll.sql

CREATE TABLE paychecks (
    paycheck_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO paychecks (user_id, email, amount) VALUES
    (1, (SELECT email FROM users WHERE username = 'john_doe'), 1000.00),
    (1, (SELECT email FROM users WHERE username = 'john_doe'), 1000.00),
    (1, (SELECT email FROM users WHERE username = 'john_doe'), 1000.00),
    (2, (SELECT email FROM users WHERE username = 'jane_smith'), 2000.00),
    (2, (SELECT email FROM users WHERE username = 'jane_smith'), 2000.00),
    (2, (SELECT email FROM users WHERE username = 'jane_smith'), 2000.00),
    (3, (SELECT email FROM users WHERE username = 'bob_jones'), 3000.00),
    (3, (SELECT email FROM users WHERE username = 'bob_jones'), 3000.00),
    (3, (SELECT email FROM users WHERE username = 'bob_jones'), 3000.00);