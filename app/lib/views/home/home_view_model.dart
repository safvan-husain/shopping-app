import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final List<String> _categorie = [
    'assets/images/men.png',
    'assets/images/women.png',
    'assets/images/kid.png',
  ];
  int get length => _categorie.length;
  List<String> get categories => _categorie;
}
