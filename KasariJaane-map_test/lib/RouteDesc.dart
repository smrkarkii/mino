import 'package:flutter/material.dart';

import 'components/constants.dart';

class RouteDesc extends StatelessWidget {
  final dynamic route;

  RouteDesc({Key? key, required this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> stops = [];
    if (route['stops'] is List) {
      stops = route['stops'];
    } else if (route['stops'] is Set) {
      stops = route['stops'].toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kdarkpurple,
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
              '${route['name']}',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Route: ${route['id']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Type: ${route['type']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Stops:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Card(
                child: ListView.builder(
                  itemCount: stops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(
                        Icons.stop_circle_outlined,
                        color: Colors.redAccent,
                      ),
                      title: Text(stops[index]),
                      trailing: Icon(
                        Icons.arrow_downward,
                        color: kblack,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
