import 'package:flutter_test/flutter_test.dart';
import 'package:zen_practice/features/practice/application/practice_timer_controller.dart';
import 'package:zen_practice/features/practice/domain/entities/practice_type.dart';

void main() {
  group('PracticeTimerController', () {
    test('selects practice type while idle', () {
      final controller = PracticeTimerController();
      addTearDown(controller.dispose);

      controller.selectType(PracticeType.chanting);

      expect(controller.state.type, PracticeType.chanting);
      expect(controller.state.status, PracticeTimerStatus.idle);
    });

    test('uses actual elapsed time and preserves paused duration', () {
      var now = DateTime(2026, 7, 10, 9);
      final controller = PracticeTimerController(now: () => now);
      addTearDown(controller.dispose);

      controller.start();
      now = now.add(const Duration(seconds: 7));
      controller.refreshElapsed();

      expect(controller.state.elapsed, const Duration(seconds: 7));

      controller.pause();
      now = now.add(const Duration(minutes: 2));
      controller.start();
      now = now.add(const Duration(seconds: 5));
      controller.refreshElapsed();

      expect(controller.state.elapsed, const Duration(seconds: 12));
    });

    test('reset clears active session state', () {
      final controller = PracticeTimerController();
      addTearDown(controller.dispose);

      controller.start();
      controller.pause();
      controller.reset();

      expect(controller.state.status, PracticeTimerStatus.idle);
      expect(controller.state.elapsed, Duration.zero);
      expect(controller.state.startedAt, isNull);
    });
  });
}
