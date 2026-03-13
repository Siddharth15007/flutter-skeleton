import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_template/configure.dart';
import 'package:flutter_bloc_template/main.dart' as app;

void main() {
  testWidgets('renders example skeleton screen', (tester) async {
    await configureDependencies();
    await app.main();
    await tester.pumpAndSettle();

    expect(find.text('Flutter BLoC Template'), findsWidgets);
    expect(find.text('Architecture Highlights'), findsOneWidget);
  });
}
