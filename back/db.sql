SELECT * FROM nba_db.gsw_20_21 where minutes>0;
SELECT * FROM nba_db.gsw_20_21 where game_date>='2020-12-22';
with temp as
(
select game_date,matchup,outcome,pts,sum(assists),sum(reboundsTotal),sum(steals) from nba_db.gsw_20_21 group by game_date
)
select outcome,count(outcome) from temp group by outcome;
select game_date,matchup,outcome,pts,sum(assists),sum(reboundsTotal),sum(steals) from nba_db.gsw_20_21 group by game_date;
SELECT nameI,count(nameI),avg(minutes),avg(points),avg(assists),avg(reboundsTotal),avg(steals) FROM nba_db.gsw_20_21 where minutes>0 group by nameI;