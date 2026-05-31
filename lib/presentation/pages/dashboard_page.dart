import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/activity_cubit.dart';
import '../widgets/activity_chart.dart';
import 'add_activity_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<ActivityCubit>().loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text('Fitness Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ActivityCubit, List<dynamic>>(
        builder: (context, activities) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Calories Burned (Last 7 Activities)', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: ActivityChart(activities: activities.cast()),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Recent Activities', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final act = activities[index];
                      return Card(
                        color: Colors.white.withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.fitness_center, color: Colors.cyanAccent),
                          title: Text(act.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text('${act.type} • ${act.durationMinutes} min', style: const TextStyle(color: Colors.white70)),
                          trailing: Text('${act.caloriesBurned} kcal', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                          onLongPress: () => context.read<ActivityCubit>().deleteActivity(act.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add, color: Color(0xFF1E1E2C)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddActivityPage())),
      ),
    );
  }
}
