import 'package:flutter/material.dart';
import '../models/atracao.dart';

class FavoritesViewModel extends ChangeNotifier {
  final List<Atracao> _favoritos = [];

  List<Atracao> get favoritos => List.unmodifiable(_favoritos);

  void toggleFavorite(Atracao atracao) {
    if (_favoritos.contains(atracao)) {
      _favoritos.remove(atracao);
    } else {
      _favoritos.add(atracao);
    }
    notifyListeners();
  }

  bool isFavorite(Atracao atracao) {
    return _favoritos.contains(atracao);
  }
}
