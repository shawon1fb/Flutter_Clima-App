import 'package:http/http.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  var latitude;
  var longitude;

  Future getData() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    }
    else
      {
        print('Error :'+response.statusCode.toString());
      }
  }
}
