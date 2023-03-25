import 'package:flutter/material.dart';

import 'components/constants.dart';
import './model/route_model.dart' as r;

import 'package:timelines/timelines.dart';

class RouteDesc extends StatelessWidget {
  r.Vehicle route;
  r.Vehicle? route1;
  RouteDesc({Key? key, required this.route, required this.route1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<r.Route> routed = route.routes;
    List<r.Route> routed1 = route1!.routes;
    // print(routed[0].stops);
    List<r.Stop> stops = [];
    List<r.Stop> stops1 = [];
    for (var addstop in routed[0].stops) {
      stops.add(addstop);
    }
    for (var addstop in routed1[0].stops) {
      stops1.add(addstop);
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
      backgroundColor: kgrey,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${route.name}',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Route: ${route.id}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Type: ${route.type}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Stops:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Timeline.tileBuilder(
                        builder: TimelineTileBuilder.fromStyle(
                          contentsAlign: ContentsAlign.alternating,
                          connectorStyle: ConnectorStyle.solidLine,
                          contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              stops[index].name,
                              style: TextStyle(
                                  color: Colors
                                      .orange), // set the text color to orange
                            ),
                          ),
                          itemCount: stops.length,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Timeline.tileBuilder(
                        builder: TimelineTileBuilder.fromStyle(
                          contentsAlign: ContentsAlign.alternating,
                          connectorStyle: ConnectorStyle.solidLine,
                          contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              stops1[index].name,
                              style: TextStyle(
                                  color: Colors
                                      .orange), // set the text color to orange
                            ),
                          ),
                          itemCount: stops1.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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