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

    test('starts, pauses, and resets', () {
      final controller = PracticeTimerController();
      addTearDown(controller.dispose);

      controller.start();
      expect(controller.state.status, PracticeTimerStatus.running);
      expect(controller.state.startedAt, isNotNull);

      controller.pause();
      expect(controller.state.status, PracticeTimerStatus.paused);

      controller.reset();
      expect(controller.state.status, PracticeTimerStatus.idle);
      expect(controller.state.elapsed, Duration.zero);
      expect(controller.state.startedAt, isNull);
    });
  });
}
