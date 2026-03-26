import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

// =============================================================================
// AULA 1.5 — MAPAS E GEOLOCALIZAÇÃO — VIEW MODEL (MVVM) — VERSÃO EXERCÍCIO
// =============================================================================
// O ViewModel guarda a posição atual (lat/lng) e o estado de carregamento/erro.
// A lógica de obter a localização do usuário fica aqui; na View só exibimos o
// mapa e reagimos ao estado. No Flutter Web o navegador pede permissão de
// localização (igual à aula de permissões).
// =============================================================================

class AulaMapasGeolocalizacaoViewModel extends ChangeNotifier {
  /// Centro inicial do mapa (ex.: Brasil) até o usuário clicar em "Minha localização".
  static const LatLng centroInicialPadrao = LatLng(-23.5505, -46.6333);

  LatLng? _posicaoAtual;
  bool _loading = false;
  String? _mensagemErro;

  List<LatLng> _pontosRota = [];
  bool _rotaLoading = false;
  String? _rotaErro;

  LatLng? get posicaoAtual => _posicaoAtual;
  bool get loading => _loading;
  String? get mensagemErro => _mensagemErro;
  List<LatLng> get pontosRota => _pontosRota;
  bool get rotaLoading => _rotaLoading;
  String? get rotaErro => _rotaErro;

  /// Chamado quando o usuário toca em "Minha localização".
  /// Deve obter a posição via Geolocator, atualizar _posicaoAtual (ou _mensagemErro)
  /// e chamar notifyListeners().
  Future<void> obterMinhaLocalizacao() async {
    _loading = true;
    _mensagemErro = null;
    notifyListeners();

    // TODO: implementar obtenção da localização atual.
    // Dicas:
    // 1. Verificar se o serviço de localização está habilitado
    //    (Geolocator.isLocationServiceEnabled).
    // 2. Verificar/solicitar permissão (Geolocator.checkPermission e
    //    Geolocator.requestPermission).
    // 3. Obter a posição com Geolocator.getCurrentPosition().
    // 4. Converter para LatLng: LatLng(position.latitude, position.longitude)
    //    e guardar em _posicaoAtual.
    // 5. Em caso de erro (catch), guardar a mensagem em _mensagemErro.
    // 6. Ao final, _loading = false e notifyListeners().
    //
    // Não esquecer o import: import 'package:geolocator/geolocator.dart';
    try {
      // 1. Verifica se o serviço de localização está ativo
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _mensagemErro = 'Serviço de localização desligado';
        _loading = false;
        notifyListeners();
        return;
      }

      // 2. Verifica / solicita permissão
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        _mensagemErro = 'Permissão negada permanentemente';
        _loading = false;
        notifyListeners();
        return;
      }
      if (permission == LocationPermission.denied) {
        _mensagemErro = 'Permissão negada';
        _loading = false;
        notifyListeners();
        return;
      }

      // 3. Obtém a posição atual
      final position = await Geolocator.getCurrentPosition();
      _posicaoAtual = LatLng(position.latitude, position.longitude);
    } catch (e) {
      _mensagemErro = 'Erro: $e';
    }

    _loading = false;
    notifyListeners();
  }

  /// Chamado quando o usuário define origem/destino e toca em "Rota até".
  /// Deve chamar a API OSRM (GET com os dois pontos), parsear a resposta,
  /// preencher _pontosRota com a lista de LatLng da geometria e chamar notifyListeners().
  Future<void> buscarRota(LatLng origem, LatLng destino) async {
    _rotaLoading = true;
    _rotaErro = null;
    _pontosRota = [];
    notifyListeners();

    // TODO: implementar obtenção da rota via OSRM.
    // Dicas:
    // 1. Montar a URL: https://router.project-osrm.org/route/v1/driving/
    //    {lngOrigem},{latOrigem};{lngDestino},{latDestino}?overview=full&geometries=geojson
    //    (OSRM usa longitude,latitude na URL).
    // 2. Fazer GET com o pacote http (import 'package:http/http.dart' as http).
    // 3. Parsear o JSON: response.body → jsonDecode → routes[0].geometry.coordinates.
    //    Cada item é [longitude, latitude]; converter para LatLng(lat, lng).
    // 4. Atribuir a lista a _pontosRota. Em erro (status != 200 ou exceção), setar _rotaErro.
    // 5. _rotaLoading = false e notifyListeners().

    try {
      // Monta a URL para a API OSRM (longitude,latitude)
      final lng1 = origem.longitude;
      final lat1 = origem.latitude;
      final lng2 = destino.longitude;
      final lat2 = destino.latitude;
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '$lng1,$lat1;$lng2,$lat2?overview=full&geometries=geojson',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) {
        _rotaErro = 'OSRM retornou ${response.statusCode}';
        _rotaLoading = false;
        notifyListeners();
        return;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final routes = data['routes'] as List<dynamic>?;
      if (routes == null || routes.isEmpty) {
        _rotaErro = 'Nenhuma rota encontrada';
        _rotaLoading = false;
        notifyListeners();
        return;
      }

      final geometry = routes[0]['geometry'] as Map<String, dynamic>?;
      final coords = geometry?['coordinates'] as List<dynamic>?;
      if (coords == null || coords.isEmpty) {
        _rotaErro = 'Geometria da rota vazia';
        _rotaLoading = false;
        notifyListeners();
        return;
      }

      // Converte [longitude, latitude] para LatLng(latitude, longitude)
      _pontosRota = coords.map((c) {
        final list = c as List<dynamic>;
        final lng = (list[0] as num).toDouble();
        final lat = (list[1] as num).toDouble();
        return LatLng(lat, lng);
      }).toList();
    } catch (e) {
      _rotaErro = 'Erro: $e';
    }

    _rotaLoading = false;
    notifyListeners();
  }
}
