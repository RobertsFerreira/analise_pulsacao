// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<Map<String, dynamic>>? _$valorErroGeralComputed;

  @override
  Map<String, dynamic> get valorErroGeral => (_$valorErroGeralComputed ??=
          Computed<Map<String, dynamic>>(() => super.valorErroGeral,
              name: '_HomeControllerBase.valorErroGeral'))
      .value;

  final _$errorAtom = Atom(name: '_HomeControllerBase.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$erroMessageAtom = Atom(name: '_HomeControllerBase.erroMessage');

  @override
  String get erroMessage {
    _$erroMessageAtom.reportRead();
    return super.erroMessage;
  }

  @override
  set erroMessage(String value) {
    _$erroMessageAtom.reportWrite(value, super.erroMessage, () {
      super.erroMessage = value;
    });
  }

  final _$funcionariosAtom = Atom(name: '_HomeControllerBase.funcionarios');

  @override
  ObservableList<Funcionario> get funcionarios {
    _$funcionariosAtom.reportRead();
    return super.funcionarios;
  }

  @override
  set funcionarios(ObservableList<Funcionario> value) {
    _$funcionariosAtom.reportWrite(value, super.funcionarios, () {
      super.funcionarios = value;
    });
  }

  final _$selectFileAsyncAction = AsyncAction('_HomeControllerBase.selectFile');

  @override
  Future<void> selectFile() {
    return _$selectFileAsyncAction.run(() => super.selectFile());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  String setErroMessage(String value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setErroMessage');
    try {
      return super.setErroMessage(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFuncionarios(List<Funcionario> func) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setFuncionarios');
    try {
      return super.setFuncionarios(func);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
erroMessage: ${erroMessage},
funcionarios: ${funcionarios},
valorErroGeral: ${valorErroGeral}
    ''';
  }
}
