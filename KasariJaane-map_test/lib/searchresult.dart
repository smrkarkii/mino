import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:kasarijaane/main.dart';
import './model/route_model.dart' as r;

import './api_service.dart';

import '../components/constants.dart';
// import './components/constants.dart';
import './components/searchbar.dart';
import './components/searchbar2.dart';
import './RouteDesc.dart';
import 'dart:convert';

r.RouteModel? routeModel; //jsonVehicle
List<r.Route> jsonRouteOnly = []; //routeonly
List<r.Vehicle> jsonVehicleOnly = [];
String start = "";
String finish = "";

late String commonPo;
int counter = 0;
int counter2 = 1;

class RouteFinder {
  List<Map<String, dynamic>> places = []; //stops -> routes
  List<Map<String, dynamic>> listroutes = []; //routes -> stops
  Map<String, List<String>> groupedRoutes = {}; //common eliminated
  late String commonPo;

  List<Map<String, dynamic>> getPlaces() {
    // var data = jsonDecode(jsonString);
    List<r.Vehicle> vehicledata = routeModel!.vehicles;
    // print('vehicledata: $vehicledata');
    for (var vehicle in vehicledata) {
      var routes = vehicle.routes;
      for (var j = 0; j < routes.length; j++) {
        var route = routes[j];
        for (var stop in route.stops) {
          listroutes.add({'route': route.name, 'stopname': stop.name});

          places.add({
            'name': stop.name,
            'route_name': route.name,
          });
        }
      }
    }
    // print("list routes $listroutes");
    // print("places $places");
    // print("list routes $listroutes");
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
      // print('grouped places is $groupedPlaces');
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
    // print('groupedRoutes: $groupedRoutes');

    // convert to list of maps
    List<Map<String, dynamic>> uniquePlaces = [];
    groupedPlaces.forEach((name, routename) {
      uniquePlaces.add({
        'name': name,
        'routename': routename,
      });
    });
    // print("unique places $uniquePlaces"); //duplircate remocal
    return uniquePlaces;
  }

  List findSpecific(String query) {
    // print('I got called - findSpecific()');
    var allplaces = getPlaces();
    // print('allplaces: $allplaces');
    var foundplace = [];
    for (var place in allplaces) {
      if (place['name'] == query) {
        foundplace.add(place);
      }
    }
    // print('foundplaces: $foundplace');
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
    // for (var startPoint in startPointRoutes) {
    //   for (var endPoint in endPointRoutes) {
    //     for (var startroute in startPoint['routename']) {
    //       if (endPoint['routename'].contains(startroute)) {
    //         matchingIds.add(startroute);
    //       }
    //     }
    //   }
    // }

    List<String> common = findcommon(
        startPointRoutes[0]['routename'], endPointRoutes[0]['routename']);
    matchingIds.addAll(common);

    return matchingIds;
  }
}

class MyLogic {
  String startingPoint;
  String destination;

  MyLogic({required this.startingPoint, required this.destination});

  List<r.Fare> search() {
    List<r.Vehicle> vehicledata = routeModel!.vehicles;
    List<r.Stop> stopdata = [];

    List<r.Fare> results = []; //add fares to it
    int count = 0;
    for (var vehicle in vehicledata) {
      for (var route in vehicle.routes) {
        for (var fare in route.fares) {
          if (fare.startLocation.toLowerCase() == startingPoint.toLowerCase() &&
              fare.endLocation.toLowerCase() == destination.toLowerCase()) {
            results.add(fare); //only fare model
            start = startingPoint;
            finish = destination;
            count += 1;

            break;
          }
        }
      }
    }
    print('count $count');
    return results; //returns the route ids
  }
}

class SearchResultPage extends StatefulWidget {
  SearchResultPage(
      {Key? key, required this.starting, required this.destination})
      : super(key: key);

  final String starting;
  final String destination;

  @override
  State<SearchResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<SearchResultPage> {
  TextEditingController startingPointController = TextEditingController();

  TextEditingController destinationController = TextEditingController();

  String? _selectedOption;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) {
      // print(' route model $routeModel');
      setState(() {
        // jsonVehicleOnly = value!.vehicles;
      });
    });
  }

  // void _showOptions(BuildContext context) {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: _options.map((option) {
  //           return ListTile(
  //             title: Text(option),
  //             onTap: () {
  //               setState(() {
  //                 _selectedOption = option;
  //               });

  //               Navigator.pop(context);
  //             },
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    jsonVehicleOnly = routeModel!.vehicles;
    // print("route model $routeModel");
    // print('json vehicle only ${jsonVehicleOnly.length}');

