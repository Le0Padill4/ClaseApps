import 'cuenta.dart';
import 'estrategia_redondeo.dart';
import 'resultado.dart';

class CalcularDivision {
  Resultado calcular(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    final totalConPropina =
        cuenta.monto * (1 + cuenta.porcentajePropina / 100);
    final montoPorPersona = totalConPropina / cuenta.personas;
    return Resultado(
      montoPorPersona: estrategia.redondear(montoPorPersona),
    );
  }
}
