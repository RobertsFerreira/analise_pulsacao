import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  TextEditingController pathController = TextEditingController();

  @observable
  bool error = false;

  @observable
  String erroMessage = "";

  @action
  String setErroMessage(String value) => erroMessage = value;

  void selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      pathController.text = result.files.single.path!;
    } else {
      setErroMessage("Por favor selecione um arquivo");
      error = true;
    }
  }
}
