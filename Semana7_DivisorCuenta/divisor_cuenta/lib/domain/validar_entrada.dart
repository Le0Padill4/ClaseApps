import 'cuenta.dart';

class ValidarEntrada {
  String? validar(Cuenta cuenta) {
    if (!cuenta.monto.isFinite) {
      return 'Monto inválido';
    }
    if (cuenta.personas < 1) {
      return 'Debe haber al menos una persona';
    }
    if (!cuenta.porcentajePropina.isFinite) {
      return 'Propina inválida';
    }
    return null;
  }
}
