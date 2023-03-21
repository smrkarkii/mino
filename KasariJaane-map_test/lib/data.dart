 Map<String, dynamic> vehicles={
  "stops": [
            {
              "id": 6,
              "name": "Lagankhel",
              "latitude": "27.666000",
              "longitude": "85.322700",
              "distance": 0,
              "route": 2
            },
            {
              "id": 7,
              "name": "Kumaripati",
              "latitude": "27.669900",
              "longitude": "85.320400",
              "distance": 0,
              "route": 2
            },
 ]

 }
dynamic graph = {}

for stop1 in stops:
    graph[stop1["name"]] = {}
    for stop2 in stops:
        if stop1 != stop2:
            dist = distance(stop1["latitude"], stop1["longitude"], stop2["latitude"], stop2["longitude"])
            graph[stop1["name"]][stop2["name"]] = dist
