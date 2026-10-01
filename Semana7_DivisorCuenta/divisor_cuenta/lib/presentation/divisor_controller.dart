import '../domain/calcular_division.dart';
import '../domain/cuenta.dart';
import '../domain/estrategia_redondeo.dart';
import '../domain/resultado.dart';
import '../domain/validar_entrada.dart';
import 'formateador_moneda.dart';

class DivisorController {
  final ValidarEntrada validador;
  final CalcularDivision calculador;
  final EstrategiaRedondeo redondeoExacto;
  final EstrategiaRedondeo redondeoHaciaArriba;
  final FormateadorMoneda formateador;

  String? mensajeError;
  Resultado? resultado;

  DivisorController({
    required this.validador,
    required this.calculador,
    required this.redondeoExacto,
    required this.redondeoHaciaArriba,
    required this.formateador,
  });

  String? calcular({
    required String monto,
    required String personas,
    required String propina,
    required bool haciaArriba,
  }) {
    resultado = null;
    mensajeError = null;
    final cuenta = Cuenta(
      monto: double.tryParse(monto.trim()) ?? double.nan,
      personas: int.tryParse(personas.trim()) ?? 0,
      porcentajePropina: double.tryParse(propina.trim()) ?? double.nan,
    );
    final error = validador.validar(cuenta);
    if (error != null) {
      mensajeError = error;
      return error;
    }

    resultado = calculador.calcular(
      cuenta,
      haciaArriba ? redondeoHaciaArriba : redondeoExacto,
    );
    return null;
  }

  String? get resultadoFormateado {
    final actual = resultado;
    return actual == null
        ? null
        : formateador.formatear(actual.montoPorPersona);
  }
}
