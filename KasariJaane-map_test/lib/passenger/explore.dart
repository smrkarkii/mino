import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../components/footer.dart';
import '../components/searchbar.dart';
import '../othercomp/horizontallist.dart';
import '../utils/places.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Explore',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                buildHorizontalList(context, 210.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Vehicles',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                buildHorizontalList(context, 150.0),
                SizedBox(
                  height: 20.0,
                ),
                SearchBar(label: "Search for pickup"),
                SizedBox(
                  height: 10.0,
                ),
                SearchBar(label: "Search for destination"),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildHorizontalList(BuildContext context, var height) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place, Sheight: height,);
        },
      ),
    );
  }
}
