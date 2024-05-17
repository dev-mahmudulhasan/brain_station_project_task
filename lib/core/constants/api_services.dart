import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../features/repos/data/repodata_model.dart';
 
class ApiService {
  final String baseUrl = "https://api.github.com";

  Future<List<Repository>> fetchRepositories(String query, int page, int perPage) async {
    final response = await http.get(Uri.parse('$baseUrl/search/repositories?q=$query&sort=stars&order=desc&page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];
      return items.map((item) => Repository.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}

