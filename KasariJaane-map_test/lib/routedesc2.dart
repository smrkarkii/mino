import 'package:flutter/material.dart';

import 'components/constants.dart';
import './model/route_model.dart' as r;

import 'timeline.dart';

class RouteDescTwo extends StatelessWidget {
  r.Vehicle route;
  r.Vehicle? route1;
  RouteDescTwo({Key? key, required this.route, required this.route1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<r.Route> routed = route.routes;
    List<r.Route>? routed1 = route1 != null ? route1!.routes : null;
    // print(routed[0].stops);
    List<r.Stop> stops = [];
    List<r.Stop> stops1 = [];
    for (var addstop in routed[0].stops) {
      stops.add(addstop);
    }
    for (var addstop in routed1![0].stops) {
      stops1.add(addstop);
    }
    List getstopnames(List<r.Stop> stops) {
      List names = [];
      for (var stop in stops) {
        names.add(stop.name);
      }
      return names;
    }

    // print('stops : $stops');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ktheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(''),
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        backgroundColor: kwhite,
        body: Container(
          color: kgrey,
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${routed[0].name}',
                                style: TextStyle(
                                  color: ktheme,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Route: ${routed[0].id}',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Type: ${routed[0].name}',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Stops:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Indicator',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colors[1],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text('Start/End'),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colors[0],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text('Stops'),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colors[2],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text('Change Route'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  color: kwhite,
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  route.name,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Timeline(processCard: getstopnames(stops)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  route1!.name,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Timeline(processCard: getstopnames(stops1)),
                              ],
                            ),
                          )
                        ],
                      )),
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Text('Change the route.'),
                      //       Icon(Icons.change_circle_outlined)
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
// ListView.builder(
//                   itemCount: stops.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     // print('stops : $stops');
//                     return ListTile(
//                       leading: Icon(
//                         Icons.stop_circle_outlined,
//                         color: Colors.redAccent,
//                       ),
//                       title: Text(stops[index].name),
//                       trailing: Icon(
//                         Icons.arrow_downward,
//                         color: kblack,
//                       ),
//                     );
//                   },
//                 ),



// child: Row(
                
//                 children: [
//                   Expanded(
//                     child: Card(
//                       color: kwhite,
//                       child: Timeline.tileBuilder(
//                         builder: TimelineTileBuilder.fromStyle(
//                           contentsAlign: ContentsAlign.alternating,
//                           connectorStyle: ConnectorStyle.solidLine,
//                           contentsBuilder: (context, index) => Padding(
//                             padding: const EdgeInsets.all(24.0),
//                             child: Text(
//                               stops[index].name,
//                               style: TextStyle(
//                                   color: ktheme), // set the text color to orange
//                             ),
//                           ),
//                           itemCount: stops.length,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Card(
//                       color: kwhite,
//                       child: Timeline.tileBuilder(
//                         builder: TimelineTileBuilder.fromStyle(
//                           contentsAlign: ContentsAlign.alternating,
//                           connectorStyle: ConnectorStyle.solidLine,
//                           contentsBuilder: (context, index) => Padding(
//                             padding: const EdgeInsets.all(24.0),
//                             child: Text(
//                               stops1[index].name,
//                               style: TextStyle(
//                                   color: ktheme), // set the text color to orange
//                             ),
//                           ),
//                           itemCount: stops1.length,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
