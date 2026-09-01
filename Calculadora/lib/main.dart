import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuenta Clara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111827),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B5F),
          brightness: Brightness.dark,
        ),
        fontFamily: 'sans',
        useMaterial3: true,
      ),
      home: const TipCalculatorPage(),
    );
  }
}

class TipCalculator {
  const TipCalculator();

  TipResult calculate({
    required double bill,
    required double tipPercent,
    required int people,
  }) {
    if (bill < 0) {
      throw ArgumentError('La cuenta no puede ser negativa');
    }
    if (people < 1) {
      throw ArgumentError('Debe haber al menos una persona');
    }
    final tip = bill * tipPercent / 100;
    final total = bill + tip;
    return TipResult(tip: tip, total: total, perPerson: total / people);
  }
}

class TipResult {
  const TipResult({
    required this.tip,
    required this.total,
    required this.perPerson,
  });

  final double tip;
  final double total;
  final double perPerson;
}

class TipCalculatorPage extends StatefulWidget {
  const TipCalculatorPage({super.key});

  @override
  State<TipCalculatorPage> createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
  final _billController = TextEditingController();
  final _calculator = const TipCalculator();
  int _tipPercent = 10;
  int _people = 1;

  double get _bill =>
      double.tryParse(_billController.text.replaceAll(',', '.')) ?? 0;
  TipResult get _result => _calculator.calculate(
    bill: _bill,
    tipPercent: _tipPercent.toDouble(),
    people: _people,
  );

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  void _reset() {
    _billController.clear();
    setState(() {
      _tipPercent = 10;
      _people = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CUENTA CLARA',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Divide bien.',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _reset,
                      tooltip: 'Limpiar',
                      icon: const Icon(Icons.refresh_rounded),
                      style: IconButton.styleFrom(
                        foregroundColor: const Color(0xFFFF9B91),
                        backgroundColor: const Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _SectionLabel(label: 'TOTAL DE LA CUENTA'),
                const SizedBox(height: 10),
                TextField(
                  key: const Key('bill-input'),
                  controller: _billController,
                  onChanged: (_) => setState(() {}),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    prefixStyle: const TextStyle(
                      color: Color(0xFFFF9B91),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: '0.00',
                    hintStyle: const TextStyle(color: Color(0xFF4B5563)),
                    filled: true,
                    fillColor: const Color(0xFF1F2937),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                _SectionLabel(label: '¿CUÁNTO DEJAMOS?'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [5, 10, 15, 20, 25].map((percent) {
                    final selected = _tipPercent == percent;
                    return ChoiceChip(
                      label: Text('$percent%'),
                      selected: selected,
                      onSelected: (_) => setState(() => _tipPercent = percent),
                      labelStyle: TextStyle(
                        color: selected
                            ? const Color(0xFF111827)
                            : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      selectedColor: const Color(0xFFFF9B91),
                      backgroundColor: const Color(0xFF1F2937),
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionLabel(label: 'PERSONAS'),
                    Row(
                      children: [
                        _RoundButton(
                          icon: Icons.remove,
                          onPressed: _people > 1
                              ? () => setState(() => _people--)
                              : null,
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            '$_people',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _RoundButton(
                          icon: Icons.add,
                          onPressed: () => setState(() => _people++),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7F5E8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _ResultRow(label: 'Propina', value: result.tip),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Divider(color: Color(0xFFB9DDCE), height: 1),
                      ),
                      _ResultRow(
                        label: 'Total',
                        value: result.total,
                        large: true,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBCE9D8),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Por persona',
                              style: TextStyle(
                                color: Color(0xFF245747),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '\$${result.perPerson.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF163D32),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const Center(
                  child: Text(
                    'Los cálculos aparecen al instante',
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      color: Color(0xFF9CA3AF),
      fontSize: 11,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
    ),
  );
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: Icon(icon, size: 18),
    style: IconButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF374151),
      disabledForegroundColor: const Color(0xFF4B5563),
    ),
  );
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.label,
    required this.value,
    this.large = false,
  });
  final String label;
  final double value;
  final bool large;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: const Color(0xFF245747),
          fontSize: large ? 18 : 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        '\$${value.toStringAsFixed(2)}',
        style: TextStyle(
          color: const Color(0xFF163D32),
          fontSize: large ? 30 : 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    ],
  );
}
