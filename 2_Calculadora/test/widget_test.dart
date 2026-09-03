import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora/main.dart';

void main() {
  test('calcula propina, total y monto por persona', () {
    const calculator = TipCalculator();
    final result = calculator.calculate(bill: 100, tipPercent: 15, people: 2);

    expect(result.tip, 15);
    expect(result.total, 115);
    expect(result.perPerson, 57.5);
  });

  testWidgets('actualiza el resultado al ingresar una cuenta', (tester) async {
    await tester.pumpWidget(const TipApp());

    await tester.enterText(find.byKey(const Key('bill-input')), '80');
    await tester.pump();

    expect(find.text('\$8.00'), findsOneWidget);
    expect(find.text('\$88.00'), findsNWidgets(2));
  });

  testWidgets('permite cambiar el porcentaje y dividir entre personas', (
    tester,
  ) async {
    await tester.pumpWidget(const TipApp());
    await tester.enterText(find.byKey(const Key('bill-input')), '100');
    await tester.tap(find.text('20%'));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('\$120.00'), findsOneWidget);
    expect(find.text('\$60.00'), findsOneWidget);
  });
}
