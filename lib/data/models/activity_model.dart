import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required String id,
    required String title,
    required String type,
    required int durationMinutes,
    required double caloriesBurned,
    required DateTime date,
  }) : super(
          id: id,
          title: title,
          type: type,
          durationMinutes: durationMinutes,
          caloriesBurned: caloriesBurned,
          date: date,
        );

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      durationMinutes: map['durationMinutes'] ?? 0,
      caloriesBurned: (map['caloriesBurned'] ?? 0.0).toDouble(),
      date: DateTime.tryParse(map['date']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'durationMinutes': durationMinutes,
      'caloriesBurned': caloriesBurned,
      'date': date.toIso8601String(),
    };
  }
}
