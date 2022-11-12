-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- select and insert vine_table records into the total_votes_over20 table
select *
into total_votes_over20
from vine_table
where total_votes >= 20;

-- select and insert total_votes_over20 records into the helpful_votes_over50 table
select *
into helpful_votes_over50
from total_votes_over20
where CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

-- select and insert helpful_votes_over50 records into the paid_vine table
select *
into paid_vine
from helpful_votes_over50
where vine = 'Y';

-- select and insert helpful_votes_over50 records into the non_vine table
select *
into non_vine
from helpful_votes_over50
where vine = 'N';

-- get total number of paid reviews
select count(review_id) as "Total Paid Reviews"
from paid_vine

-- get total number of paid 5-star reviews
select count(review_id) as "Paid 5-Star Reviews"
from paid_vine
where star_rating >= 5

-- get percentage of paid 5-star reviews
select star_rating as "Star Rating", count(review_id) as "Paid Reviews",
	round(
		count(review_id) *100.0 / (select count(review_id) from paid_vine), 2		
		) as "Percentage of Paid Reviews"
from paid_vine
group by star_rating
order by star_rating desc;

-- get total number of unpaid reviews
select count(review_id) as "Total Unpaid Reviews"
from non_vine

-- get total number of unpaid 5-star reviews
select count(review_id) as "Unpaid 5-Star Reviews"
from non_vine
where star_rating >= 5

-- get percentage of unpaid 5-star reviews
select star_rating as "Star Rating", count(review_id) as "Unpaid Reviews",
	round(
		count(review_id) *100.0 / (select count(review_id) from non_vine), 2		
		) as "Percentage of Unpaid Reviews"
from non_vine
group by star_rating
order by star_rating desc;