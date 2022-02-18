import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'controllers/home_controller.dart';
import 'models/funcionario.dart';

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
      appBar: AppBar(
        title: const Text('Home'),
      ),
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
                const SizedBox(width: 15),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: controller.calcular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
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
                            title: Text(
                              'Código: ${funcionario.codigo} | Pulsação: ${funcionario.pulsacao}',
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
