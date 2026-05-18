import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/task/task_bloc.dart';
import 'screens/home_screen.dart';
import 'services/task_service.dart';

void main() {
  runApp(const TaskBrewApp());
}
class TaskBrewApp
    extends StatelessWidget {

  const TaskBrewApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) =>
          TaskBloc(TaskService()),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(

          scaffoldBackgroundColor:
              const Color(0xFF121212),

          appBarTheme: AppBarTheme(
            backgroundColor:
                const Color(0xFF1E1E1E),

            centerTitle: true,

            titleTextStyle:
                GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(
            backgroundColor:
                Color(0xFFC67C4E),
          ),
        ),

        home: const HomeScreen(),
      ),
    );
  }
}