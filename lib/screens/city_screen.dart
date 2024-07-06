import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_assignment/provider/locations_provider.dart';
import 'package:weather_app_assignment/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  void initState() {
    super.initState();
    getLocations();
    setState(() {});
  }

  getLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList('locations-list');
    if (mounted) {
      Provider.of<LocationsProvider>(context, listen: false).setLocations(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.black26],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      color: Colors.white,
                      Icons.arrow_back_ios_new,
                      size: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: kTextFieldInputdecoration,
                    onChanged: (value) {
                      cityName = value;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var locations =
                        Provider.of<LocationsProvider>(context, listen: false)
                            .locations;
                    if (!locations.contains(cityName)) {
                      Provider.of<LocationsProvider>(context, listen: false)
                          .addLocation(cityName);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setStringList('locations-list', locations);
                    }

                    Navigator.pop(context, cityName);
                  },
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount:
                      Provider.of<LocationsProvider>(context, listen: false)
                          .locations
                          .length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pop(
                          context,
                          Provider.of<LocationsProvider>(context, listen: false)
                              .locations[index]),
                      child: Card(
                        color: Colors.white24,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 50.0,
                                color: Colors.black38,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  Provider.of<LocationsProvider>(context,
                                          listen: false)
                                      .locations[index],
                                  style: const TextStyle(
                                    fontFamily: 'Spartan MB',
                                    fontSize: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
