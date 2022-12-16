CREATE OR REPLACE FUNCTION `remote_udf.reverse_geocode` (lat FLOAT64, long FLOAT64) RETURNS JSON 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn` 
OPTIONS (endpoint = 'https://reverse-geocode-xju5dymn7q-uc.a.run.app')
;


SELECT
  location,
  JSON_VALUE(location_details[0].formatted_address) as formatted_address,
  location_details
from (
  SELECT
    location,
    remote_udf.reverse_geocode(location.lat,location.long) as location_details
FROM
  UNNEST([STRUCT(38.897696 AS lat,
      -77.036519 AS long),STRUCT(41.948463 AS lat,
      -87.655800 AS long)]) AS location
)
