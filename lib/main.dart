import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/weather_provide.dart';
import 'package:weather_forecast_app/weather_widget.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch Lahore's weather when the screen is first loaded
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWeather('Lahore');
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black, // Black background as per your preference
      appBar: AppBar(
        title: Text(
          'Weather Forecast',
          style: TextStyle(
              color: Colors.black), // Set the forecast text color to black
        ),
        backgroundColor: Colors
            .white, // Optional: set the AppBar background color for contrast
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Trigger weather search when search icon is clicked
              _showSearchDialog(context, weatherProvider);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg', // Ensure this file is added to your assets
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),
          // Foreground UI components (like weather info and search)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                weatherProvider.weather == null
                    ? CircularProgressIndicator()
                    : WeatherDisplay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(
      BuildContext context, WeatherProvider weatherProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Enter City Name',
            style: TextStyle(
                color: Colors.black), // Black text color for the dialog
          ),
          content: TextField(
            controller: _cityController,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                weatherProvider.fetchWeather(_cityController.text);
                Navigator.of(context).pop(); // Close the dialog after search
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
