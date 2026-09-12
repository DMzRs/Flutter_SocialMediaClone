import 'package:flutter_test/flutter_test.dart';
import 'package:ferrer_activty_6_socmed_clone/main.dart';

void main() {
  testWidgets('Ferrer Task 6 initial screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ferrer Task 6'), findsOneWidget);
    expect(find.text('TIKITOKTOK'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
