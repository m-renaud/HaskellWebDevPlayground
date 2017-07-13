CREATE TABLE "playground_user"(
       id BIGSERIAL PRIMARY KEY,
       firstname text,
       lastname text
);

INSERT INTO "playground_user" ("id", "firstname", "lastname")
VALUES(DEFAULT, 'Matt', 'Renaud');

INSERT INTO "playground_user" ("id", "firstname", "lastname")
VALUES(DEFAULT, 'Tom', 'Law');

INSERT INTO "playground_user" ("id", "firstname", "lastname")
VALUES(DEFAULT, 'Evan', 'Jones');
