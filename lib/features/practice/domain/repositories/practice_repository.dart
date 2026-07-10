import 'package:zen_practice/features/practice/domain/entities/practice_session.dart';

abstract interface class PracticeRepository {
  Future<int> saveSession(PracticeSession session);

  Stream<List<PracticeSession>> watchRecentSessions({int limit = 20});

  Stream<Duration> watchTodayTotal(DateTime day);
}
