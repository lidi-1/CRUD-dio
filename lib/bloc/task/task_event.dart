abstract class TaskEvent {}

class FetchTasksEvent
    extends TaskEvent {}

class AddTaskEvent
    extends TaskEvent {

  final String todo;

  AddTaskEvent(this.todo);
}

class DeleteTaskEvent
    extends TaskEvent {

  final int index;

  DeleteTaskEvent(this.index);
}

class ToggleTaskEvent
    extends TaskEvent {

  final int index;

  ToggleTaskEvent(this.index);
}
class UpdateTaskEvent
    extends TaskEvent {

  final int index;

  final String updatedTask;

  UpdateTaskEvent(
    this.index,
    this.updatedTask,
  );
}