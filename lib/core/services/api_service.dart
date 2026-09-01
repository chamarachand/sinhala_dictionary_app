import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sinhala_dictionary_app/core/errors/exceptions.dart';

class ApiService {
  Future<String> getEnglishInsights(String word) async {
    String backendEndpoint = "http://localhost:3000/api/insights/english";

    try {
      final response = await http
          .post(
            Uri.parse(backendEndpoint),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"word": word, "level": "B1"}),
          )
          .timeout(Duration(seconds: 10));

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        return data['result'] ?? '';
      } else if (statusCode == 429) {
        throw LimitExceedException();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw NetworkException('Request timed out. Please check your connection');
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknownException();
    }
  }

  Future<String> getSinhalaInsights(String word) async {
    String backendEndpoint = "http://localhost:3000/api/insights/sinhala";

    try {
      final response = await http
          .post(
            Uri.parse(backendEndpoint),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"word": word, "level": "B1"}),
          )
          .timeout(Duration(seconds: 10));

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        return data['result'] ?? '';
      } else if (statusCode == 429) {
        throw LimitExceedException();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw NetworkException('Request timed out. Please check your connection');
    } on AppException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
