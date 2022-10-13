import 'package:covid_app/Model/details.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/Widgets/constants.dart';
import 'package:covid_app/Widgets/reusable.dart';
import 'package:covid_app/veiws/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class World_States extends StatefulWidget {
  World_States({Key? key}) : super(key: key);

  @override
  State<World_States> createState() => _World_StatesState();
}

class _World_StatesState extends State<World_States>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ColorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    stateservices state = stateservices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                future: state.getdata(),
                builder: (context, AsyncSnapshot<WorldStatesApi> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: ColorList,
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                          legendOptions: LegendOptions(
                              legendShape: BoxShape.rectangle,
                              legendPosition: LegendPosition.left),
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                Reusable_Widget(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                Reusable_Widget(
                                    title: 'Recovererd',
                                    value: snapshot.data!.recovered.toString()),
                                Reusable_Widget(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                Reusable_Widget(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                Reusable_Widget(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                Reusable_Widget(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                Reusable_Widget(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Countries()));
                          }),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                color: kbuttoncolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              'Track Countries',
                              style: kcolortext,
                            )),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
