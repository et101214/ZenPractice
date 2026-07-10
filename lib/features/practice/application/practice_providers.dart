import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zen_practice/core/providers/database_provider.dart';
import 'package:zen_practice/features/practice/application/practice_timer_controller.dart';
import 'package:zen_practice/features/practice/data/repositories/drift_practice_repository.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_session.dart';
import 'package:zen_practice/features/practice/domain/repositories/practice_repository.dart';

final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  return DriftPracticeRepository(ref.watch(appDatabaseProvider));
});

final practiceTimerProvider =
    StateNotifierProvider<PracticeTimerController, PracticeTimerState>((ref) {
  return PracticeTimerController();
});

final recentPracticeSessionsProvider =
    StreamProvider<List<PracticeSession>>((ref) {
  return ref.watch(practiceRepositoryProvider).watchRecentSessions();
});

final todayPracticeTotalProvider = StreamProvider<Duration>((ref) {
  return ref.watch(practiceRepositoryProvider).watchTodayTotal(DateTime.now());
});

final practiceSaveControllerProvider =
    AsyncNotifierProvider<PracticeSaveController, void>(
  PracticeSaveController.new,
);

class PracticeSaveController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> completeCurrentSession() async {
    final timer = ref.read(practiceTimerProvider);
    if (!timer.canComplete || timer.startedAt == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(practiceRepositoryProvider).saveSession(
            PracticeSession(
              id: null,
              type: timer.type,
              duration: timer.elapsed,
              startedAt: timer.startedAt!,
              completedAt: DateTime.now(),
            ),
          );
      ref.read(practiceTimerProvider.notifier).markCompleted();
      ref.read(practiceTimerProvider.notifier).reset();
    });
  }
}
