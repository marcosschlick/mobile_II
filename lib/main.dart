import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'view/app_view.dart';

// =============================================================================
// PONTO DE ENTRADA — todo app Flutter começa no main()
// =============================================================================
void main() {
  runApp(const MyApp());
  // No Flutter Web a acessibilidade é opt-in. Isso ativa a árvore de semântica
  // no DOM para leitores de tela e DevTools (Chrome → Elements → Accessibility).
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}
