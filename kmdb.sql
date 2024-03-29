-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released, CHECK
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.  CHECK   (Filter Movie Table for Studio)
-- - As a guest, I want to see each movie's cast including each actor's        CHECK   (Filter Roles Table by Movie)
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.   CHECK    (Filter Roles Table by Actor)
-- * Note: The "guest" user role represents the experience prior to logging-in      
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.

.mode column
.headers off

Drop table if exists movies;
Drop table if exists actors;
Drop table if exists studios;
drop table if exists roles;

create table movies (
    id integer primary key autoincrement,
    title text,
    release_year text,
    MPAA_rating text,
    studio_id integer
);

create table studios (
    id integer primary key autoincrement,
    studio_name text
    );

create table roles (
    id integer primary key autoincrement,
    character_name text,
    movie_id integer,
    actor_id integer
);

create table actors (
    id integer primary key autoincrement,
    first_name text,
    last_name text
);

insert into studios (studio_name)
values ("Warner Bros"),
("Disney"),
("20 Century Fox");

select * from studios;

-- Insert actor names into the actors table
INSERT INTO actors (first_name, last_name)
VALUES 
  ('Christian', 'Bale'),
  ('Michael', 'Caine'),
  ('Liam', 'Neeson'),
  ('Katie', 'Holmes'),
  ('Gary', 'Oldman'),
  ('Heath', 'Ledger'),
  ('Aaron', 'Eckhart'),
  ('Maggie', 'Gyllenhaal'),
  ('Tom', 'Hardy'),
  ('Joseph', 'Gordon-Levitt'),
  ('Anne', 'Hathaway');

  select * from actors;

insert into movies (title, release_year, MPAA_rating, studio_id)
values ('Batman Begins', '2005', 'PG-13', (SELECT id FROM studios WHERE studio_name = 'Warner Bros')),
('The Dark Knight', '2008', 'PG-13', (SELECT id FROM studios WHERE studio_name = 'Warner Bros')),
('The Dark Knight Rises', '2012', 'PG-13', (SELECT id FROM studios WHERE studio_name = 'Warner Bros'));

select * from movies;

insert into roles (character_name, movie_id, actor_id)
values  
  ('Bruce Wayne', (SELECT id FROM movies WHERE title = 'Batman Begins'), (SELECT id FROM actors WHERE first_name = 'Christian' AND last_name = 'Bale')),
  ('Alfred', (SELECT id FROM movies WHERE title = 'Batman Begins'), (SELECT id FROM actors WHERE first_name = 'Michael' AND last_name = 'Caine')),
  ('Rachel Dawes', (SELECT id FROM movies WHERE title = 'Batman Begins'), (SELECT id FROM actors WHERE first_name = 'Katie' AND last_name = 'Holmes')),
  ('Commissioner Gordon', (SELECT id FROM movies WHERE title = 'Batman Begins'), (SELECT id FROM actors WHERE first_name = 'Gary' AND last_name = 'Oldman')),
  ('Bruce Wayne', (SELECT id FROM movies WHERE title = 'The Dark Knight'), (SELECT id FROM actors WHERE first_name = 'Christian' AND last_name = 'Bale')),
  ('Joker', (SELECT id FROM movies WHERE title = 'The Dark Knight'), (SELECT id FROM actors WHERE first_name = 'Heath' AND last_name = 'Ledger')),
  ('Harvey Dent', (SELECT id FROM movies WHERE title = 'The Dark Knight'), (SELECT id FROM actors WHERE first_name = 'Aaron' AND last_name = 'Eckhart')),
  ('Alfred', (SELECT id FROM movies WHERE title = 'The Dark Knight'), (SELECT id FROM actors WHERE first_name = 'Michael' AND last_name = 'Caine')),
  ('Rachel Dawes', (SELECT id FROM movies WHERE title = 'The Dark Knight'), (SELECT id FROM actors WHERE first_name = 'Maggie' AND last_name = 'Gyllenhaal')),
  ('Bruce Wayne', (SELECT id FROM movies WHERE title = 'The Dark Knight Rises'), (SELECT id FROM actors WHERE first_name = 'Christian' AND last_name = 'Bale')),
  ('Commissioner Gordon', (SELECT id FROM movies WHERE title = 'The Dark Knight Rises'), (SELECT id FROM actors WHERE first_name = 'Gary' AND last_name = 'Oldman')),
  ('Bane', (SELECT id FROM movies WHERE title = 'The Dark Knight Rises'), (SELECT id FROM actors WHERE first_name = 'Tom' AND last_name = 'Hardy')),
  ('John Blake', (SELECT id FROM movies WHERE title = 'The Dark Knight Rises'), (SELECT id FROM actors WHERE first_name = 'Joseph'AND last_name = 'Gordon-Levitt')),
  ('Selina Kyle', (SELECT id FROM movies WHERE title = 'The Dark Knight Rises'), (SELECT id FROM actors WHERE first_name = 'Anne' AND last_name = 'Hathaway')),
  ('Ra''s Al Ghul', (SELECT id FROM movies WHERE title = 'Batman Begins'), (SELECT id FROM actors WHERE first_name = 'Liam' AND last_name = 'Neeson'));

 -- select * from roles
  
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.
-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint #1: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
--   Hint #2: Do NOT name one of your models/tables “cast” or “casts”; this 
--   is a reserved word in sqlite and will break your database! Instead, 
--   think of a better word to describe this concept; i.e. the relationship 
--   between an actor and the movie in which they play a part.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax
-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

.print "Movies"
.print "======"
.print ""
select movies.title, movies.release_year, movies.MPAA_rating, studios.studio_name from movies
inner join studios on movies.studio_id = studios.id; 

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

.print "Top Cast"
.print "======"
.print ""
select movies.title, actors.first_name, actors.last_name, roles.character_name from roles
inner join movies on roles.movie_id = movies.id
inner join actors on roles.actor_id = actors.id
order by movies.title;

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
--.mode column
--.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!

-- Create new tables, according to your domain model
-- TODO!

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!

-- Prints a header for the movies output
--.print "Movies"
--.print "======"
--.print ""

-- The SQL statement for the movies output
-- TODO!

-- Prints a header for the cast output
--.print ""
--.print "Top Cast"
--.print "========"
--.print ""


-- The SQL statement for the cast output
-- TODO!
