import 'package:flutter/material.dart';

import 'data/redondeo_exacto.dart';
import 'data/redondeo_hacia_arriba.dart';
import 'domain/calcular_division.dart';
import 'domain/validar_entrada.dart';
import 'presentation/divisor_controller.dart';
import 'presentation/formateador_moneda.dart';
import 'presentation/pantalla_divisor.dart';

void main() {
  final pantalla = PantallaDivisor(
    controller: DivisorController(
      validador: ValidarEntrada(),
      calculador: CalcularDivision(),
      redondeoExacto: RedondeoExacto(),
      redondeoHaciaArriba: RedondeoHaciaArriba(),
      formateador: FormateadorMoneda(),
    ),
  );
  runApp(DivisorCuentaApp(pantalla: pantalla));
}

class DivisorCuentaApp extends StatelessWidget {
  final PantallaDivisor pantalla;

  const DivisorCuentaApp({super.key, required this.pantalla});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divisor de cuenta',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: pantalla,
    );
  }
}
