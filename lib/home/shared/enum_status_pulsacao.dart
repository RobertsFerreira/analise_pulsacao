import 'package:flutter/material.dart';

enum StatusPulsacao {
  abaixoMedia,
  naMedia,
  acimaMedia,
}

extension EnumStatusPulsacaoString on StatusPulsacao {
  String get toText {
    switch (this) {
      case StatusPulsacao.acimaMedia:
        return 'Acima da Média';
      case StatusPulsacao.naMedia:
        return 'Na Média';
      case StatusPulsacao.abaixoMedia:
        return 'Abaixo da Média';
      default:
        return 'Unknown';
    }
  }

  Color get colorStatus {
    switch (this) {
      case StatusPulsacao.acimaMedia:
        return Colors.yellow;
      case StatusPulsacao.naMedia:
        return Colors.green;
      case StatusPulsacao.abaixoMedia:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
