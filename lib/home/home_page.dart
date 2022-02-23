import 'package:flutter/material.dart';
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
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.pathController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Escolha um arquivo',
                      suffixIcon: IconButton(
                        onPressed: controller.selectFile,
                        icon: const Icon(Icons.folder),
                      ),
                    ),
                  ),
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
                          ),
                          const SizedBox(width: 5),
                          Text('Taxa: ${controller.valorErroGeral['taxa']}%'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
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

                        return Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'Funcionario: Código: ${funcionario.codigo} | Pulsação: ${funcionario.pulsacao}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              'Taxa: ${funcionario.erroRelativo}% -- Diferença para taxa da Sociedade de Cardiologia: ${funcionario.diferencaTaxaValida}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            trailing: Text(
                              'Status do funcionario: ${funcionario.statusPulsacao?.toText}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
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
}
