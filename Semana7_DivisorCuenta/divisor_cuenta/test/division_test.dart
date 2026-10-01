import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/cuenta.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';

import 'casos_de_prueba.dart';

void main() {
  final validar = ValidarEntrada();
  final calcular = CalcularDivision();
  final exacto = RedondeoExacto();
  final arriba = RedondeoHaciaArriba();

  for (final caso in casos) {
    test(caso.nombre, () {
      final cuenta = Cuenta(
        monto: caso.monto,
        personas: caso.personas,
        porcentajePropina: caso.propina,
      );
      expect(validar.validar(cuenta), caso.errorEsperado);

      if (caso.errorEsperado != null) {
        return;
      }

      final EstrategiaRedondeo estrategia =
          caso.modo == 'arriba' ? arriba : exacto;
      final resultado = calcular.calcular(cuenta, estrategia);
      expect(resultado.montoPorPersona, closeTo(caso.esperado!, 0.001));
    });
  }

  test('CalcularDivision acepta ambas estrategias sin conocer su tipo', () {
    const cuenta = Cuenta(monto: 10, personas: 3, porcentajePropina: 0);
    final EstrategiaRedondeo estrategiaExacta = exacto;
    final EstrategiaRedondeo estrategiaArriba = arriba;

    expect(calcular.calcular(cuenta, estrategiaExacta).montoPorPersona,
        closeTo(3.33, 0.001));
    expect(calcular.calcular(cuenta, estrategiaArriba).montoPorPersona,
        closeTo(4, 0.001));
  });
}
