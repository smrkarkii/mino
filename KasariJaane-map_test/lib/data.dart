import 'dart:convert';

Map<String, dynamic> vehicles = {
  "vehicles": [
    {
      "id": 1,
      "name": "Sajha Bus",
      "type": "bus",
      "routes": [
        {
          "id": 1,
          "name": "S1",
          "starting_point": "A",
          "final_point": "F",
          "vehicle": 1,
          "stops": [
            {
              "id": 1,
              "name": "b",
              "latitude": "80.000000",
              "longitude": "81.000000",
              "distance": 0,
              "route": 1
            },
            {
              "id": 3,
              "name": "d",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 200,
              "route": 1
            }
          ],
          "fares": [
            {
              "id": 1,
              "start_location": "A",
              "end_location": "B",
              "fare": "5.00",
              "route": 1
            },
            {
              "id": 2,
              "start_location": "A",
              "end_location": "C",
              "fare": "10.00",
              "route": 1
            },
            {
              "id": 3,
              "start_location": "A",
              "end_location": "D",
              "fare": "15.00",
              "route": 1
            },
            {
              "id": 4,
              "start_location": "A",
              "end_location": "E",
              "fare": "20.00",
              "route": 1
            },
            {
              "id": 5,
              "start_location": "A",
              "end_location": "F",
              "fare": "25.00",
              "route": 1
            },
            {
              "id": 7,
              "start_location": "B",
              "end_location": "C",
              "fare": "5.00",
              "route": 1
            },
            {
              "id": 8,
              "start_location": "B",
              "end_location": "D",
              "fare": "10.00",
              "route": 1
            },
            {
              "id": 9,
              "start_location": "B",
              "end_location": "D",
              "fare": "10.00",
              "route": 1
            },
            {
              "id": 10,
              "start_location": "B",
              "end_location": "E",
              "fare": "15.00",
              "route": 1
            },
          ]
        },
        {
          "id": 2,
          "name": "S2",
          "starting_point": "G",
          "final_point": "L",
          "vehicle": 1,
          "stops": [
            {
              "id": 2,
              "name": "b",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 100,
              "route": 1
            },
          ],
          "fares": [
            {
              "id": 21,
              "start_location": "sukedhara",
              "end_location": "chappakkarkhana",
              "fare": "15.00",
              "route": 2
            },
            {
              "id": 24,
              "start_location": "a",
              "end_location": "b",
              "fare": "20.00",
              "route": 2
            }
          ]
        }
      ]
    },
    {
      "id": 2,
      "name": "Tempo",
      "type": "tempo",
      "routes": [
        {
          "id": 5,
          "name": "tempo-route1",
          "starting_point": "lagankhel",
          "final_point": "ratnapark",
          "vehicle": 2,
          "stops": [
            {
              "id": 1,
              "name": "a",
              "latitude": "80.000000",
              "longitude": "81.000000",
              "distance": 0,
              "route": 1
            },
            {
              "id": 2,
              "name": "b",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 100,
              "route": 1
            },
            {
              "id": 3,
              "name": "c",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 200,
              "route": 1
            }
          ],
          "fares": [
            {
              "id": 23,
              "start_location": "sukedhara",
              "end_location": "chappakkarkhana",
              "fare": "15.00",
              "route": 5
            }
          ]
        }
      ]
    },
    {
      "id": 3,
      "name": "Tempo",
      "type": "tempo",
      "routes": [
        {
          "id": 5,
          "name": "tempo1",
          "starting_point": "lagankhel",
          "final_point": "ratnapark",
          "vehicle": 2,
          "stops": [
            {
              "id": 1,
              "name": "a",
              "latitude": "80.000000",
              "longitude": "81.000000",
              "distance": 0,
              "route": 1
            },
            {
              "id": 3,
              "name": "c",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 200,
              "route": 1
            },
            {
              "id": 3,
              "name": "e",
              "latitude": "81.000000",
              "longitude": "82.000000",
              "distance": 200,
              "route": 1
            }
          ],
          "fares": [
            {
              "id": 23,
              "start_location": "sukedhara",
              "end_location": "chappakkarkhana",
              "fare": "15.00",
              "route": 5
            }
          ]
        }
      ]
    },
  ]
};

