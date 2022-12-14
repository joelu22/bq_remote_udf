CREATE OR REPLACE FUNCTION `remote_udf.validate_address` (address STRING, region STRING) RETURNS JSON 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn` 
OPTIONS (endpoint = 'https://validate-address-xju5dymn7q-uc.a.run.app')
;

select val, JSON_VALUE(remote_udf.validate_address(val, 'US').result.address.formattedAddress)
from 
UNNEST(['2600 Benjamin Franklin Pkwy, Philadelphia, PA 19130',
     '2600 Ben Franklin, Philly, PA 19130',
     '2600 Ben Franklin, Philadelphia, PA',
     '2600 Benjamin Franklin, Philly'
     ]) AS val
