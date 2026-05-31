import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/activity_repository_impl.dart';
import 'presentation/blocs/activity_cubit.dart';
import 'presentation/pages/dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = ActivityRepositoryImpl();

  runApp(FitnessApp(repository: repository));
}

class FitnessApp extends StatelessWidget {
  final ActivityRepositoryImpl repository;

  const FitnessApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityCubit>(create: (context) => ActivityCubit(repository: repository)),
      ],
      child: MaterialApp(
        title: 'Fitness Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E2C),
          primaryColor: Colors.cyanAccent,
          colorScheme: const ColorScheme.dark().copyWith(primary: Colors.cyanAccent, secondary: Colors.cyanAccent),
        ),
        home: const DashboardPage(),
      ),
    );
  }
}
