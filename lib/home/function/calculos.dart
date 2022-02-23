// void main() {
//   final entries = [1, 2, 3, 4, 5, 6];

//   final vp = valorProvavel(entries);

//   final eA = erroAbsoluto(vp);

//   final double eR = erroRelativo(vp, eA);

//   print(eR.toStringAsFixed(2));
// }

import '../models/funcionario.dart';

double valorProvavel(List<Funcionario> funcionarios) {
  double _media = 0;
  if (funcionarios.isNotEmpty) {
    for (var funcionario in funcionarios) {
      _media += funcionario.pulsacao;
    }

    _media = _media / funcionarios.length;
  }

  return _media;
}

erroAbsoluto(double vp, {int? pulsacao}) {
  double abs = 0;
  if (pulsacao == null) {
    int vm = vp ~/ 1;
    abs = vp - vm;
  } else {
    abs = vp - pulsacao;
    if (abs < 0) {
      abs *= -1;
    }
  }

  return abs;
}

erroRelativo(double vp, double erroAbsoluto) {
  if (vp > 0) {
    final eR = erroAbsoluto / vp;

    return eR * 100;
  }
  return 0.0;
}

Map<String, double> calculoMargem() {
  const int valorBase = 70;
  const double porcentagem = 0.11;

  const double _margem = valorBase * porcentagem;

  const limiteMin = valorBase - _margem;

  const limiteMax = valorBase + _margem;

  final result = <String, double>{
    'limiteMin': limiteMin,
    'limiteMax': limiteMax,
  };

  return result;
}
