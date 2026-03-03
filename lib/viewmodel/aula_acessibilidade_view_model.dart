// =============================================================================
// AULA ACESSIBILIDADE — VIEW MODEL (MVVM)
// =============================================================================
// Nesta tela o estado que importa (mostrarRaioX) vem do AppViewModel. O
// ViewModel da aula só guarda esse valor e o callback pra alternar — a
// "lógica" está no app. A View (AulaAcessibilidadePage) só exibe e repassa
// os toques. É um ViewModel fino porque a tela é basicamente estática.
// =============================================================================

class AulaAcessibilidadeViewModel {
  const AulaAcessibilidadeViewModel({
    required this.mostrarRaioX,
    required this.aoAlternarRaioX,
  });

  final bool mostrarRaioX;
  final void Function(bool) aoAlternarRaioX;
}
