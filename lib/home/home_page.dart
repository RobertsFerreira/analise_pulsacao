import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'controllers/home_controller.dart';

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
            TextFormField(
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
            Observer(
              builder: (_) {
                if (controller.error) {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text(controller.erroMessage),
                        title: const Text("Erro ao selecionar arquivo"),
                        actions: [
                          TextButton(
                            onPressed: controller.selectFile,
                            child: const Text('Tentar novamente!'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Fechar'),
                          )
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
