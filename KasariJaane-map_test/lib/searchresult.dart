import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:kasarijaane/main.dart';
import './model/route_model.dart' as r;

import './api_service.dart';

import '../components/constants.dart';
import './RouteDesc.dart';

r.RouteModel? routeModel; //jsonVehicle
List<r.Route> jsonRouteOnly = []; //routeonly
List<r.Vehicle> jsonVehicleOnly = [];

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
            count += 1;

            break;
          }
        }
      }
    }
    print('count $count');
    return results; //returns the route ids
  }

  List<String> finalRoutes() {
    // code for generating final routes
    return ['Route 1', 'Route 2', 'Route 3'];
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
  List<String> _options = [
    'Kathmandu',
    'Pokhara',
    'Chitwan',
    'Lumbini',
    'Bhaktapur'
  ];

  String? _selectedOption;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) {
      print(routeModel);
      setState(() {
        // jsonVehicleOnly = value!.vehicles;
      });
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                setState(() {
                  _selectedOption = option;
                });

                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (routeModel == null) {
      print('route model is null');
    }
    jsonVehicleOnly = routeModel!.vehicles;
    print('json vehicle only ${jsonVehicleOnly.length}');

//adding all the routes in jsonRouteOnly (unfilitred)
    for (var vehicle in jsonVehicleOnly) {
      jsonRouteOnly.addAll(vehicle.routes);
    }

    MyLogic logic = MyLogic(startingPoint: 'a', destination: 'b');

    List<r.Fare> searchedObject = logic.search();
    print('searched objects length${searchedObject.length}');

    return routeModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Search Results'),
              backgroundColor: kdarkpurple,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).bodyText2,
              titleTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).headline6,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            backgroundColor: kgrey,
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('From: ', style: TextStyle(color: kblack)),
                          DropdownButton<String>(
                            value: 'Kathmandu',
                            onChanged: (String? newValue) {},
                            items: <String>[
                              'Kathmandu',
                              'Pokhara',
                              'Chitwan',
                              'Lumbini',
                              'Bhaktapur'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(color: kgreen)),
                              );
                            }).toList(),
                            hint: Text('From', style: TextStyle(color: kgreen)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('To: ', style: TextStyle(color: kblack)),
                              DropdownButton<String>(
                                value: 'Pokhara',
                                onChanged: (String? newValue) {},
                                items: <String>[
                                  'Kathmandu',
                                  'Pokhara',
                                  'Chitwan',
                                  'Lumbini',
                                  'Bhaktapur'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(color: kblack)),
                                  );
                                }).toList(),
                                hint:
                                    Text('To', style: TextStyle(color: kblack)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,

                                backgroundColor: kdarkpurple, // text color
                              ),
                              onPressed: () {},
                              child: Text('Search Route'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedObject.length,
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
                      print(searchedRouteId); //ok till here
                      //filtered list of routes
                      for (var route in jsonRouteOnly) {
                        if (searchedRouteId.contains(route.id)) {
                          searchedRoutes.add(route);
                          // print(route.id);
                        }
                      }
                      print(jsonRouteOnly.length);
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

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              '${searchedVehicles[index].name}',
                              style: TextStyle(
                                color: kblack,
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
                                      Icons.access_time,
                                      size: 16.0,
                                      color: kblack,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '${searchedRoutes[index].stops.map((stop) => stop.name)} '
                                      // ${searchedRoutes[index].stops} '
                                      ,
                                      style: TextStyle(
                                        color: kblack,
                                        fontSize: 14.0,
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
                                      'Fares ${fareList[index]}',
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
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
