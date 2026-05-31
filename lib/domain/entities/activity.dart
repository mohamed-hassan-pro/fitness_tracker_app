import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String id;
  final String title;
  final String type; // e.g., 'Running', 'Cycling', 'Weightlifting'
  final int durationMinutes;
  final double caloriesBurned;
  final DateTime date;

  const Activity({
    required this.id,
    required this.title,
    required this.type,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, type, durationMinutes, caloriesBurned, date];
}
