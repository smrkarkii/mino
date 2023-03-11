import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:kasarijaane/main.dart';
import './model/route_model.dart' as r;

import './api_service.dart';

import '../components/constants.dart';

r.RouteModel? routeModel; //jsonVehicle
List<dynamic> jsonVehicleOnly = []; //vehicle
List<dynamic> jsonRouteOnly = []; //routeonly

class MyLogic {
  String startingPoint;
  String destination;

  MyLogic({required this.startingPoint, required this.destination});

  List<dynamic> search() {
    dynamic data = routeModel!.vehicles;
    List<dynamic> route = [];
    List<dynamic> results = []; //add fares to it
    for (var datas in data) {
      for (var fare in datas.fares) {
        if (fare.startLocation
                .toLowerCase()
                .contains(startingPoint.toLowerCase()) &&
            fare.endLocation
                .toLowerCase()
                .contains(destination.toLowerCase())) {
          results.add(fare); //only fare model
          route.add(fare.route); // route of that vehicle
          break;
        }
      }
    }
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

    // print(routeModel);

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
  // void _getData() async {
  //   routeModel = await RouteService().getRoutes();

  //   setState(() {
  //     jsonVehicleOnly = routeModel!.vehicles;
  //   });
  // }

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

  // final List<Map<String, dynamic>> routeModel = [

  @override
  Widget build(BuildContext context) {
    // jsonVehicleOnly = routeModel!.vehicles;
    print(routeModel!.vehicles);
    if (routeModel != null) {
      jsonVehicleOnly = routeModel!.vehicles;
    }
    print(jsonVehicleOnly[0]);
    print(routeModel);

    for (var i in jsonVehicleOnly) {
      jsonRouteOnly.add(jsonVehicleOnly[0].routes);
    }

    MyLogic logic = MyLogic(startingPoint: 'a', destination: 'b');

    dynamic searchedObject = logic.search();

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
                      dynamic searchedRouteId = searchedObject.route;
                      dynamic searchedVehicleId =
                          jsonRouteOnly[searchedRouteId].vehicle;
                      var searchedvehicle = []; //vehicle name
                      var searchedlist = []; //routes

                      for (var vehicle in jsonVehicleOnly) {
                        searchedvehicle.add(vehicle[searchedVehicleId]);
                      }
                      for (var i in searchedvehicle) {
                        searchedlist.add(searchedvehicle[i].routes);
                      }
                      print('Searched List $searchedlist');
                      print('vehicle: $searchedvehicle');

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              'Vehicle $searchedvehicle[index].name ',
                              style: TextStyle(
                                color: kblack,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // onTap: () => Navigator.push(

                            //   context,

                            //   MaterialPageRoute(

                            //     builder: (context) => RouteDesc(vehicle1),

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
                                      'Fare $searchedObject[index].fare ',
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
                                      'Routes $searchedlist[index] ',
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



{
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
                    "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 1
                },
                {
                    "id": 2,
                    "name": "S2",
                    "starting_point": "G",
                    "final_point": "L",
                   "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 1
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
                {
                    "id": 11,
                    "start_location": "B",
                    "end_location": "E",
                    "fare": "20.00",
                    "route": 1
                },
                {
                    "id": 12,
                    "start_location": "C",
                    "end_location": "D",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 13,
                    "start_location": "C",
                    "end_location": "E",
                    "fare": "10.00",
                    "route": 1
                },
                {
                    "id": 14,
                    "start_location": "C",
                    "end_location": "F",
                    "fare": "15.00",
                    "route": 1
                },
                {
                    "id": 15,
                    "start_location": "D",
                    "end_location": "E",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 16,
                    "start_location": "D",
                    "end_location": "F",
                    "fare": "10.00",
                    "route": 1
                },
                {
                    "id": 17,
                    "start_location": "E",
                    "end_location": "F",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 21,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 2
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
                   "stops": [
                        "lagankhel":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "kumaripati":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "pulchowk":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "kupondole":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 2
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
        },
        {
            "id": 3,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 6,
                    "name": "nepalyatayat-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                    "stops": [
                        "lagankhel":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "kumaripati":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "pulchowk":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "kupondole":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 3
                }
            ],
            "fares": []
        },
        {
            "id": 4,
            "name": "Micro Bus",
            "type": "microbus",
            "routes": [
                {
                    "id": 4,
                    "name": "micro-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                   "stops": [
                        "lagankhel":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "kumaripati":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "pulchowk":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "kupondole":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 4
                }
            ],
            "fares": [
                {
                    "id": 22,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 4
                }
            ]
        },
        {
            "id": 5,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 3,
                    "name": "route1",
                    "starting_point": "balkumari",
                    "final_point": "sukedhara",
                    "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 5
                }
            ],
            "fares": [
                {
                    "id": 18,
                    "start_location": "sukedhara",
                    "end_location": "dhumbarahi",
                    "fare": "15.00",
                    "route": 3
                },
                {
                    "id": 19,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 3
                },
                {
                    "id": 20,
                    "start_location": "sukedhara",
                    "end_location": "dhumbarahi",
                    "fare": "15.00",
                    "route": 3
                }
            ]
        }
    ]
}

