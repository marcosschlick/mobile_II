import 'package:flutter/material.dart';

import '../viewmodel/aula1_contador_view_model.dart';

// =============================================================================
// AULA 1 — CONTADOR (View em MVVM)
// =============================================================================
// Esta tela é a View do contador: ela só exibe o valor e repassa os toques
// pro ViewModel. O estado (counter) e a lógica (increment, decrement, etc.)
// estão no Aula1ContadorViewModel. A View escuta o ViewModel e reconstrói
// quando ele chama notifyListeners().
// =============================================================================

class Aula1ContadorPage extends StatefulWidget {
  const Aula1ContadorPage({super.key});

  @override
  State<Aula1ContadorPage> createState() => _Aula1ContadorPageState();
}

class _Aula1ContadorPageState extends State<Aula1ContadorPage> {
  final Aula1ContadorViewModel _viewModel = Aula1ContadorViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final counter = _viewModel.counter;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Contador de cliques'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Contagem atual:'),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: counter < 0 ? Colors.red : Colors.blue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'increment',
                onPressed: _viewModel.incrementCounter,
                tooltip: 'Increment',
                backgroundColor: Colors.green[100],
                child: const Icon(Icons.add, color: Colors.green),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'decrement',
                onPressed: _viewModel.decrementCounter,
                tooltip: 'Decrement',
                backgroundColor: Colors.red[100],
                child: const Icon(Icons.remove, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'multiply',
                onPressed: _viewModel.multiplyCounter,
                tooltip: 'Multiply',
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.close, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'divide',
                onPressed: _viewModel.divideCounter,
                tooltip: 'Divide',
                backgroundColor: Colors.orange[100],
                child: const Icon(Icons.percent, color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
