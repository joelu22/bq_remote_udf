CREATE OR REPLACE FUNCTION `remote_udf.validate_address` (address STRING, region STRING) RETURNS JSON 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn`  --Replace withyour connection
OPTIONS (endpoint = 'https://validate-address-xju5dymn7q-uc.a.run.app') --Replace with your cloud function
;

SELECT
  address,
  JSON_VALUE(remote_udf.validate_address(address,'US').result.address.formattedAddress) as formattedAddress
FROM
  UNNEST([
  '2600 Benjamin Franklin Pkwy, Philadelphia, PA 19130',
  '2600 Ben Franklin, Philly, PA 19130',
  '2600 Ben Franklin, Philadelphia, PA',
  '2600 Benjamin Franklin, Philly'
  ]) AS address