import 'package:covid_app/Widgets/reusable.dart';
import 'package:flutter/material.dart';

class Countries_Details extends StatefulWidget {
  String country;
  String flag;
  int cases, todayCases, recovered, active, critical, population;
  Countries_Details({
    required this.country,
    required this.flag,
    required this.cases,
    required this.todayCases,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.population,
  });

  @override
  State<Countries_Details> createState() => _Countries_DetailsState();
}

class _Countries_DetailsState extends State<Countries_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.country),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Reusable_Widget(
                          title: 'Population',
                          value: widget.population.toString()),
                      Reusable_Widget(
                          title: 'Active', value: widget.active.toString()),
                      Reusable_Widget(
                          title: 'Total Cases', value: widget.cases.toString()),
                      Reusable_Widget(
                          title: 'Critical', value: widget.critical.toString()),
                      Reusable_Widget(
                          title: 'Recovered',
                          value: widget.recovered.toString()),
                      Reusable_Widget(
                          title: 'Today Cases',
                          value: widget.todayCases.toString()),
                      // Reusable_Widget(
                      // title: 'Today Cases', value: widget..toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.flag),
              )
            ],
          )
        ],
      ),
    );
  }
}
