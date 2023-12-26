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
    (gen_random_uuid(),  'ankit', 'ankit.shaw@email.com', 'hashed_password_789');
    (gen_random_uuid(),  'david', 'david@email.com', 'hashed_password_789');