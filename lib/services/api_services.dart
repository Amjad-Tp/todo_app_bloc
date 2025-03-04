import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

class ApiServices {
  final String baseUrl = "https://api.nstack.in/v1/todos";

  Future addTodo(String title, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer 2a6e5977-926f-4810-8c31-acd61b04666b',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'is_completed': false,
      }),
    );
    log(response.statusCode.toString());

    if (response.statusCode == 201) {
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add todo: ${response.body}');
    }
  }

  Future<List> fetchTodos() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer 2a6e5977-926f-4810-8c31-acd61b04666b',
          'Content-Type': 'application/json',
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final todoJson = jsonDecode(response.body) as Map;

        final result = todoJson['items'] as List;
        return result;
      } else {
        throw Exception('Failed to load todos ${response.body}');
      }
    } catch (e) {
      throw Exception('Network Error $e');
    }
  }

  Future updateTodo(String id, String title, String description) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {
        'Authorization': 'Bearer 2a6e5977-926f-4810-8c31-acd61b04666b',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'is_completed': false,
      }),
    );

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo: ${response.body}');
    }
  }

  Future deleteTodo(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
    }
  }
}
