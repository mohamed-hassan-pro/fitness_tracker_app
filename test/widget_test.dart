import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_app/data/models/activity_model.dart';

void main() {
  group('ActivityModel Tests', () {
    test('should convert from map and to map correctly', () {
      final now = DateTime.now();
      final model = ActivityModel(
        id: '1',
        title: 'Running',
        type: 'Run',
        durationMinutes: 30,
        caloriesBurned: 350.0,
        date: now,
      );

      final map = model.toMap();
      expect(map['id'], '1');
      expect(map['title'], 'Running');
      expect(map['type'], 'Run');
      expect(map['durationMinutes'], 30);
      expect(map['caloriesBurned'], 350.0);
      expect(map['date'], now.toIso8601String());

      final fromMap = ActivityModel.fromMap(map);
      expect(fromMap.id, model.id);
      expect(fromMap.title, model.title);
      expect(fromMap.type, model.type);
      expect(fromMap.durationMinutes, model.durationMinutes);
      expect(fromMap.caloriesBurned, model.caloriesBurned);
      expect(fromMap.date.day, model.date.day);
    });
  });
}
