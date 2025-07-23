/*
Creating a table that stores the location and amount of a food item.
*/
CREATE TABLE Location (
Location_ID int NOT NULL AUTO_INCREMENT,
Food_Storage varchar(13) NOT NULL,
FName varchar(20) NOT NULL UNIQUE,
Quantity int NOT NULL,
Entry_Date Date NOT NULL,
Expiration_Date Date, -- This can be null. Spices for example do not expire.
CHECK (Quantity > 0 ),
PRIMARY KEY (Location_ID),
FOREIGN KEY (FName) REFERENCES Food (Fname)
);

/*
Sample data for the table.
*/
INSERT INTO Location (Food_Storage, FName, Quantity, Entry_Date, Expiration_Date) VALUES
('Pantry',         'Canned Beans',   10, '2025-07-15', '2026-01-15'),
('Fridge',         'Milk',            2, '2025-07-21', '2025-07-28'),
('Freezer',        'Frozen Peas',     5, '2025-07-01', '2026-01-01'),
('Spice Rack',     'Cumin',           1, '2025-06-10', NULL),
('Fridge',         'Eggs',           12, '2025-07-20', '2025-08-05'),
('Cellar',         'Potatoes',        8, '2025-07-10', '2025-08-10'),
('Pantry',         'Pasta',           3, '2025-07-18', '2026-07-18'),
('Freezer',        'Ice Cream',       4, '2025-07-12', '2025-12-12'),
('Fridge',         'Yogurt',          6, '2025-07-19', '2025-07-25'),
('Spice Rack',     'Paprika',         2, '2025-05-01', NULL);


/*
We might consider having storage act as a foreign key to a separate table.
It can prevent errors with typos and such.
We might want to have some kind of unit that represents quantity instead.
Though, we can generally understand 1 of something in regards to food
so that is more of a preference than anything
*/