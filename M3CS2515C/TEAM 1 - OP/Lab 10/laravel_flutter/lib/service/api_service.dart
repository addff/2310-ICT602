import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laravel_flutter/model/task_model.dart';


class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      try {
        if (response.body.isNotEmpty) {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((taskJson) => Task.fromJson(taskJson)).toList();
        } else {
          return [];
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        return [];
      }
    } else {
      throw Exception('Failed to load tasks. Status code: ${response.statusCode}');
    }
  }

  Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add task. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateTaskCompletion(int id, bool completed) async {
    final Map<String, dynamic> requestBody = {
      'completed': completed,
    };

    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Task completion status updated successfully
    } else {
      throw Exception('Failed to update task completion. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete task. Status code: ${response.statusCode}');
    }
  }
}
