-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;
DROP VIEW IF EXISTS Standings CASCADE;

CREATE TABLE Players (
                     id_p SERIAL PRIMARY KEY,
                     name TEXT not null,
                     time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                      );

CREATE TABLE Matches (
                      id_m SERIAL PRIMARY KEY,
                      winner INTEGER REFERENCES Players(id_p),
                      loser INTEGER REFERENCES Players(id_p),
                      time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    );

CREATE VIEW Standings AS
SELECT id_p as id, name,
(SELECT count(*) FROM Matches AS m WHERE m.winner = p.id_p) AS wins,
(SELECT count(*) FROM Matches AS m WHERE m.winner = p.id_p OR m.loser = p.id_p) AS matches
FROM Players p
--GROUP BY p.id_p
ORDER BY wins DESC;
