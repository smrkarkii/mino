import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kasarijaane/components/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import '../components/searchbar.dart';
import './passenger/map.dart';

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {


  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: kgrey,
      body: Column(
        children: [
          Flexible(
            child: MapPage(),
          ),
          SearchBar(
            label: 'Search for pickup',
          ),
          SearchBar(
            label: 'Search for destination',
          ),
        ],
      ),
    );
  }
}

