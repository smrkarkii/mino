import 'package:flutter/material.dart';
import 'package:kasarijaane/api_service.dart';
import 'package:kasarijaane/model/route_model.dart';
import '../components/footer.dart';
import '../components/constants.dart';
import '../components/searchbar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(label: 'Search for result'),
            OtherElements(),
          ],
        ),
      ),
    );
  }
}

class OtherElements extends StatefulWidget {
  OtherElements({Key? key}) : super(key: key);

  @override
  State<OtherElements> createState() => _OtherElementsState();
}

class _OtherElementsState extends State<OtherElements> {
  late List<RouteModel>? routeModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: routeModel!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(routeModel!.vehicles[index].name),
                                SizedBox(height: 8.0),
                                Text(routeModel[index]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage("https://picsum.photos/100"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
