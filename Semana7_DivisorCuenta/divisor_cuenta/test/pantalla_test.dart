import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:divisor_cuenta/main.dart';
import 'package:divisor_cuenta/presentation/divisor_controller.dart';
import 'package:divisor_cuenta/presentation/formateador_moneda.dart';
import 'package:divisor_cuenta/presentation/pantalla_divisor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

DivisorCuentaApp crearApp() {
  return DivisorCuentaApp(
    pantalla: PantallaDivisor(
      controller: DivisorController(
        validador: ValidarEntrada(),
        calculador: CalcularDivision(),
        redondeoExacto: RedondeoExacto(),
        redondeoHaciaArriba: RedondeoHaciaArriba(),
        formateador: FormateadorMoneda(),
      ),
    ),
  );
}

void main() {
  Future<void> completarFormulario(
    WidgetTester tester, {
    required String monto,
    required String personas,
    required String propina,
  }) async {
    await tester.pumpWidget(crearApp());
    await tester.enterText(find.byKey(const Key('monto')), monto);
    await tester.enterText(find.byKey(const Key('personas')), personas);
    await tester.enterText(find.byKey(const Key('propina')), propina);
    await tester.tap(find.text('Calcular'));
    await tester.pumpAndSettle();
  }

  testWidgets('calcula el reparto normal', (tester) async {
    await completarFormulario(
      tester,
      monto: '100',
      personas: '4',
      propina: '10',
    );

    expect(find.text('27.50'), findsOneWidget);
  });

  testWidgets('cero personas muestra error y no resultado', (tester) async {
    await completarFormulario(
      tester,
      monto: '50',
      personas: '0',
      propina: '0',
    );

    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(find.byKey(const Key('resultado')), findsNothing);
  });

  testWidgets('monto no numérico muestra error', (tester) async {
    await completarFormulario(
      tester,
      monto: 'abc',
      personas: '4',
      propina: '0',
    );

    expect(find.text('Monto inválido'), findsOneWidget);
    expect(find.byKey(const Key('resultado')), findsNothing);
  });
}
