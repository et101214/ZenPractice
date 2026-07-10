import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';

class PracticeSession {
  const PracticeSession({
    required this.id,
    required this.type,
    required this.duration,
    required this.startedAt,
    required this.completedAt,
    this.isSynced = false,
  });

  final int? id;
  final PracticeType type;
  final Duration duration;
  final DateTime startedAt;
  final DateTime completedAt;
  final bool isSynced;
}
