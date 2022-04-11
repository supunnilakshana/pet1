import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2({Key? key, required this.weights}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
  final List<Weight> weights;
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  List<BarChartGroupData> itemGroup = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, 20, 2);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    int i = 0;
    widget.weights.forEach((element) {
      itemGroup.add(makeGroupData(i, element.value, 2));
      i++;
    });

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    rawBarGroups = itemGroup;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.weights);
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Weight',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'state',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 25,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (_a, _b, _c, _d) => null,
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            setState(() {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                            });
                            return;
                          }

                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;

                          setState(() {
                            if (!event.isInterestedForInteractions) {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                              return;
                            }
                            showingBarGroups = List.of(rawBarGroups);
                            if (touchedGroupIndex != -1) {
                              var sum = 0.0;
                              for (var rod
                                  in showingBarGroups[touchedGroupIndex]
                                      .barRods) {
                                sum += rod.y;
                              }
                              final avg = sum /
                                  showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .length;

                              showingBarGroups[touchedGroupIndex] =
                                  showingBarGroups[touchedGroupIndex].copyWith(
                                barRods: showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .map((rod) {
                                  return rod.copyWith(y: avg);
                                }).toList(),
                              );
                            }
                          });
                        }),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          return value.toString();
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 8,
                        reservedSize: 28,
                        interval: 1,
                        getTitles: (value) {
                          if (value == 0) {
                            return '0';
                          } else if (value == 10) {
                            return '10';
                          } else if (value == 15) {
                            return '15';
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  int setDate(String s) {
    DateTime d = Date.convertDatetime(s);

    return d.month;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// class GroupedFillColorBarChart extends StatelessWidget {
//   final List<charts.Series<dynamic, String>> seriesList;
//   final bool animate;

//   GroupedFillColorBarChart(
//     this.seriesList, {
//     this.animate = false,
//   });

//   factory GroupedFillColorBarChart.withSampleData() {
//     return new GroupedFillColorBarChart(
//       _createData(),
//       // Disable animations for image tests.
//       animate: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return charts.BarChart(
//       seriesList,
//       animate: animate,
//       // Configure a stroke width to enable borders on the bars.
//       defaultRenderer: new charts.BarRendererConfig(
//           groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
//     );
//   }

//   /// Create series list with multiple series
//   static List<charts.Series<Weight, String>> _createData() {
//     final weightData = [
//       new Weight("2021/02/25", 15.2),
//       new Weight("2021/02/26", 16.2),
//       new Weight("2021/02/27", 15.2),
//       new Weight("2021/02/26", 16.2),
//       new Weight("2021/02/29", 15.2),
//       new Weight("2021/02/30", 16.2)
//     ];

//     final tableSalesData = [
//       new Weight("2021/02/25", 15.2),
//       new Weight("2021/02/26", 16.2)
//     ];

//     return [
//       // Blue bars with a lighter center color.
//       new charts.Series<Weight, String>(
//         id: 'Desktop',
//         domainFn: (Weight w, _) => w.dateTime,
//         measureFn: (Weight w, _) => w.value,
//         data: weightData,
//         colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         fillColorFn: (_, __) =>
//             charts.MaterialPalette.blue.shadeDefault.lighter,
//       ),
//       // Solid red bars. Fill color will default to the series color if no
//       // fillColorFn is configured.
//       new charts.Series<Weight, String>(
//         id: 'Tablet',
//         measureFn: (Weight w, _) => w.value,
//         data: tableSalesData,
//         colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
//         domainFn: (Weight w, _) => w.dateTime,
//       ),
//       // Hollow green bars.
//     ];
//   }
// }

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
