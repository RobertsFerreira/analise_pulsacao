// void main() {
//   final entries = [1, 2, 3, 4, 5, 6];

//   final vp = valorProvavel(entries);

//   final eA = erroAbsoluto(vp);

//   final double eR = erroRelativo(vp, eA);

//   print(eR.toStringAsFixed(2));
// }

import '../models/funcionario.dart';

valorProvavel(List<Funcionario> entries) {
  double _media = 0;

  for (var entrie in entries) {
    _media += entrie.pulsacao;
  }

  _media = _media / entries.length;

  return _media;
}

// erroAbsoluto(double vp){
  
//   int vm = vp~/1;
  
//   final abs = vp - vm;
  
//   return abs;
// }


// erroRelativo(double vp, double erroAbsoluto){
  
//   final eR = erroAbsoluto/vp;
  
//   return eR * 100;
  
// }