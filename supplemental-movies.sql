/* Questions 1 and 2 */
SELECT movies.movieid, movies.title, AVG(ratings.rating) as 'Rating', COUNT(ratings.rating) as 'Total Ratings'
FROM movies
JOIN ratings ON movies.movieid=ratings.movieid
GROUP BY movies.movieid;

/* Question 3 */
SELECT g.genres, COUNT(m.movieid) as 'Count'
FROM movies.movies m
LEFT JOIN movies.movie_genre mg ON m.movieid=mg.movieid
LEFT JOIN movies.genre g ON mg.genre_id=g.id
GROUP BY g.genres
ORDER BY Count DESC;

/* Question 4: Get the average rating for a user */
/* Question 5: Find the user with the most ratings*/
SELECT r.userid, AVG(rating) as 'averageRating', COUNT(r.movieid) as 'amountReviews'
FROM movies.ratings r
GROUP BY r.userid
ORDER BY amountReviews DESC;

/* Question 6: Find the user with the highest average rating*/
SELECT r.userid, AVG(rating) as 'averageRating', COUNT(r.movieid) as 'amountReviews'
FROM movies.ratings r
GROUP BY r.userid
ORDER BY averageRating DESC;
/* Question 7: Find the user with the highest average rating with more than 50 reviews*/
SELECT r.userid, AVG(rating) as 'averageRating', COUNT(r.movieid) as 'amountReviews'
FROM movies.ratings r
GROUP BY r.userid
HAVING amountReviews > 50
ORDER BY averageRating DESC, amountReviews DESC
LIMIT 1
;
/* Question 8: Find the movies with an average rating over 4*/
SELECT m.movieid, m.title, AVG(r.rating) as 'Rating'
FROM movies.movies m
JOIN ratings r ON m.movieid=r.movieid
GROUP BY m.movieid
HAVING Rating > 4
ORDER BY Rating DESC
;

/* Question 9: For each genre find the total number of reviews as well as the average review sort by highest average review.*/
SELECT g.id, g.genres, COUNT(r.rating) as 'countOfRatings', AVG(r.rating) as 'averageRating'
FROM movies.movies m
JOIN ratings r ON m.movieid=r.movieid
JOIN movie_genre mg ON m.movieid=mg.movieid
JOIN genre g ON mg.genre_id=g.id
WHERE m.movieid < 100 /*Limiting it to 100 so the query finishes*/
GROUP BY g.id
ORDER BY averageRating DESC
;

/* Joins*/
/* Question 1: Find all comedies*/
SELECT m.title, g.id, GROUP_CONCAT(g.genres Separator ', ') as 'Genre'
FROM movies.movies m
LEFT JOIN movies.movie_genre mg ON m.movieid=mg.movieid
LEFT JOIN movies.genre g ON mg.genre_id=g.id
GROUP BY m.movieid
HAVING g.id =2;
/* Question 2: Find all comedies in the year 2000*/
SELECT REGEXP_SUBSTR(title,'\((\\d{4})\)') AS 'Year', m.title, g.id, GROUP_CONCAT(g.genres Separator ', ') as 'Genre'
FROM movies.movies m
LEFT JOIN movies.movie_genre mg ON m.movieid=mg.movieid
LEFT JOIN movies.genre g ON mg.genre_id=g.id
GROUP BY m.movieid
HAVING g.id =2 AND Year = '2000';
/* Question 3: Find any movies that are about death and are a comedy*/
SELECT *
FROM movies.movies
JOIN tags on movies.movieid=tags.movieid
WHERE genres LIKE '%Comedy%' AND tag LIKE '%Death%';
/* Question :4 Find any movies from either 2001 or 2002 with a title containing super*/
SELECT *
FROM movies.movies
WHERE (title LIKE '%(2001)' OR title LIKE '%(2002)') AND title LIKE '%super%';





/* Other things I tried out */
SELECT m.title, GROUP_CONCAT(g.genres Separator ', ') as 'Genre'
FROM movies.movies m
LEFT JOIN movies.movie_genre mg ON m.movieid=mg.movieid
LEFT JOIN movies.genre g ON mg.genre_id=g.id
WHERE m.movieid < 100
GROUP BY m.movieid;

SELECT movies.movieid, movies.title, AVG(ratings.rating) as 'Rating', COUNT(ratings.rating) as 'countRatings', FLOOR((COUNT(ratings.rating)/50))*50 as roundCount 
FROM movies
JOIN ratings ON movies.movieid=ratings.movieid
GROUP BY movies.movieid
ORDER BY roundCount DESC, Rating DESC;
