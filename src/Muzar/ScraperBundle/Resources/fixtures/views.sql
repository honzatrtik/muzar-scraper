CREATE OR REPLACE
  VIEW v_scraper_ad
AS
  SELECT
    a.id      AS id,
    a.link    AS link,
    a.parsed  AS parsed,
    a.created AS created,
    a.status  AS status,
    p1.value  AS price,
    p2.value  AS currency,
    p3.value  AS name,
    p4.value  AS category,
    p5.value  AS type,
    p6.value  AS images,
    p7.value  AS text,
    COALESCE(p8.value, p8.value_serialized)  AS image_urls,
    p9.value  AS categoryId,
    p10.value  AS email,
    p11.value  AS phone,
    p12.value  AS region

  FROM scraper_ad a
    JOIN scraper_ad_property p1
      ON (a.id = p1.scraper_ad_id) AND (p1.name = 'price')
    JOIN scraper_ad_property p2
      ON (a.id = p2.scraper_ad_id) AND (p2.name = 'currency')
    JOIN scraper_ad_property p3
      ON (a.id = p3.scraper_ad_id) AND (p3.name = 'name')
    JOIN scraper_ad_property p4
      ON (a.id = p4.scraper_ad_id) AND (p4.name = 'category')
    JOIN scraper_ad_property p5
      ON (a.id = p5.scraper_ad_id) AND (p5.name = 'type')
    LEFT JOIN scraper_ad_property p6
      ON (a.id = p6.scraper_ad_id) AND (p6.name = 'images')
    LEFT JOIN scraper_ad_property p7
      ON (a.id = p7.scraper_ad_id) AND (p7.name = 'text')
    LEFT JOIN scraper_ad_property p8
      ON (a.id = p8.scraper_ad_id) AND (p8.name = 'imageUrls')
    LEFT JOIN scraper_ad_property p9
      ON (a.id = p9.scraper_ad_id) AND (p9.name = 'categoryId')
    LEFT JOIN scraper_ad_property p10
      ON (a.id = p10.scraper_ad_id) AND (p10.name = 'email')
    LEFT JOIN scraper_ad_property p11
      ON (a.id = p11.scraper_ad_id) AND (p11.name = 'phone')
    LEFT JOIN scraper_ad_property p12
      ON (a.id = p12.scraper_ad_id) AND (p12.name = 'region')

      ;
      
      
      
-- Create syntax for VIEW 'v_scraper_ad_grouped'
CREATE  VIEW `v_scraper_ad_grouped`
AS SELECT
   `a`.`id` AS `id`,
   `a`.`link` AS `link`,
   `a`.`parsed` AS `parsed`,
   `a`.`created` AS `created`,
   `a`.`status` AS `status`,
   `a`.`price` AS `price`,
   `a`.`currency` AS `currency`,
   `a`.`name` AS `name`,
   `a`.`category` AS `category`,
   `a`.`type` AS `type`,
   `a`.`images` AS `images`,
   `a`.`text` AS `text`,
   `a`.`image_urls` AS `image_urls`,
   `a`.`categoryId` AS `categoryId`,
   `a`.`email` AS `email`,
   `a`.`phone` AS `phone`,
   `a`.`region` AS `region`
FROM `v_scraper_ad` `a` where (`a`.`type` = 'nabidka') group by `a`.`email`,`a`.`category`,`a`.`name`;

-- Create syntax for VIEW 'v_scraper_ad_stats_day'
CREATE  VIEW `v_scraper_ad_stats_day`
AS SELECT
   year(`v_scraper_ad`.`created`) AS `YEAR`,month(`v_scraper_ad`.`created`) AS `MONTH`,dayofmonth(`v_scraper_ad`.`created`) AS `DAY`,count(distinct `v_scraper_ad`.`id`) AS `inzeratu`
FROM `v_scraper_ad` where (`v_scraper_ad`.`type` = 'nabidka') group by year(`v_scraper_ad`.`created`),month(`v_scraper_ad`.`created`),dayofmonth(`v_scraper_ad`.`created`) order by year(`v_scraper_ad`.`created`) desc,month(`v_scraper_ad`.`created`) desc,dayofmonth(`v_scraper_ad`.`created`) desc;

-- Create syntax for VIEW 'v_scraper_ad_stats_hour'
CREATE  VIEW `v_scraper_ad_stats_hour`
AS SELECT
   year(`v_scraper_ad`.`created`) AS `YEAR`,month(`v_scraper_ad`.`created`) AS `MONTH`,dayofmonth(`v_scraper_ad`.`created`) AS `DAY`,hour(`v_scraper_ad`.`created`) AS `HOUR(created)`,count(distinct `v_scraper_ad`.`id`) AS `inzeratu`
FROM `v_scraper_ad` where (`v_scraper_ad`.`type` = 'nabidka') group by year(`v_scraper_ad`.`created`),month(`v_scraper_ad`.`created`),dayofmonth(`v_scraper_ad`.`created`),hour(`v_scraper_ad`.`created`) order by year(`v_scraper_ad`.`created`) desc,month(`v_scraper_ad`.`created`) desc,dayofmonth(`v_scraper_ad`.`created`) desc,hour(`v_scraper_ad`.`created`) desc;