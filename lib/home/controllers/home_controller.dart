import 'dart:io';

import 'package:analise_pulsacao/home/models/funcionario.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

import '../store/home_store.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  TextEditingController pathController = TextEditingController();
  HomeStore store = HomeStore();

  @observable
  bool error = false;

  @observable
  String erroMessage = "";

  @action
  String setErroMessage(String value) => erroMessage = value;

  @observable
  ObservableList<Funcionario> funcionarios = <Funcionario>[].asObservable();

  @action
  void setFuncionarios(List<Funcionario> func) {
    funcionarios = func.asObservable();
  }

  @action
  Future<void> selectFile() async {
    error = false;

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      final String path = result.files.single.path!;
      pathController.text = path;
      final File file = File(path);
      final List<String> dados = file.readAsLinesSync();

      final List<Funcionario> _funcionarios = Funcionario.fromList(dados);

      setFuncionarios(_funcionarios);
      store.verificaStatusFuncionario(funcionarios);
    } else {
      pathController.clear();
      setFuncionarios([]);
      asuka.showDialog(
        builder: (ctx) {
          return ContentDialog(
            title: const Text('Erro ao selecionar arquivo!'),
            content: const Text('Selecione um arquivo por favor!'),
            actions: [
              Button(
                onPressed: () {
                  Navigator.pop(ctx);
                  error = true;
                },
                child: const Text('Fechar'),
              ),
              Button(
                onPressed: () async {
                  Navigator.pop(ctx);
                  error = false;
                  await Future.delayed(const Duration(milliseconds: 200));
                  await selectFile();
                },
                child: const Text('Tentar Novamente!'),
              ),
            ],
          );
        },
      );
    }
  }

  @computed
  Map<String, dynamic> get valorErroGeral {
    return store.erroGeral(funcionarios);
  }
}
