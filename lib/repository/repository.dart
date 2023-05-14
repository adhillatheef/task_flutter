import 'dart:convert';

import '../model/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const _todosUrl = '$_baseUrl/todos';

  Future<List<Todo>> fetchTodos(int startIndex, int limit) async {
    final response = await http.get(Uri.parse('$_todosUrl?_start=$startIndex&_limit=$limit'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      return json.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }
}