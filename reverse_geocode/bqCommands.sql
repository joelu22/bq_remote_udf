CREATE OR REPLACE FUNCTION `remote_udf.reverse_geocode` (lat FLOAT64, long FLOAT64) RETURNS JSON 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn` 
OPTIONS (endpoint = 'https://reverse-geocode-xju5dymn7q-uc.a.run.app')
;


select val, JSON_VALUE(remote_udf.reverse_geocode(val.lat, val.long)[0].formatted_address)
from 
UNNEST([STRUCT(38.897696 as lat, -77.036519 as long),STRUCT(41.948463 as lat, -87.655800 as long)]) AS val
