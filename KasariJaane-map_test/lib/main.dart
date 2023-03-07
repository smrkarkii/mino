import 'package:flutter/material.dart';
import './components/constants.dart';
import './components/searchbar.dart';
import './searchresult.dart';

import 'VehicleDesc.dart';
import 'menu/aboutus.dart';
import 'menu/news.dart';
import 'menu/notifications.dart';
import 'menu/profile.dart';
import 'menu/setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasari Jaane',
      theme: ThemeData(
        primaryColor: kdarkpurple,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: MyHomePage(),
    );
  }
}

class Vehicle {
  final String name;
  final IconData icon;

  Vehicle({required this.name, required this.icon});
}

List<Map<String, dynamic>> menuItems = [
  {
    'icon': Icons.person,
    'label': 'Profile',
    'widget': ProfilePage(),
  },
  {
    //todo add your location feature here
    'icon': Icons.map,
    'label': 'Find Routes',
    'widget': SearchResultPage(
      query: 'your location',
    ),
  },
  {
    'icon': Icons.library_books,
    'label': 'News',
    'widget': NewsPage(),
  },
  {
    'icon': Icons.notifications,
    'label': 'Notifications',
    'widget': NotificationPage(),
  },
  {
    'icon': Icons.info,
    'label': 'About Us',
    'widget': AboutUs(),
  },
];
List<Vehicle> vehicles = [
  Vehicle(name: 'Micro', icon: Icons.directions_car),
  Vehicle(name: 'Sajha Bus', icon: Icons.directions_bus),
  Vehicle(name: 'Pathao', icon: Icons.directions_bike),
  Vehicle(name: 'Tempo', icon: Icons.directions_railway),
];
List<String> places = [
  'Ratnapark-Buspark',
  'Buspark-Lagankhel',
  'Kalanki-Koteshwor',
  'Airport-Bhaktapur',
];

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      appBar: AppBar(
        title: Text('Kasari Jaane'),
        backgroundColor: kdarkpurple,
      ),
      drawer: Drawer(
        child: Container(
          height: 20,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kdarkpurple,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              for (var item in menuItems)
                ListTile(
                  leading: Icon(item['icon']),
                  title: Text(item['label']),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['widget'],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Where do you want to go?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SearchBar(label: 'Starting Point'),
            SearchBar(label: 'Destination'),
            Row(
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
            Expanded(
              child: Card(
                margin: EdgeInsets.all(5),
                color: kwhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      iconColor: kblack,
                      textColor: kblack,
                      leading: Icon(vehicles[index].icon),
                      title: Text(vehicles[index].name),
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VehicleDesc(vehicles[index]),
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(5),
                color: kwhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultPage(query: places[index]))),
                      iconColor: kblack,
                      textColor: kblack,
                      title: Text(places[index]),
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
