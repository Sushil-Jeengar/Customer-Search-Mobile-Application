import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import '../models/customer.dart';

class ApiService {
  static const String baseUrl = "http://192.168.29.44:3001/customers";

  static Future<List<Customer>> searchCustomers({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
  }) async {
    try {

      var uri = Uri.parse(baseUrl);


      if ((firstName?.isEmpty ?? true) &&
          (lastName?.isEmpty ?? true) &&
          (dateOfBirth?.isEmpty ?? true)) {
        uri = uri.replace(queryParameters: {'_limit': '100'});
      }

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Customer> customers = data
            .map((c) => Customer.fromJson(c))
            .toList();


        return customers.where((customer) {
          bool matches = true;


          if (firstName?.isNotEmpty ?? false) {
            matches =
                matches &&
                (customer.firstName?.toLowerCase().contains(
                      firstName!.toLowerCase(),
                    ) ??
                    false);
          }


          if (lastName?.isNotEmpty ?? false) {
            matches =
                matches &&
                (customer.lastName?.toLowerCase().contains(
                      lastName!.toLowerCase(),
                    ) ??
                    false);
          }


          if (dateOfBirth?.isNotEmpty ?? false) {
            matches = matches && (customer.dateOfBirth == dateOfBirth);
          }

          return matches;
        }).toList();
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (e) {
      print('Error in searchCustomers: $e');
      throw Exception('Network error: $e');
    }
  }


  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}
