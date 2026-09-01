import 'package:flutter_test/flutter_test.dart';

import 'package:contador_flutter/main.dart';

void main() {
  testWidgets('el contador suma, resta y se reinicia', (tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('−'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('Reiniciar'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