String jsonString = json.encode(vehicles);

class RouteFinder {
  List<Map<String, dynamic>> places = [];
  List<Map<String, dynamic>> listroutes = [];
  Map<String, List<String>> groupedRoutes = {};
  late String commonPo;

  List<Map<String, dynamic>> getPlaces(String jsonString) {
    var data = jsonDecode(jsonString);
    for (var vehicle in data['vehicles']) {
      var routes = vehicle['routes'];
      for (var j = 0; j < routes.length; j++) {
        var route = routes[j];
        for (var stop in route['stops']) {
          listroutes.add({'route': route['name'], 'stopname': stop['name']});

          places.add({
            'name': stop['name'],
            'route_name': route['name'],
          });
        }
      }
    }
    // remove duplicates and group by name
    Map<String, List<String>> groupedPlaces = {};

    places.forEach((place) {
      String placename = place['name'];
      String routename = place['route_name'];
      if (groupedPlaces.containsKey(placename)) {
        if (!groupedPlaces[placename]!.contains(routename)) {
          groupedPlaces[placename]!.add(routename);
        }
      } else {
        groupedPlaces[placename] = [routename];
      }
    });
    listroutes.forEach((listroute) {
      String route = listroute['route'];
      String stopname = listroute['stopname'];
      if (groupedRoutes.containsKey(route)) {
        if (!groupedRoutes[route]!.contains(stopname)) {
          groupedRoutes[route]!.add(stopname);
        }
      } else {
        groupedRoutes[route] = [stopname];
      }
    });

    // convert to list of maps
    List<Map<String, dynamic>> uniquePlaces = [];
    groupedPlaces.forEach((name, routename) {
      uniquePlaces.add({
        'name': name,
        'routename': routename,
      });
    });
    return uniquePlaces;
  }

  List findSpecific(String query) {
    var allplaces = getPlaces(jsonString);
    var foundplace = [];
    for (var place in allplaces) {
      if (place['name'] == query) {
        foundplace.add(place);
      }
    }
    return foundplace;
  }

  List<String> findcommon(
      List<String> startPointRout, List<String> endPointRout) {
    Set<String> sPr = {};
    Set<String> ePr = {};
    for (String key in startPointRout.toList()) {
      sPr.addAll(groupedRoutes[key] as Iterable<String>);
    }
    for (String key in endPointRout.toList()) {
      ePr.addAll(groupedRoutes[key] as Iterable<String>);
    }
    // Find common elements
    Set<String> commonElements = sPr.intersection(ePr);

    // Find common point
    commonPo = commonElements.first;
    List commonP = findSpecific(commonElements.first);
    List<String> b = commonP[0]['routename'];
    List<String> result = b
        .where((element) =>
            endPointRout.contains(element) || startPointRout.contains(element))
        .toList();
    List<String> commonPoint = [];
    commonPoint.addAll(result);
    return commonPoint;
  }

  List<String> findMatchingIds(
      List<dynamic> startPointRoutes, List<dynamic> endPointRoutes) {
    List<String> matchingIds = [];
    for (var startPoint in startPointRoutes) {
      for (var endPoint in endPointRoutes) {
        for (var startroute in startPoint['routename']) {
          if (endPoint['routename'].contains(startroute)) {
            matchingIds.add(startroute);
          }
        }
      }
    }

    List<String> common = findcommon(
        startPointRoutes[0]['routename'], endPointRoutes[0]['routename']);
    matchingIds.addAll(common);

    return matchingIds;
  }
}

main() {
  RouteFinder R = new RouteFinder();
  var startPointRoutes = R.findSpecific('a');
  var endPointRoutes = R.findSpecific('d');

  var matching = R.findMatchingIds(startPointRoutes, endPointRoutes);

  print(startPointRoutes);
  print(endPointRoutes);
  print(matching);
  print(R.commonPo);
}
