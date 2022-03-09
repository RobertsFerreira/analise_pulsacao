import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'home/models/funcionario.dart';
import 'home/pages/graph_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        asuka.asukaHeroController,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/graph/': (context) => GraphPage(
              funcionarios: ModalRoute.of(context)?.settings.arguments
                  as List<Funcionario>,
            ),
      },
    );
  }
}
