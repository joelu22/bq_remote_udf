#https://cloud.google.com/bigquery/docs/reference/standard-sql/remote-functions#input_format

import json
import googlemaps
import os

# This is the entry point for the Cloud Function.
# It looks similar for most Remote UDFs I write. 
# It simply creates a for loop for the batch of data
# and sends each row to the next function.
def validate_address(request):
  try:
    gmaps = googlemaps.Client(key=os.getenv('GMAPS_API'))
    # Consider storing your Google Maps API Key in Secrets Manager
    # so it can be called securely

    return_value = []
    request_json = request.get_json()
    calls = request_json['calls']
    for call in calls:
      return_value.append(each_row(gmaps, call))
    return_json = json.dumps( { "replies" :  return_value} )
    return return_json
  except Exception as inst:
    return json.dumps( { "errorMessage": f"Unexpected {inst=}, {type(inst)=}" } ), 400

# This function does the work on each row.
# In this case it calls the Google Maps Address Validation API
# for the address and region sent to it.
def each_row(gmaps, call):
  retval = gmaps.addressvalidation([call[0]], regionCode=call[1])
  return retval

