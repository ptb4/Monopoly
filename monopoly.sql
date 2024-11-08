-- Drop previous versions of the tables if they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS BoardPosition;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
    ID integer PRIMARY KEY,
    time timestamp
);

CREATE TABLE Player (
    ID integer PRIMARY KEY,
    emailAddress varchar(50) NOT NULL,
    name varchar(50)
);

CREATE TABLE Property (
    ID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    cost integer,
    rent integer,
    houseCost integer,
    hotelCost integer
);

CREATE TABLE BoardPosition (
    ID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    propertyID integer REFERENCES Property(ID),
    type varchar(20) -- e.g., "Property", "Chance", "Community Chest", "Go", "Jail"
);

CREATE TABLE PlayerGame (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    score integer,
    cash integer,
    currentPosition integer REFERENCES BoardPosition(ID)
);

CREATE TABLE PlayerProperty (
    playerID integer REFERENCES Player(ID),
    propertyID integer REFERENCES Property(ID),
    gameID integer REFERENCES Game(ID),
    numHouses integer,
    numHotels integer,
    PRIMARY KEY(playerID, propertyID, gameID)
);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON BoardPosition TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO Property VALUES (1, 'Park Place', 350, 50, 200, 500);
INSERT INTO Property VALUES (2, 'Boardwalk', 400, 75, 250, 600);

INSERT INTO BoardPosition VALUES (1, 'Go', NULL, 'Special');
INSERT INTO BoardPosition VALUES (2, 'Park Place', 1, 'Property');
INSERT INTO BoardPosition VALUES (3, 'Boardwalk', 2, 'Property');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 100.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

INSERT INTO PlayerProperty VALUES (1, 1, 1, 2, 0);
INSERT INTO PlayerProperty VALUES (2, 2, 1, 1, 1);

