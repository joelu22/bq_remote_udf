#https://cloud.google.com/bigquery/docs/reference/standard-sql/remote-functions#input_format

import json
import googlemaps
import os

def distance_matrix(request):
  try:
    gmaps = googlemaps.Client(key=os.getenv('GMAPS_API'))

    return_value = []
    request_json = request.get_json()
    calls = request_json['calls']
    for call in calls:
      return_value.append(each_row(gmaps, call))
    return_json = json.dumps( { "replies" :  return_value} )
    return return_json
  except Exception as inst:
    return json.dumps( { "errorMessage": f"Unexpected {inst=}, {type(inst)=}" } ), 400

def each_row(gmaps, call):

  retval = gmaps.distance_matrix(origins=call[0], destinations=call[1], region=call[2], units="imperial")

  return retval

