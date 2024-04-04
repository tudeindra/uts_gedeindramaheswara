import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Halaman Utama'), findsOneWidget);
    expect(find.text('Halaman Kedua'), findsNothing);

    // Tap the 'Halaman Kedua' button and trigger a frame.
    await tester.tap(find.text('Halaman Kedua'));
    await tester.pump();

    // Verify that we're on the second page.
    expect(find.text('Halaman Kedua'), findsOneWidget);
    expect(find.text('Halaman Utama'), findsNothing);
  });
}
