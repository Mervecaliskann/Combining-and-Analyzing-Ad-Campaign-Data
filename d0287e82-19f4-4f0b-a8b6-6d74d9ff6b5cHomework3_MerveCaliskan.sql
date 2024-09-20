WITH birlesik_tablo AS (
    SELECT ad_date, 'Facebook Ads' AS media_source, spend, impressions, reach, clicks, leads, value
    FROM facebook_ads_basic_daily
    UNION ALL
    SELECT ad_date, 'Google Ads' AS media_source, spend, impressions, reach, clicks, leads, value 
    FROM google_ads_basic_daily
)

SELECT 
    ad_date,
    media_source,
    SUM(spend) AS toplam_maliyet,
    SUM(impressions) AS toplam_goruntuleme,
    SUM(clicks) AS toplam_tiklama,
    SUM(value) AS value,
    SUM(clicks)::numeric /SUM(impressions)::numeric AS conversion_rate
FROM birlesik_tablo
WHERE clicks > 0 AND impressions > 0 AND clicks IS NOT NULL AND impressions IS NOT NULL 
GROUP BY ad_date, media_source
ORDER BY ad_date, media_source;