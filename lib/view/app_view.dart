import 'package:flutter/material.dart';

import '../viewmodel/app_view_model.dart';
import 'menu_page.dart';

// =============================================================================
// MY APP — View raiz (MVVM)
// =============================================================================
// A View só monta o MaterialApp e repassa o ViewModel pros filhos. O estado
// (mostrarRaioX) vive no AppViewModel; quando ele chama notifyListeners(),
// o setState aqui reconstrói a árvore e o valor atualizado vai pros filhos.
// =============================================================================

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppViewModel _appViewModel = AppViewModel();

  @override
  void initState() {
    super.initState();
    _appViewModel.addListener(_onAppViewModelChanged);
  }

  @override
  void dispose() {
    _appViewModel.removeListener(_onAppViewModelChanged);
    super.dispose();
  }

  void _onAppViewModelChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      // showSemanticsDebugger desenha na tela as regiões semânticas e o texto
      // que o TalkBack/VoiceOver falaria.
      showSemanticsDebugger: _appViewModel.mostrarRaioX,
      home: MenuPage(appViewModel: _appViewModel),
    );
  }
}
