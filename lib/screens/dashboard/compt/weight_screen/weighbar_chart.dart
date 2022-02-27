/// RTL Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class BarchartWeight extends StatelessWidget {
  final List<charts.Series<Ordinalvalue, String>> seriesList;
  final bool animate;

  const BarchartWeight(
      {Key? key, required this.seriesList, this.animate = true})
      : super(key: key);

  /// Creates a [BarChart] with sample data and no transition.
  // factory BarchartWeight.withSampleData() {
  //   return new BarchartWeight(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new charts.BarChart(
          seriesList,
          animate: animate,
          behaviors: [
            new charts.SeriesLegend(
                position: charts.BehaviorPosition.end, desiredMaxRows: 2)
          ],
        ));
  }

  /// Create series list with multiple series
  static List<charts.Series<Ordinalvalue, String>> createSampleData(
      List<Weight> weightlist) {
    List<Ordinalvalue> initweightData = [];

    List<Ordinalvalue> reqweightData = [];
    weightlist.forEach((element) {
      initweightData.add(new Ordinalvalue(element.dateTime, element.value));
      reqweightData.add(new Ordinalvalue(element.dateTime, 20));
    });

    return [
      new charts.Series<Ordinalvalue, String>(
        id: 'Weight',
        domainFn: (Ordinalvalue value, _) => value.date,
        measureFn: (Ordinalvalue value, _) => value.value,
        data: initweightData,
      ),
      new charts.Series<Ordinalvalue, String>(
        id: 'Required',
        domainFn: (Ordinalvalue value, _) => value.date,
        measureFn: (Ordinalvalue value, _) => value.value,
        data: reqweightData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class Ordinalvalue {
  final String date;
  final double value;

  Ordinalvalue(this.date, this.value);
}
