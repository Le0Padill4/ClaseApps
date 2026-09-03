import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador básico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF155EEF)),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _changeCount(int amount) {
    setState(() => _count += amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/contador.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Contador',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Text(
            '$_count',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: const Color.fromARGB(255, 21, 239, 86),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => _changeCount(-1),
                child: const Text(
                  '−',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () => _changeCount(1),
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => setState(() => _count = 0),
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    ),
  ),
);
  }
}
