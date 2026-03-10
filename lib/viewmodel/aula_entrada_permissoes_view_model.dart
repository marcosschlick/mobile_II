import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

// =============================================================================
// AULA ENTRADA E PERMISSÕES — VIEW MODEL (MVVM) — VERSÃO RESOLVIDA
// =============================================================================
// Esta é a versão completa usada pelo professor. A versão que os alunos recebem
// em aula (aula_entrada_permissoes_view_model.dart) esconde a lógica principal
// e marca pontos com // TODO para serem implementados.
// =============================================================================

class AulaEntradaPermissoesViewModel extends ChangeNotifier {
  AulaEntradaPermissoesViewModel() {
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
  }

  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;

  TextEditingController get nomeController => _nomeController;
  TextEditingController get emailController => _emailController;
  TextEditingController get telefoneController => _telefoneController;

  String _cameraStatus = 'Não verificado';
  String _locationStatus = 'Não verificado';
  bool _locationLoading = false;
  bool _cameraLoading = false;

  String get cameraStatus => _cameraStatus;
  String get locationStatus => _locationStatus;
  bool get locationLoading => _locationLoading;
  bool get cameraLoading => _cameraLoading;

  Future<void> requestCamera() async {
    _cameraLoading = true;
    _cameraStatus = 'Verificando...';
    notifyListeners();

    try {
      final status = await Permission.camera.status;
      if (status.isGranted) {
        _cameraStatus = 'Concedido';
      } else if (status.isDenied) {
        final result = await Permission.camera.request();
        _cameraStatus = result.isGranted ? 'Concedido' : 'Negado';
      } else {
        _cameraStatus = 'Negado (permanente ou indisponível)';
      }
    } catch (e) {
      _cameraStatus = 'Erro: $e';
    }

    _cameraLoading = false;
    notifyListeners();
  }

  Future<void> requestLocation() async {
    _locationLoading = true;
    _locationStatus = 'Solicitando...';
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationStatus = 'Serviço de localização desligado';
        _locationLoading = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        _locationStatus = 'Negado (sempre)';
      } else if (permission == LocationPermission.denied) {
        _locationStatus = 'Negado';
      } else {
        final pos = await Geolocator.getCurrentPosition();
        _locationStatus =
            'Concedido — ${pos.latitude.toStringAsFixed(4)}, ${pos.longitude.toStringAsFixed(4)}';
      }
    } catch (e) {
      _locationStatus = 'Erro: $e';
    }

    _locationLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }
}

