import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class MyHomePage extends StatefulWidget {
   MyHomePage(this.list1,this.list2); 

  // final String title;
  final List<int> list1;
  final List<int> list2;

  @override
  _MyHomePageState createState() => new _MyHomePageState(list1,list2);
}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.lista, this.listc);

  final List<int> lista;
  final List<int> listc;

  @override
  Widget build(BuildContext context) {
    final desktopSalesData = [
      new OrdinalSales('Week1', lista[0]),
      new OrdinalSales('Week2', lista[1]),
      new OrdinalSales('Week3', lista[2]),
      new OrdinalSales('Week4', lista[3]),
    ];

    final tableSalesData = [
      new OrdinalSales('Week1', listc[0]),
      new OrdinalSales('Week2', listc[1]),
      new OrdinalSales('Week3', listc[2]),
      new OrdinalSales('Week4', listc[3]),
    ];

    var series = [
      new charts.Series<OrdinalSales, String>(
        id: 'Accepted',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Completed',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],

      // behaviors: [
        
      //   subTitle: 'Top sub-title text',
      //       behaviorPosition: charts.BehaviorPosition.top,
      //       titleOutsideJustification: charts.OutsideJustification.start,)],



    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
        // child: Column(children: <Widget>[chart],)
      ),
    );
    return chartWidget;
   
  }
}
