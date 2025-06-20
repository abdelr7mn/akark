import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/property_model.dart';
import '../services/api_constants.dart';

class PropertyProvider with ChangeNotifier {
  List<Property> _properties = [];
  bool _isLoading = false;
  String _error = '';
  String? _authToken;

  List<Property> get properties => _properties;

  bool get isLoading => _isLoading;

  String get error => _error;

  void setAuthToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  Future<void> fetchProperties() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.properties),
        headers: {
          'Accept': 'application/json',
          if (_authToken != null) 'Authorization': 'Bearer $_authToken',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _properties = data.map((json) => Property.fromJson(json)).toList();
      } else {
        _error = 'خطأ في تحميل البيانات: ${response.statusCode}';
        if (kDebugMode) {
          print('API Error Response: ${response.body}');
        }
      }
    } on TimeoutException {
      _error = 'انتهت المهلة، يرجى التحقق من اتصال الإنترنت';
    } catch (e) {
      _error = 'حدث خطأ غير متوقع: ${e.toString()}';
      if (kDebugMode) {
        print('Error fetching properties: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(int propertyId) {
    final index = _properties.indexWhere((p) => p.id == propertyId);
    if (index != -1) {
      _properties[index].isFavorite = !_properties[index].isFavorite;
      notifyListeners();
    }
  }
}
