import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';


class MapPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapPage> {
  LocationData? _currentLocation;
  LocationData? _destination;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final location = Location();
    try {
      final currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Current Location',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Current Location'),
        ),
        body: _currentLocation != null
            ? FlutterMap(
                options: MapOptions(
                  center: LatLng(_currentLocation!.latitude!,
                      _currentLocation!.longitude!),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(_currentLocation!.latitude!,
                            _currentLocation!.longitude!),
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_on, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
