CREATE OR REPLACE FUNCTION `remote_udf.distance_matrix` (orgin STRING, destination STRING, region STRING) RETURNS JSON 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn` 
OPTIONS (endpoint = 'https://distance-matrix-xju5dymn7q-uc.a.run.app')
;

SELECT
  JSON_VALUE(travel_details.origin_addresses[0]),
  JSON_VALUE(travel_details.destination_addresses[0]),
  JSON_VALUE(travel_details.rows[0].elements[0].distance.text),
  JSON_VALUE(travel_details.rows[0].elements[0].duration.text)
FROM (
  SELECT
    remote_udf.distance_matrix(val.origin, val.destination, val.region) AS travel_details
    from UNNEST([
      STRUCT("JFK Airport, New York City" as origin,"Yankee Stadium, New York City" as destination,"US" as region),
      STRUCT("LaGuardia Airport, New York City" as origin,"Yankee Stadium, New York City" as destination,"US" as region)
      ]) as val)