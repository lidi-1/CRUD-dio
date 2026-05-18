import 'package:dio/dio.dart';

import '../models/task_model.dart';

class TaskService {

  final Dio dio = Dio();

  final String baseUrl =
      'https://dummyjson.com/todos';

  Future<List<Task>> fetchTasks() async {

    final response =
        await dio.get(baseUrl);

    final List todos =
        response.data['todos'];

    return todos.map((task) {

      return Task.fromJson(task);

    }).toList();
  }
}