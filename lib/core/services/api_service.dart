import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> getEnglishInsights(String word) async {
    String _backendEndpoint = "http://localhost:3000/api/insights/english";
    try {
      final response = await http.post(
        Uri.parse(_backendEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"word": word, "level": "B1"}),
      );

      if (response.statusCode == 429) {
        throw Exception("429");
      }

      if (response.statusCode != 200) {
        throw Exception("Server returned error: ${response.statusCode}");
      }

      final Map<String, dynamic> data = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
      return data['result'] ?? '';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getSinhalaInsights(String word) async {
    String _backendEndpoint = "http://localhost:3000/api/insights/sinhala";
    try {
      final response = await http.post(
        Uri.parse(_backendEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"word": word, "level": "B1"}),
      );

      if (response.statusCode == 429) {
        throw Exception("429");
      }

      if (response.statusCode != 200) {
        throw Exception("Server returned error: ${response.statusCode}");
      }

      final Map<String, dynamic> data = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
      return data['result'] ?? '';
    } catch (e) {
      rethrow;
    }
  }
}
