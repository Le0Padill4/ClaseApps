import 'package:flutter/material.dart';

void main() {
  runApp(const DivisorCuentaApp());
}

class DivisorCuentaApp extends StatelessWidget {
  const DivisorCuentaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divisor de cuenta',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const PantallaDivisor(),
    );
  }
}

class PantallaDivisor extends StatefulWidget {
  const PantallaDivisor({super.key});

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _montoController = TextEditingController();
  final _personasController = TextEditingController();
  final _propinaController = TextEditingController(text: '0');
  String _modo = 'Exacto';
  String? _error;
  double? _resultado;

  @override
  void dispose() {
    _montoController.dispose();
    _personasController.dispose();
    _propinaController.dispose();
    super.dispose();
  }

  void _calcular() {
    final monto = double.tryParse(_montoController.text.trim());
    final personas = int.tryParse(_personasController.text.trim());
    final propina = double.tryParse(_propinaController.text.trim());

    setState(() {
      _resultado = null;
      _error = null;
      if (monto == null || !monto.isFinite || propina == null ||
          !propina.isFinite) {
        _error = 'Monto inválido';
        return;
      }
      if (personas == null || personas < 1) {
        _error = 'Debe haber al menos una persona';
        return;
      }
      final porPersona = monto * (1 + propina / 100) / personas;
      _resultado = _modo == 'Exacto'
          ? (porPersona * 100).round() / 100
          : porPersona.ceilToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Divisor de cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _montoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Monto total'),
          ),
          TextField(
            controller: _personasController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número de personas'),
          ),
          TextField(
            controller: _propinaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Propina (%)'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _modo,
            decoration: const InputDecoration(labelText: 'Redondeo'),
            items: const [
              DropdownMenuItem(value: 'Exacto', child: Text('Exacto')),
              DropdownMenuItem(
                value: 'Hacia arriba',
                child: Text('Hacia arriba al entero'),
              ),
            ],
            onChanged: (value) => setState(() => _modo = value ?? 'Exacto'),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _calcular, child: const Text('Calcular')),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!, key: const Key('mensaje-error')),
          ],
          if (_resultado != null) ...[
            const SizedBox(height: 16),
            Text(
              'Cada persona paga: ${_resultado!.toStringAsFixed(2)}',
              key: const Key('resultado'),
            ),
          ],
        ],
      ),
    );
  }
}
