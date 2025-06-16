// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/property_model.dart';
//
// class PropertyService {
//   static const String baseUrl = 'https://localhost:7287/api/Properties';
//
//   static Future<List<Property>> fetchProperties() async {
//     final response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       final List jsonData = json.decode(response.body);
//       return jsonData.map((item) => Property.fromJson(item)).toList();
//     } else {
//       throw Exception('فشل في تحميل العقارات: ${response.statusCode}');
//     }
//   }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/property_model.dart';

class PropertyService {
  static const String baseUrl = 'https://aqqaraak.runasp.net/api';
  static const String propertiesEndpoint = '$baseUrl/Properties';

  static Future<List<Property>> fetchProperties() async {
    final response = await http.get(Uri.parse(propertiesEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Property.fromJson(json)).toList();
    } else {
      throw Exception('فشل في تحميل العقارات: ${response.statusCode}');
    }
  }
}
