#https://cloud.google.com/bigquery/docs/reference/standard-sql/remote-functions#input_format

import json

def hello_world(request):
  try:
    return_value = []
    request_json = request.get_json()
    calls = request_json['calls']
    for call in calls:
      return_value.append(each_row(call))
    return_json = json.dumps( { "replies" :  return_value} )
    return return_json
  except Exception as inst:
    return json.dumps( { "errorMessage": f"Unexpected {inst=}, {type(inst)=}" } ), 400

def each_row(call):
  return 'Hello ' + call[0]

