#Turn on the BQ Connection API

bq mk --connection \
    --connection_type=CLOUD_RESOURCE \
    --project_id=<projectname> \
    --location=us-central1 \
    remote_cloudfunc_conn

#Get the serviceAccountId of the created connection
bq ls --location=us-central1 --connection remote_cloudfunc_conn.
#Grant the service account Cloud Run Invoker Role

#Create a dataset
bq --location=us-central1 mk -d \
    --description "Remote UDF Dataset." \
    remote_udf


CREATE OR REPLACE FUNCTION `remote_udf.hello_world` (x STRING) RETURNS STRING 
REMOTE WITH CONNECTION `gcp528a1.us-central1.remote_cloudfunc_conn` --Replace withyour connection
OPTIONS (endpoint = 'https://hello-world-xju5dymn7q-uc.a.run.app') --Replace with your cloud function
;

select val, remote_udf.hello_world(val)
from 
UNNEST(['world','a','b','c']) AS val