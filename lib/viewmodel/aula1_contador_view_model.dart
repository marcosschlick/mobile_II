import 'package:flutter/foundation.dart';

// =============================================================================
// AULA 1 — CONTADOR VIEW MODEL (MVVM)
// =============================================================================
// O estado do contador e as ações (incrementar, decrementar, etc.) ficam aqui.
// A View (Aula1ContadorPage) só lê viewModel.counter e chama viewModel.increment()
// quando o usuário toca. Quem segura a lógica é o ViewModel.
// =============================================================================

class Aula1ContadorViewModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  void multiply() {
    _counter *= 2;
    notifyListeners();
  }

  void divide() {
    _counter ~/= 2;
    notifyListeners();
  }
}
