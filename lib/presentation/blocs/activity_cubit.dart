import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/activity.dart';
import '../../domain/repositories/activity_repository.dart';

class ActivityCubit extends Cubit<List<Activity>> {
  final ActivityRepository repository;

  ActivityCubit({required this.repository}) : super([]);

  Future<void> loadActivities() async {
    try {
      final activities = await repository.getActivities();
      emit(activities);
    } catch (_) {
      emit([]);
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await repository.saveActivity(activity);
      await loadActivities();
    } catch (_) {}
  }

  Future<void> deleteActivity(String id) async {
    try {
      await repository.deleteActivity(id);
      await loadActivities();
    } catch (_) {}
  }
}
