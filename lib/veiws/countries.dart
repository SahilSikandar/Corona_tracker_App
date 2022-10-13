import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/veiws/countries_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries extends StatefulWidget {
  Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    stateservices stateServices = stateservices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: ((value) {
                setState(() {});
              }),
              controller: searchcontroller,
              decoration: InputDecoration(
                  hintText: 'Search Countries',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.getcountriesdata(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100);
                    });
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'].toString();
                    if (searchcontroller.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Countries_Details(
                                      country: snapshot.data![index]['country'],
                                      flag: snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      active: snapshot.data![index]['active'],
                                      cases: snapshot.data![index]['cases'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      population: snapshot.data![index]
                                          ['population'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      todayCases: snapshot.data![index]
                                          ['todayCases'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              title: Text(
                                  snapshot.data![index]['country'].toString()),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          ),
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Countries_Details(
                                    country: snapshot.data![index]['country'],
                                    flag: snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    active: snapshot.data![index]['active'],
                                    cases: snapshot.data![index]['cases'],
                                    critical: snapshot.data![index]['critical'],
                                    population: snapshot.data![index]
                                        ['population'],
                                    recovered: snapshot.data![index]
                                        ['recovered'],
                                    todayCases: snapshot.data![index]
                                        ['todayCases'],
                                  ),
                                ))),
                            child: ListTile(
                              title: Text(
                                  snapshot.data![index]['country'].toString()),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                    // return Column(
                    //   children: [
                    //     ListTile(
                    //       title:
                    //           Text(snapshot.data![index]['country'].toString()),
                    //       subtitle:
                    //           Text(snapshot.data![index]['cases'].toString()),
                    //       leading: Image(
                    //           height: 50,
                    //           width: 50,
                    //           image: NetworkImage(snapshot.data![index]
                    //               ['countryInfo']['flag'])),
                    //     ),
                    //   ],
                    // );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
