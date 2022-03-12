import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/funcionario.dart';
import '../shared/enum_status_pulsacao.dart';

class GraphPage extends StatefulWidget {
  final List<Funcionario> funcionarios;
  const GraphPage({Key? key, required this.funcionarios}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  TooltipBehavior? _tooltipBehavior;
  late List<Funcionario> _abaixoMed;
  late List<Funcionario> _naMed;
  late List<Funcionario> _acimaMed;
  late List<ItemGraph> _status;
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    _abaixoMed =
        _generetedSubsList(widget.funcionarios, StatusPulsacao.abaixoMedia);
    _naMed = _generetedSubsList(widget.funcionarios, StatusPulsacao.naMedia);
    _acimaMed =
        _generetedSubsList(widget.funcionarios, StatusPulsacao.acimaMedia);

    final abaixoMed = ItemGraph(
      status: StatusPulsacao.abaixoMedia.toText,
      porcentagem: _abaixoMed.length,
    );
    final naMed = ItemGraph(
      status: StatusPulsacao.naMedia.toText,
      porcentagem: _naMed.length,
    );
    final acimaMed = ItemGraph(
      status: StatusPulsacao.acimaMedia.toText,
      porcentagem: _acimaMed.length,
    );

    _status = <ItemGraph>[
      abaixoMed,
      naMed,
      acimaMed,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        leading: BackButton(),
      ),
      content: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
          text: 'Números de Fúncionarios de cada status em relação à Média',
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value} Funcionário(s)',
          majorTickLines: const MajorTickLines(size: 0),
        ),
        series: _getDefaultColumnSeries(_status),
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  List<ColumnSeries<ItemGraph, String>> _getDefaultColumnSeries(
    List<ItemGraph> itensGraph,
  ) {
    return <ColumnSeries<ItemGraph, String>>[
      ColumnSeries<ItemGraph, String>(
        dataSource: itensGraph,
        // dataSource: <ItemGraph>[
        //   ItemGraph(x: 'China', y: 0.541),
        //   ItemGraph(x: 'Brazil', y: 0.818),
        //   ItemGraph(x: 'Bolivia', y: 1.51),
        //   ItemGraph(x: 'Mexico', y: 1.302),
        //   ItemGraph(x: 'Egypt', y: 2.017),
        //   ItemGraph(x: 'Mongolia', y: 1.683),
        // ],
        xValueMapper: (ItemGraph status, _) => status.status,
        yValueMapper: (ItemGraph status, _) => status.porcentagem,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
        ),
      )
    ];
  }

  List<Funcionario> _generetedSubsList(
    List<Funcionario> funcionarios,
    StatusPulsacao status,
  ) {
    List<Funcionario> _func = [];

    _func = funcionarios
        .where((Funcionario func) => func.statusPulsacao == status)
        .toList();

    return _func;
  }
}

class ItemGraph {
  final String status;
  final int porcentagem;

  ItemGraph({
    required this.status,
    required this.porcentagem,
  });
}
