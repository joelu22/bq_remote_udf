If you are looking to enhance your data stored in Google BigQuery with the capabilities of Google Maps, there are some great new features that can help. BigQuery recently released Remote Functions and a native JSON datatype which you can use to simplify processing and expand access of Google Maps to your SQL users. You can use Google Maps Address Validation to cleanup addresses for marketing. If you have latitude/longitude data of your business events or mobile application usage you can use reverse geocoding to relate those locations to addresses. Or you can use the Distance Matrix APIs to determine which locations would have the best drive time to service a customer.

Read my medium artical for more detail.

<h3>High level steps:</h3>
1.) Create a Cloud Function (each directory has a main.py which can be tested with testPayload.json)

2.) Create a BigQuery Connection and Register the Remote Function (sample in bqCommands.sql)
3.) Query! (sample in bqCommands.sql)
