// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String? location;
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch weather details
    fetchWeatherData();

    // Load saved location
    _loadSavedLocation();
  }

  // Method to load saved location
  void _loadSavedLocation() async {
    String? savedLocation = '';
    setState(() {
      location = savedLocation;
      _locationController.text = location ?? '';
    });
    await fetchWeatherData();
  }

  // Method to fetch weather data
  Future<void> fetchWeatherData() async {
    try {
      if (location == null || location!.isEmpty) {
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherByLongLatt();
      } else {
        // Fetch weather data by location name
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherByName(location!);
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // Method to handle Save/Update button press
  void _saveOrUpdateLocation() {
    setState(() {
      location = _locationController.text.trim();
    });

    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/background_image.jpg',
            fit: BoxFit.cover,
          ),
          Consumer<WeatherProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                      Text(
                        '\nLoading...',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              } else if (value.weatherData == null) {
                return const Center(
                  child: Text(
                    'The weather data is empty',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (value.error != null) {
                return Center(
                  child: Text(
                    'Error Occured while loading weather data:\n${value.error}}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                final detail = value.weatherData;
                return Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 27,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              '${detail!.location.name}, ${detail.location.country} ',
                              style: GoogleFonts.abrilFatface(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 23)),
                            ),
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/help');
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 23,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '\t\t\tUpdated ${detail.current.lastUpdated.minute} minutes ago',
                        style: GoogleFonts.aDLaMDisplay(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.6),
                              Colors.green.withOpacity(0.3),
                              Colors.lightBlue.withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text('Local Time',
                                  style: GoogleFonts.daysOne(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 18))),
                            ),
                            Center(
                              child: Text(
                                detail.location.localtime,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(colors: [
                                    Colors.cyan.withOpacity(0.6),
                                    Colors.black.withOpacity(0.4),
                                    Colors.red.withOpacity(0.7),
                                    Colors.green.withOpacity(0.4),
                                  ])),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${detail.current.tempC}°C',
                                      style: GoogleFonts.aDLaMDisplay(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40)),
                                    ),
                                    Text(
                                      'Feels like ${detail.current.feelsLikeC}°C',
                                      style: GoogleFonts.adamina(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 200,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.cyan.withOpacity(0.6),
                                  Colors.black.withOpacity(0.4),
                                  Colors.red.withOpacity(0.7),
                                  Colors.green.withOpacity(0.4),
                                ]),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  children: [
                                    Image.network(
                                      'https:${detail.current.condition.icon}',
                                      height: 50,
                                      width: 70,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        detail.current.condition.text,
                                        style: GoogleFonts.aDLaMDisplay(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.red.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.pink.withOpacity(0.7),
                            Colors.transparent.withOpacity(0.4),
                          ]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Details',
                                    style: GoogleFonts.aboreto(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Precipitation',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.precipIn.toString()}mm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 150),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Speed',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.windMph} mph',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Humidity',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.humidity.toString()}%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 176),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Direction',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            detail.current.windDir,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Visibility',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.visMiles.toString()} miles',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 178),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Pressure',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.pressureIn} inHg',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('UV',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.uv.toString()}mm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 193),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Cloud',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${detail.current.cloud} %',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: TextFormField(
          controller: _locationController,
          style: GoogleFonts.acme(
              textStyle: TextStyle(color: Colors.white, fontSize: 13)),
          decoration: InputDecoration(
            fillColor: Colors.brown.shade400,
            filled: true,
            label: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
            hintText: 'Enter location.....',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            suffixIcon: TextButton(
              onPressed: _saveOrUpdateLocation,
              child: Text(
                location == null || location!.isEmpty ? 'Save' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
