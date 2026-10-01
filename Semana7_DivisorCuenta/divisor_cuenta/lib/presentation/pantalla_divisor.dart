import 'package:flutter/material.dart';

import 'divisor_controller.dart';

class PantallaDivisor extends StatefulWidget {
  final DivisorController controller;

  const PantallaDivisor({super.key, required this.controller});

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _montoController = TextEditingController();
  final _personasController = TextEditingController();
  final _propinaController = TextEditingController(text: '0');
  bool _haciaArriba = false;

  @override
  void dispose() {
    _montoController.dispose();
    _personasController.dispose();
    _propinaController.dispose();
    super.dispose();
  }

  void _calcular() {
    setState(() {
      widget.controller.calcular(
        monto: _montoController.text,
        personas: _personasController.text,
        propina: _propinaController.text,
        haciaArriba: _haciaArriba,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Divisor de cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            key: const Key('monto'),
            controller: _montoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Monto total'),
          ),
          TextField(
            key: const Key('personas'),
            controller: _personasController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número de personas'),
          ),
          TextField(
            key: const Key('propina'),
            controller: _propinaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Propina (%)'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<bool>(
            initialValue: _haciaArriba,
            decoration: const InputDecoration(labelText: 'Redondeo'),
            items: const [
              DropdownMenuItem(value: false, child: Text('Exacto')),
              DropdownMenuItem(
                value: true,
                child: Text('Hacia arriba al entero'),
              ),
            ],
            onChanged: (value) =>
                setState(() => _haciaArriba = value ?? false),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _calcular, child: const Text('Calcular')),
          if (controller.mensajeError case final error?) ...[
            const SizedBox(height: 16),
            Text(error),
          ],
          if (controller.resultadoFormateado case final valor?) ...[
            const SizedBox(height: 16),
            const Text('Cada persona paga:'),
            Text(valor, key: const Key('resultado')),
          ],
        ],
      ),
    );
  }
}
