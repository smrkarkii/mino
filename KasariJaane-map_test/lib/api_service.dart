import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kasarijaane/constants.dart';
import 'package:kasarijaane/model/route_model.dart';

class ApiService {
  Future<List<RouteModel>?> getRoutes() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.routesEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<RouteModel> _model = routeModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
