class Funcionario {
  final int codigo;
  final int pulsacao;

  Funcionario({required this.codigo, required this.pulsacao});

  static Funcionario _fromString(String funcionario) {
    final _code = funcionario.split('	')[0];
    final _pulso = funcionario.split('	')[1];

    final _codigo = int.parse(_code);
    final _pulsacao = int.parse(_pulso);

    return Funcionario(codigo: _codigo, pulsacao: _pulsacao);
  }

  static List<Funcionario> fromList(List funcionarios) {
    List<Funcionario> _funcionarios = [];

    _funcionarios = funcionarios.map((e) => _fromString(e)).toList();

    return _funcionarios;
  }
}