[
    {
        "id": 1,
        "name": "S1",
        "starting_point": "A",
        "final_point": "F",
       "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
        "vehicle": 1
    },
    {
        "id": 2,
        "name": "S2",
        "starting_point": "G",
        "final_point": "L",
       "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
        "vehicle": 1
    }
]



{
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
                    "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "vehicle": 1
                },
                {
                    "id": 2,
                    "name": "S2",
                    "starting_point": "G",
                    "final_point": "L",
                   "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "vehicle": 1
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
                {
                    "id": 11,
                    "start_location": "B",
                    "end_location": "E",
                    "fare": "20.00",
                    "route": 1
                },
                {
                    "id": 12,
                    "start_location": "C",
                    "end_location": "D",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 13,
                    "start_location": "C",
                    "end_location": "E",
                    "fare": "10.00",
                    "route": 1
                },
                {
                    "id": 14,
                    "start_location": "C",
                    "end_location": "F",
                    "fare": "15.00",
                    "route": 1
                },
                {
                    "id": 15,
                    "start_location": "D",
                    "end_location": "E",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 16,
                    "start_location": "D",
                    "end_location": "F",
                    "fare": "10.00",
                    "route": 1
                },
                {
                    "id": 17,
                    "start_location": "E",
                    "end_location": "F",
                    "fare": "5.00",
                    "route": 1
                },
                {
                    "id": 21,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 2
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
                  "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "vehicle": 2
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
        },
        {
            "id": 3,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 6,
                    "name": "nepalyatayat-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                    "stops": [
                        "lagankhel":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        }
                        "kumaripati":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        }
                        "pulchowk":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        }
                        "kupondole":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        }
                    ],
                    "vehicle": 3
                }
            ],
            "fares": []
        },
        {
            "id": 4,
            "name": "Micro Bus",
            "type": "microbus",
            "routes": [
                {
                    "id": 4,
                    "name": "micro-route1",
                    "starting_point": "lagankhel",
                    "final_point": "ratnapark",
                  "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "vehicle": 4
                }
            ],
            "fares": [
                {
                    "id": 22,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 4
                }
            ]
        },
        {
            "id": 5,
            "name": "Nepal Yatayat",
            "type": "bus",
            "routes": [
                {
                    "id": 3,
                    "name": "route1",
                    "starting_point": "balkumari",
                    "final_point": "sukedhara",
                   "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
                    "vehicle": 5
                }
            ],
            "fares": [
                {
                    "id": 18,
                    "start_location": "sukedhara",
                    "end_location": "dhumbarahi",
                    "fare": "15.00",
                    "route": 3
                },
                {
                    "id": 19,
                    "start_location": "sukedhara",
                    "end_location": "chappakkarkhana",
                    "fare": "15.00",
                    "route": 3
                },
                {
                    "id": 20,
                    "start_location": "sukedhara",
                    "end_location": "dhumbarahi",
                    "fare": "15.00",
                    "route": 3
                }
            ]
        }
    ]
}

[
    {
        "id": 1,
        "name": "S1",
        "starting_point": "A",
        "final_point": "F",
       "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
        "vehicle": 1
    },
    {
        "id": 2,
        "name": "S2",
        "starting_point": "G",
        "final_point": "L",
       "stops": [
                        "a":{
                          "lat":20,
                          "long":30,
                          "distance":0
                        },
                        "b":{
                          "lat":20,
                          "long":30,
                          "distance":10
                        },
                        "c":{
                          "lat":20,
                          "long":30,
                          "distance":20
                        },
                        "d":{
                          "lat":20,
                          "long":30,
                          "distance":30
                        },
                    ],
        "vehicle": 1
    }
]
}