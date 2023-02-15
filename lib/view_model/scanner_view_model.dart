import 'package:flutter/cupertino.dart';

class ScannerViewModel with ChangeNotifier {
  String _tes = 'kosong';
  String get stringTest => _tes;

  setTest(String value) {
    _tes = value;
    notifyListeners();
  }
}
