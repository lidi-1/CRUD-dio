import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final TextEditingController
      taskController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<TaskBloc>().add(
          FetchTasksEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('TaskBrew'),
      ),

      floatingActionButton:
          FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          _showAddTaskDialog();
        },
      ),

      body: Column(

        children: [

          Padding(

            padding:
                const EdgeInsets.all(20),

            child: Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(
                      'Good Evening ☕',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 5),

                    const Text(
                      'Stay productive today',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    BlocBuilder<
                        TaskBloc,
                        TaskState>(

                      builder:
                          (context, state) {

                        if (state
                            is TaskLoadedState) {

                          final completed =
                              state.tasks
                                  .where(
                                    (
                                      task,
                                    ) =>
                                        task.completed,
                                  )
                                  .length;

                          return Container(

                            padding:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  14,
                              vertical: 8,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  const Color(
                                      0xFFC67C4E),

                              borderRadius:
                                  BorderRadius.circular(
                                      14),
                            ),

                            child: Text(

                              '$completed Completed Tasks',

                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),

                const CircleAvatar(

                  radius: 28,

                  backgroundColor:
                      Color(0xFFC67C4E),

                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(

            child: BlocBuilder<
                TaskBloc,
                TaskState>(

              builder:
                  (context, state) {

                if (state
                    is TaskLoadingState) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (state
                    is TaskErrorState) {

                  return Center(

                    child: Text(

                      state.message,

                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                      ),
                    ),
                  );
                }

                if (state
                    is TaskLoadedState) {

                  if (state
                      .tasks
                      .isEmpty) {

                    return const Center(

                      child: Text(

                        'No tasks available',

                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(

                    padding:
                        const EdgeInsets.all(
                            16),

                    itemCount:
                        state.tasks.length,

                    itemBuilder:
                        (context, index) {

                      final task =
                          state.tasks[index];

                      return Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),

                        padding:
                            const EdgeInsets.all(
                                16),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                                  0xFF1E1E1E),

                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),

                        child: Row(

                          children: [

                            Transform.scale(

                              scale: 1.1,

                              child: Checkbox(

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          50),
                                ),

                                value:
                                    task.completed,

                                activeColor:
                                    const Color(
                                        0xFFC67C4E),

                                onChanged:
                                    (_) {

                                  context
                                      .read<
                                          TaskBloc>()
                                      .add(
                                        ToggleTaskEvent(
                                            index),
                                      );
                                },
                              ),
                            ),

                            Expanded(

                              child:
                                  GestureDetector(

                                onTap: () {

                                  _showEditDialog(
                                    task.todo,
                                    index,
                                  );
                                },

                                child: Text(

                                  task.todo,

                                  style:
                                      TextStyle(

                                    color:
                                        Colors.white,

                                    fontSize:
                                        16,

                                    decoration:
                                        task.completed

                                            ? TextDecoration
                                                .lineThrough

                                            : null,
                                  ),
                                ),
                              ),
                            ),

                            IconButton(

                              onPressed:
                                  () {

                                context
                                    .read<
                                        TaskBloc>()
                                    .add(
                                      DeleteTaskEvent(
                                          index),
                                    );
                              },

                              icon:
                                  const Icon(

                                Icons.delete,

                                color:
                                    Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          backgroundColor:
              const Color(0xFF1E1E1E),

          title: const Text(

            'Add Task',

            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: TextField(

            controller: taskController,

            style: const TextStyle(
              color: Colors.white,
            ),

            decoration: InputDecoration(

              hintText:
                  'Enter task',

              hintStyle:
                  const TextStyle(
                color: Colors.grey,
              ),

              enabledBorder:
                  OutlineInputBorder(

                borderSide:
                    const BorderSide(
                  color: Colors.grey,
                ),

                borderRadius:
                    BorderRadius.circular(
                        12),
              ),

              focusedBorder:
                  OutlineInputBorder(

                borderSide:
                    const BorderSide(
                  color:
                      Color(0xFFC67C4E),
                ),

                borderRadius:
                    BorderRadius.circular(
                        12),
              ),
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                    context);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              onPressed: () {

                if (taskController
                    .text
                    .isNotEmpty) {

                  context
                      .read<TaskBloc>()
                      .add(
                        AddTaskEvent(
                          taskController
                              .text,
                        ),
                      );

                  taskController
                      .clear();

                  Navigator.pop(
                      context);
                }
              },

              child: const Text(
                'Add',
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
    String currentTask,
    int index,
  ) {

    final controller =
        TextEditingController(
      text: currentTask,
    );

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          backgroundColor:
              const Color(0xFF1E1E1E),

          title: const Text(

            'Edit Task',

            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: TextField(

            controller: controller,

            style: const TextStyle(
              color: Colors.white,
            ),

            decoration: InputDecoration(

              enabledBorder:
                  OutlineInputBorder(

                borderSide:
                    const BorderSide(
                  color: Colors.grey,
                ),

                borderRadius:
                    BorderRadius.circular(
                        12),
              ),

              focusedBorder:
                  OutlineInputBorder(

                borderSide:
                    const BorderSide(
                  color:
                      Color(0xFFC67C4E),
                ),

                borderRadius:
                    BorderRadius.circular(
                        12),
              ),
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                    context);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              onPressed: () {

                context
                    .read<TaskBloc>()
                    .add(
                      UpdateTaskEvent(
                        index,
                        controller.text,
                      ),
                    );

                Navigator.pop(
                    context);
              },

              child: const Text(
                'Update',
              ),
            ),
          ],
        );
      },
    );
  }
}