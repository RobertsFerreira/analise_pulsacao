import 'package:analise_pulsacao/home/shared/enum_status_pulsacao.dart';
import 'package:mobx/mobx.dart';

import '../function/calculos.dart';
import '../models/funcionario.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final double _porcentagemAceitavel = 11;

  double _calculoMedia(List<Funcionario> funcionarios) {
    return valorProvavel(funcionarios);
  }

  void _errosPorFuncionario(List<Funcionario> funcionarios) {
    final vp = _calculoMedia(funcionarios);

    for (Funcionario funcionario in funcionarios) {
      double erroAbs = erroAbsoluto(vp, pulsacao: funcionario.pulsacao);
      double erroRelat = erroRelativo(vp, erroAbs);

      int index = funcionarios.indexOf(funcionario);

      funcionarios[index] = funcionario.copyWith(
        erroAbsoluto: erroAbs,
        erroRelativo: erroRelat,
      );
    }
  }

  verificaStatusFuncionario(List<Funcionario> funcionarios) {
    _errosPorFuncionario(funcionarios);

    final result = calculoMargem();

    final limiteMin = result['limiteMin'] ?? 0;

    final limiteMax = result['limiteMax'] ?? 0;

    for (Funcionario funcionario in funcionarios) {
      double _diferencaValida =
          funcionario.erroRelativo - _porcentagemAceitavel;

      if (_diferencaValida < 0) {
        _diferencaValida *= -1;
      }

      int index = funcionarios.indexOf(funcionario);

      funcionarios[index] = funcionarios[index].copyWith(
        diferencaTaxaValida: _diferencaValida,
      );

      if (funcionario.pulsacao < limiteMin) {
        funcionarios[index] = funcionarios[index].copyWith(
          statusPulsacao: StatusPulsacao.abaixoMedia,
        );
      } else if (funcionario.pulsacao >= limiteMin &&
          funcionario.pulsacao <= limiteMax) {
        funcionarios[index] = funcionarios[index].copyWith(
          statusPulsacao: StatusPulsacao.naMedia,
        );
      } else if (funcionario.pulsacao > limiteMax) {
        funcionarios[index] = funcionarios[index].copyWith(
          statusPulsacao: StatusPulsacao.acimaMedia,
        );
      }
    }
  }

  Map<String, dynamic> erroGeral(List<Funcionario> funcionarios) {
    final vp = valorProvavel(funcionarios);
    double erroAbs = erroAbsoluto(vp);
    double erroRel = erroRelativo(vp, erroAbs);

    if (erroRel > _porcentagemAceitavel) {
      return <String, dynamic>{
        'validacao': erroRel,
        'taxa': erroRel,
      };
    } else {
      return <String, dynamic>{
        'validacao': false,
        'taxa': erroRel,
      };
    }
  }
}
