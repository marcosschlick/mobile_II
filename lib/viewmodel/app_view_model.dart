import 'package:flutter/foundation.dart';

// =============================================================================
// APP VIEW MODEL (MVVM — Model/View/ViewModel)
// =============================================================================
// O ViewModel guarda o estado e a lógica da aplicação. A View (tela) só
// exibe os dados e manda ações pra cá. Quando algo muda, notifyListeners()
// avisa a View pra reconstruir. No nosso app, o único estado global é
// o "Raio-X" de acessibilidade (showSemanticsDebugger).
// =============================================================================

class AppViewModel extends ChangeNotifier {
  bool _mostrarRaioX = false;

  bool get mostrarRaioX => _mostrarRaioX;

  void alternarRaioX(bool valor) {
    if (_mostrarRaioX == valor) return;
    _mostrarRaioX = valor;
    notifyListeners();
  }
}
