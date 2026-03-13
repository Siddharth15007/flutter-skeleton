import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_skeleton/configure.dart';
import 'package:flutter_skeleton/main.dart' as app;

void main() {
  testWidgets('renders example skeleton screen', (tester) async {
    await configureDependencies();
    await app.main();
    await tester.pumpAndSettle();

    expect(find.text('Flutter Skeleton'), findsWidgets);
    expect(find.text('Architecture Highlights'), findsOneWidget);
  });
}
