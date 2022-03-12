import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/material.dart'
    hide Card, Scrollbar, IconButton, ListTile, Divider, Tooltip;
import 'package:flutter_mobx/flutter_mobx.dart';

import 'controllers/home_controller.dart';
import 'models/funcionario.dart';
import 'shared/enum_status_pulsacao.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextBox(
                    readOnly: true,
                    controller: controller.pathController,
                    header: 'Caminho da base de dados em TXT',
                    placeholder: 'Selecione um arquivo TXT',
                    suffix: IconButton(
                      onPressed: controller.selectFile,
                      icon: const Icon(FluentIcons.open_file),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Observer(
                  builder: (_) {
                    final isNotEmpty = controller.funcionarios.isNotEmpty;
                    return SizedBox(
                      height: 50,
                      width: 100,
                      child: Tooltip(
                        message: !isNotEmpty
                            ? 'Carregue os dados no sistema para ver os gráficos'
                            : 'Gráfico baseado nos dados',
                        child: FilledButton(
                          onPressed: isNotEmpty
                              ? () => Navigator.of(context).pushNamed(
                                    '/graph/',
                                    arguments: controller.funcionarios,
                                  )
                              : null,
                          child: const Center(
                            child: Text(
                              'Ver Grafico',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Observer(
              builder: (_) {
                if (controller.funcionarios.isNotEmpty) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Taxa da Amostragem ${controller.valorErroGeral['validacao'] ? 'válida!' : 'inválida!'}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Taxa: ${_fixedDecimalsPlaces(
                              controller.valorErroGeral['taxa'],
                              decimalsPlaces: 4,
                            )}%',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 15),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            Observer(
              builder: (ctx) {
                List<Funcionario> _funcionarios = controller.funcionarios;
                if (controller.funcionarios.isEmpty) {
                  return const Center(
                    child: Text('Não há dados carregados'),
                  );
                }
                if (controller.error) {
                  return const SizedBox();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _funcionarios.length,
                      itemBuilder: (cx, index) {
                        final funcionario = _funcionarios[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: Text(
                                'Funcionario: Código: ${funcionario.codigo} | Pulsação: ${funcionario.pulsacao}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                'Taxa: ${_fixedDecimalsPlaces(funcionario.erroRelativo)}% -- Diferença para taxa da Sociedade de Cardiologia: ${_fixedDecimalsPlaces(funcionario.diferencaTaxaValida)}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                'Status do funcionario: ${funcionario.statusPulsacao?.toText}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String _fixedDecimalsPlaces(dynamic value, {int decimalsPlaces = 2}) {
    if (value is double) {
      return value.toStringAsFixed(decimalsPlaces);
    }
    return value;
  }
}
