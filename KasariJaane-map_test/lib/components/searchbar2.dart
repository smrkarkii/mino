// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'constants.dart';
// import '../searchresult.dart';

// class SearchBar2 extends StatelessWidget {
//   SearchBar2({Key? key, required this.label, required this.controller})
//       : super(key: key);
//   String label;
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: kwhite,
//         border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           prefixIcon: Icon(
//             Icons.my_location,
//             color: kdarkblue,
//           ),
//           hintText: label,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.all(16.0),
//           // suffixIcon: Icon(
//           //   Icons.tune,
//           //   color: kdarkpurple,
//           // ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kasarijaane/main.dart';
import 'constants.dart';
import '../searchresult.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchBar2 extends StatelessWidget {
  SearchBar2({Key? key, required this.label, required this.controller})
      : super(key: key);
  String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kwhite,
          border: Border.all(color: ktheme),
        ),
        child: Column(children: [
          TypeAheadField(
            // controller:controller,
            animationStart: 0,
            animationDuration: Duration.zero,
            textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.my_location,
                      color: ktheme,
                    ),
                    labelText: "Enter your starting point")),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(color: kwhite),
            suggestionsCallback: (pattern) {
              List<String> matches = <String>[];
              matches.addAll(stopsOptions);

              matches.retainWhere((s) {
                return s.toLowerCase().contains(pattern.toLowerCase());
              });
              return matches;
            },
            itemBuilder: (context, sone) {
              return Card(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: Text(sone.toString()),
              ));
            },
            onSuggestionSelected: (suggestion) {
              print(suggestion);
              controller.text = suggestion;
            },
          )
        ]));
  }
}
