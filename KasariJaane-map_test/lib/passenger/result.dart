import 'package:flutter/material.dart';
import '../components/footer.dart';
import '../components/constants.dart';
import '../components/searchbar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kgrey,
        body: SafeArea(
          child: Column(
            children: [
              SearchBar(label:'Search for result'),
              OtherElements(),
            ],
          ),
        ),);
  }
}

class OtherElements extends StatelessWidget {
  OtherElements({super.key});

  List<String> routeNames = [
    "Route 1",
    "Route 2",
    "Route 3",
    "Route 4",
    "Route 5"
  ];
  List<String> routeDetails = [
    "Location details 1",
    "Location details 2",
    "Location details 3",
    "Location details 4",
    "Location details 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
             children: [
               for (int i = 0; i < 5; i++)
                 Card(
                   child: Padding(
                     padding: EdgeInsets.all(16.0),
                     child: Row(
                       children: [
                         Icon(Icons.location_on),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(routeNames[i]),
                               SizedBox(height: 8.0),
                               Text(routeDetails[i]),
                             ],
                           ),
                         ),
                         Expanded(
                           child: Container(
                             height: 100.0,
                             width: 100.0,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage("https://picsum.photos/100"),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 )
             ],
                ),
            ),
      ),
    );
  }
}
