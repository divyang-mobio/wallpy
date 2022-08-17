import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/articles_model.dart';

class HttpService {
  Future<List<Articles>> getData(String url) async {
    print("object");
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body.toString());
      print(responseJson);
      if (responseJson["status"] == "ok") {
        List<dynamic> rawData = responseJson["articles"];
        List<Articles> data = rawData.map((e) => Articles.fromJson(e)).toList();
        return data;
      } else {
        throw "api is not working";
      }
    } else {
      throw "error";
    }
  }
}
