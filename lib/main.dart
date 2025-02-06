import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';
  List<Map<String, String>> _forecast = [];

  void fetchWeather() {
    setState(() {
      _cityName = _cityController.text;
      // Dummy data
      _temperature = '20°C';
      _weatherCondition = 'Sunny';
    });
  }

  void fetchForecast() {
    setState(() {
      _forecast = List.generate(7, (index) {
        return {
          'day': 'Day ${index + 1}',
          'temperature': '${20 + index}°C',
          'condition': index.isEven ? 'Sunny' : 'Cloudy',
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text('Fetch Weather'),
            ),
            ElevatedButton(
              onPressed: fetchForecast,
              child: Text('Fetch 7-Day Forecast'),
            ),
            SizedBox(height: 20),
            if (_cityName.isNotEmpty) ...[
              Text(
                'City: $_cityName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Temperature: $_temperature',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Weather: $_weatherCondition',
                style: TextStyle(fontSize: 18),
              ),
            ],
            SizedBox(height: 30),
            if (_forecast.isNotEmpty) ...[
              Text(
                '7-Day Forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _forecast.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _forecast[index]['day']!,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _forecast[index]['temperature']!,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _forecast[index]['condition']!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
