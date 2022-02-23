import '../shared/enum_status_pulsacao.dart';

class Funcionario {
  final int codigo;
  final int pulsacao;
  final StatusPulsacao? statusPulsacao;
  final double erroAbsoluto;
  final double erroRelativo;
  final double diferencaTaxaValida;

  Funcionario({
    required this.codigo,
    required this.pulsacao,
    this.statusPulsacao,
    this.erroAbsoluto = 0,
    this.erroRelativo = 0,
    this.diferencaTaxaValida = 0,
  });

  Funcionario copyWith({
    int? codigo,
    int? pulsacao,
    StatusPulsacao? statusPulsacao,
    double? erroAbsoluto,
    double? erroRelativo,
    double? diferencaTaxaValida,
  }) {
    return Funcionario(
      codigo: codigo ?? this.codigo,
      pulsacao: pulsacao ?? this.pulsacao,
      statusPulsacao: statusPulsacao ?? this.statusPulsacao,
      erroAbsoluto: erroAbsoluto ?? this.erroAbsoluto,
      erroRelativo: erroRelativo ?? this.erroRelativo,
      diferencaTaxaValida: diferencaTaxaValida ?? this.diferencaTaxaValida,
    );
  }

  static Funcionario _fromString(String funcionario) {
    final _code = funcionario.split('	')[0];
    final _pulso = funcionario.split('	')[1];

    final _codigo = int.parse(_code);
    final _pulsacao = int.parse(_pulso);

    return Funcionario(
      codigo: _codigo,
      pulsacao: _pulsacao,
    );
  }

  static List<Funcionario> fromList(List funcionarios) {
    List<Funcionario> _funcionarios = [];

    _funcionarios = funcionarios.map((e) => _fromString(e)).toList();

    return _funcionarios;
  }
}
