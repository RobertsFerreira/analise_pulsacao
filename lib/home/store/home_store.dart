import 'package:mobx/mobx.dart';

import '../function/calculos.dart';
import '../models/funcionario.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  calculoMedia(List<Funcionario> funcionarios) {
    print(valorProvavel(funcionarios));
  }
}
