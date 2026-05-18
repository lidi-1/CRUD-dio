import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task_model.dart';
import '../../services/task_service.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc
    extends Bloc<TaskEvent, TaskState> {

  final TaskService taskService;

  List<Task> tasks = [];

  TaskBloc(this.taskService)
      : super(TaskInitialState()) {

    on<FetchTasksEvent>(_fetchTasks);

    on<AddTaskEvent>(_addTask);

    on<DeleteTaskEvent>(_deleteTask);

    on<ToggleTaskEvent>(_toggleTask);

    on<UpdateTaskEvent>(_updateTask);
  }

  Future<void> _fetchTasks(
    FetchTasksEvent event,
    Emitter<TaskState> emit,
  ) async {

    emit(TaskLoadingState());

    try {

      tasks =
          await taskService.fetchTasks();

      emit(
        TaskLoadedState(
          List.from(tasks),
        ),
      );

    } catch (e) {

      emit(
        TaskErrorState(
          e.toString(),
        ),
      );
    }
  }

  void _addTask(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) {

    final newTask = Task(

      id: tasks.length + 1,

      todo: event.todo,

      completed: false,
    );

    tasks.insert(0, newTask);

    emit(
      TaskLoadedState(
        List.from(tasks),
      ),
    );
  }

  void _deleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) {

    tasks.removeAt(event.index);

    emit(
      TaskLoadedState(
        List.from(tasks),
      ),
    );
  }

  void _toggleTask(
    ToggleTaskEvent event,
    Emitter<TaskState> emit,
  ) {

    final task =
        tasks[event.index];

    tasks[event.index] =
        task.copyWith(
      completed:
          !task.completed,
    );

    emit(
      TaskLoadedState(
        List.from(tasks),
      ),
    );
  }

  void _updateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) {

    final task =
        tasks[event.index];

    tasks[event.index] =
        task.copyWith(
      todo:
          event.updatedTask,
    );

    emit(
      TaskLoadedState(
        List.from(tasks),
      ),
    );
  }
}