CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, z.size FROM dogs AS d, sizes AS z WHERE d.height <= z.max AND d.height > z.min;
  

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child FROM parents AS p, dogs AS d WHERE p.parent = d.name ORDER BY -d.height;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS first, b.child AS second FROM parents AS a, parents AS b 
  WHERE a.parent = b.parent AND a.child < b.child order by a.child;

CREATE TABLE sibhig AS
  SELECT a.first, a.second, b.height as h1, c.height as h2 from siblings as a, dogs as b, dogs as c
  WHERE a.first = b.name and a.second = c.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  select a.first || " and " || a.second || " are " || b.size || " siblings" from 
  sibhig as a, sizes as b where a.h1 <= b.max and a.h1 > b.min and a.h2 <= b.max and a.h2 > b.min;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
insert into stacks_helper
  select name, height, height from dogs order by height;

-- insert into stacks_helper 
--   select a.dogs || ", " || b.dogs, a.stack_height + b.last_height, b.last_height from 
--   stacks_helper as a, stacks_helper as b where a.last_height < b.last_height;

insert into stacks_helper 
  select a.dogs || ", " || b.dogs, a.stack_height + b.last_height, b.last_height from 
  stacks_helper as a, stacks_helper as b where a.last_height < b.last_height group by a.stack_height;

insert into stacks_helper 
  select a.dogs || ", " || b.dogs, a.stack_height + b.last_height, b.last_height from stacks_helper as a,
  stacks_helper as b where a.stack_height > 52 and a.last_height < b.last_height and b.stack_height < 54;

insert into stacks_helper
  select a.dogs || ", " || b.dogs, a.stack_height + b.last_height, b.last_height 
  from stacks_helper as a, stacks_helper as b 
  where a.stack_height >= 85 and b.stack_height < 54 and a.last_height < b.last_height;


CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper where stack_height > 170;