//adding all the routes in jsonRouteOnly (unfilitred)
    for (var vehicle in jsonVehicleOnly) {
      jsonRouteOnly.addAll(vehicle.routes);
    }

    MyLogic logic =
        MyLogic(startingPoint: 'Satdobato', destination: 'Budhanilkantha');

    List<r.Fare> searchedObject = logic.search();
    print("if direct ${searchedObject.length}");

    print(searchedObject.isEmpty);
    if (searchedObject.isNotEmpty) {
      counter2 = searchedObject.length;
      print(counter2);
    } else {
      counter += 1;
      counter2 = 1;
      print(counter2);
      print(counter);

      RouteFinder R = RouteFinder();
      var startPointRoutes = R.findSpecific('Satdobato');
      var endPointRoutes = R.findSpecific('Budhanilkantha');

      List<String> matching =
          R.findMatchingIds(startPointRoutes, endPointRoutes);
      // print('uniquie routes $unique')
      print('matching $matching');

      List<r.Fare> findmatchingfaremodel(query) {
        List<r.Vehicle> vehicledata = routeModel!.vehicles;
        print(query);
        List<r.Fare> results = []; //add fares to it
        for (var vehicle in vehicledata) {
          for (var route in vehicle.routes) {
            for (var fare in route.fares) {
              if (route.name.toLowerCase() == query.toLowerCase()) {
                results.add(fare);
                print('added one'); //only fare mode
                break;
              }
            }
          }
        }
        print('results: $results');
        return results;
      }

      for (var one in matching) {
        if (findmatchingfaremodel(one).isEmpty) {
          break;
        }
        searchedObject.addAll(findmatchingfaremodel(one));
      }
      if (searchedObject.isEmpty) {
        print("no indirect routes available");
      }
      // print('print');
      print('startPointroutes $startPointRoutes');
      print('endPointRoutes $endPointRoutes');
      print('R.commonPO ${R.commonPo}');
    }

    return routeModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Available Routes'),
              backgroundColor: ktheme,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).bodyText2,
              titleTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).headline6,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            backgroundColor: kwhite,
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchBar2(
                        label: start,
                        controller: startingPointController,
                      ),
                      SearchBar(
                        label: finish,
                        controller: destinationController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: ktheme, // text color
                              minimumSize: Size(200, 50),
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(0),
                            // ),
                            onPressed: () {
                              String startingPoint =
                                  startingPointController.text;
                              String destination = destinationController.text;
                              print('Starting point $startingPoint');
                              print(destination);
                              if (startingPoint.isEmpty ||
                                  destination.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Please fill in both fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultPage(
                                        starting: startingPoint,
                                        destination: destination),
                                  ),
                                );
                              }
                            },
                            child: Text('Search Route'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: counter2,
                    itemBuilder: (BuildContext context, int index) {
                      print('searched objects $searchedObject');
                      print('searached object length ${searchedObject.length}');
                      //finding list of route ids with matching searches
                      List<String> fareList = [];
                      for (var eachfare in searchedObject) {
                        fareList.add(eachfare.fare);
                      }

                      List<int> searchedRouteId = [];
                      List<r.Route> searchedRoutes = [];
                      for (var obj in searchedObject) {
                        searchedRouteId.add(obj.route);
                        // print(searchedRouteId);rr
                      }
                      // print(searchedRouteId); //ok till here
                      //filtered list of routes
                      for (var route in jsonRouteOnly) {
                        if (searchedRouteId.contains(route.id)) {
                          searchedRoutes.add(route);
                          // print(route.id);
                        }
                      }
                      // print(jsonRouteOnly.length);
                      List<int> searchedVehicleId = [];
                      List<r.Vehicle> searchedVehicles = [];
                      for (var obj in searchedRoutes) {
                        searchedVehicleId.add(obj.vehicle);
                        // print(searchedVehicleId);
                      }
                      //filtered list of vehicles
                      for (var vehic in jsonVehicleOnly) {
                        if (searchedRouteId.contains(vehic.id)) {
                          searchedVehicles.add(vehic);
                        }
                      }
                      //all stops
                      if (counter == 0) {
                        print(
                            "inside if statement that is direct route $counter");
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                '${searchedVehicles[index].name}',
                                style: TextStyle(
                                  color: ktheme,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // onTap: () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         RouteDesc(route: $searchedRoutes),
                              //   ),
                              // ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.route_sharp,
                                        size: 16.0,
                                        color: kblack,
                                      ),
                                      SizedBox(width: 4.0),
                                      Expanded(
                                        child: Text(
                                          '${searchedRoutes[index].stops.map((stop) => stop.name)} '
                                          // ${searchedRoutes[index].stops} '
                                          ,
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        size: 16.0,
                                        color: kblack,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Rs. ${fareList[index]}',
                                        style: TextStyle(
                                          color: kblack,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  SizedBox(height: 4.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        print("inside else statement $counter");
                        return Column(children: [
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  '${searchedVehicles[0].name}',
                                  style: TextStyle(
                                    color: ktheme,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // onTap: () => Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         RouteDesc(route: $searchedRoutes),
                                //   ),
                                // ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4.0),
                                    //stop row
                                    Row(
                                      children: [
                                        SizedBox(height: 4.0),
                                        Icon(
                                          Icons.route_sharp,
                                          size: 16.0,
                                          color: kblack,
                                        ),
                                        SizedBox(width: 4.0),
                                        Expanded(
                                          child: Text(
                                            '${searchedRoutes[0].stops.map((stop) => stop.name)} '
                                            // ${searchedRoutes[index].stops} '
                                            ,
                                            style: TextStyle(
                                              color: kblack,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    //fare row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          size: 16.0,
                                          color: kblack,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          'Rs. ${fareList[0]}',
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Icon(
                            Icons.arrow_downward,
                            size: 30.0,
                            color: ktheme,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  '${searchedVehicles[1].name}',
                                  style: TextStyle(
                                    color: ktheme,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RouteDesc(
                                            route: searchedVehicles[index]),
                                      ));
                                },
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4.0),
                                    //stop row
                                    Row(
                                      children: [
                                        SizedBox(height: 4.0),
                                        Icon(
                                          Icons.route_sharp,
                                          size: 16.0,
                                          color: kblack,
                                        ),
                                        SizedBox(width: 4.0),
                                        Expanded(
                                          child: Text(
                                            '${searchedRoutes[1].stops.map((stop) => stop.name)} '
                                            // ${searchedRoutes[index].stops} '
                                            ,
                                            style: TextStyle(
                                              color: kblack,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    //fare row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          size: 16.0,
                                          color: kblack,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          'Rs. ${fareList[1]}',
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
