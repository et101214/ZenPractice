import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_practice/core/database/app_database.dart';
import 'package:zen_practice/features/practice/data/repositories/drift_practice_repository.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_session.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';

void main() {
  late AppDatabase database;
  late DriftPracticeRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftPracticeRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('stores sessions and calculates today total', () async {
    final day = DateTime(2026, 7, 10);

    await repository.saveSession(
      PracticeSession(
        id: null,
        type: PracticeType.meditation,
        duration: const Duration(minutes: 10),
        startedAt: day.add(const Duration(hours: 8)),
        completedAt: day.add(const Duration(hours: 8, minutes: 10)),
      ),
    );
    await repository.saveSession(
      PracticeSession(
        id: null,
        type: PracticeType.chanting,
        duration: const Duration(minutes: 5),
        startedAt: day.add(const Duration(days: 1, hours: 8)),
        completedAt: day.add(const Duration(days: 1, hours: 8, minutes: 5)),
      ),
    );

    final total = await repository.watchTodayTotal(day).first;

    expect(total, const Duration(minutes: 10));
  });

  test('returns recent sessions in reverse chronological order', () async {
    final firstCompletedAt = DateTime(2026, 7, 10, 8, 10);
    final secondCompletedAt = DateTime(2026, 7, 10, 9, 5);

    await repository.saveSession(
      PracticeSession(
        id: null,
        type: PracticeType.meditation,
        duration: const Duration(minutes: 10),
        startedAt: firstCompletedAt.subtract(const Duration(minutes: 10)),
        completedAt: firstCompletedAt,
      ),
    );
    await repository.saveSession(
      PracticeSession(
        id: null,
        type: PracticeType.scripture,
        duration: const Duration(minutes: 5),
        startedAt: secondCompletedAt.subtract(const Duration(minutes: 5)),
        completedAt: secondCompletedAt,
      ),
    );

    final sessions = await repository.watchRecentSessions().first;

    expect(sessions.map((session) => session.type), [
      PracticeType.scripture,
      PracticeType.meditation,
    ]);
  });

  test('returns pending sessions and marks them synced', () async {
    final id = await repository.saveSession(
      PracticeSession(
        id: null,
        type: PracticeType.focus,
        duration: const Duration(minutes: 3),
        startedAt: DateTime(2026, 7, 10, 10),
        completedAt: DateTime(2026, 7, 10, 10, 3),
      ),
    );

    final pendingBefore = await repository.getPendingSyncSessions();
    expect(pendingBefore.single.id, id);

    await repository.markSessionsSynced([id]);

    final pendingAfter = await repository.getPendingSyncSessions();
    expect(pendingAfter, isEmpty);
  });
}
