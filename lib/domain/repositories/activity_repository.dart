import '../entities/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> saveActivity(Activity activity);
  Future<void> deleteActivity(String id);
}
