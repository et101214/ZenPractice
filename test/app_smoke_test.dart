import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_practice/app/zen_practice_app.dart';

void main() {
  testWidgets('shows ZenPractice home tab', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ZenPracticeApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('首頁'), findsWidgets);
    expect(find.text('禪院修行'), findsOneWidget);
  });
}
