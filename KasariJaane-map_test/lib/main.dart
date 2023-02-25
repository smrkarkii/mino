import 'package:flutter/material.dart';
import 'package:kasarijaane/model/route_model.dart';
import 'package:kasarijaane/api_service.dart';
import 'package:kasarijaane/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<RouteModel>? routeModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    routeModel = (await ApiService().getRoutes());
    print(routeModel);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: routeModel == null || routeModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: routeModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text(routeModel![index].id.toString()),
                          Text(routeModel![index].startingPoint),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(routeModel![index].finalPoint),
                          Text(routeModel![index].checkpoints),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
