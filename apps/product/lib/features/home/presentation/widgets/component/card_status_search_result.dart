import 'package:flutter/material.dart';

class CardSearchStatus extends StatelessWidget {
  final String dailyAvg;
  final String city;
  final String updateTime;

  const CardSearchStatus({
    super.key,
    required this.dailyAvg,
    required this.city,
    required this.updateTime,
  });

  Color _getColor(num value) {
    if (value >= 0 && value <= 50) {
      return Colors.green;
    } else if (value >= 51 && value <= 100) {
      return Colors.amber;
    } else if (value >= 101 && value <= 200) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  Widget _getIcon(num value) {
    const double iconSize = 50.0;
    if (value >= 0 && value <= 50) {
      return const Icon(
        Icons.sentiment_satisfied_alt_outlined,
        size: iconSize,
      );
    } else if (value >= 51 && value <= 100) {
      return const Icon(
        Icons.sentiment_neutral_outlined,
        size: iconSize,
      );
    } else if (value >= 101 && value <= 200) {
      return const Icon(
        Icons.sentiment_dissatisfied_outlined,
        size: iconSize,
      );
    } else {
      return const Icon(
        Icons.sick_outlined,
        size: iconSize,
      );
    }
  }

  Widget _buildValueContainer(num value) {
    Color color = _getColor(value);
    return Column(
      children: [
        Container(
          width: 120,
          height: 53,
          color: color,
          child: Center(
            child: Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    num dailyAvgValue = num.tryParse(dailyAvg) ?? 0;
    Color mainColor = _getColor(dailyAvgValue);

    return SizedBox(
      width: 350,
      height: 150,
      child: Card(
        color: mainColor,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getIcon(dailyAvgValue),
                    const SizedBox(height: 1),
                    Text(
                      '$dailyAvgValue',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      'US AQI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 230,
                    height: 102,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          city,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 15,
                    color: Colors.white, // Set the background color to white
                    child: Center(
                      child: Text(
                        updateTime,
                        style: const TextStyle(
                          color: Colors.black, // Change the text color to black for better contrast
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
