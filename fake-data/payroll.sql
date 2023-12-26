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

DO $$
BEGIN
    FOR user_row IN SELECT user_id, email FROM users
        LOOP
           INSERT INTO paychecks (user_id, email, amount, created_at)
              VALUES (user_row.user_id, user_row.email, random() * 1000 + 1, CURRENT_TIMESTAMP);
        END LOOP;
END $$;