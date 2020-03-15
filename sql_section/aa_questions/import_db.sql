PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
    users (fname, lname)
VALUES
    ('NICK','MARTINOVIC'),
    ('ERIN','ODWYER'),
    ('ICHIRO','SUZUKI');

INSERT INTO
    questions (title, body, user_id)
VALUES
    ('password reset?','Can you reset my password?',(SELECT id FROM users WHERE fname = 'ERIN')),
    ('Japanese?','Is this course available in Japanese?',(SELECT id FROM users WHERE fname = 'ICHIRO')),
    ('OOP?','How does OOP work?',(SELECT id FROM users WHERE fname = 'NICK'));

INSERT INTO
    replies (body, user_id, question_id)
VALUES 
    ("You should email them", 1, 1);

INSERT INTO
    replies (body, parent_id, user_id, question_id)
VALUES 
    ("What is the email?", 1,2, 1),
    ("Sorry! it is support@aaonline.io",2,1,1);

INSERT INTO 
    question_follows (question_id, user_id)
VALUES
    (2,1),
    (2,2);

INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (3,1),
    (1,1),
    (2,2),
    (1,3),
    (2,3),
    (3,3);