import 'package:flutter/material.dart';

class CardStatus extends StatelessWidget {
  final num dailyAvg;
  final num tomorrowAvg;
  final num dayAfterTomorrowAvg;
  final String city;
  final String updateTime;
  final String tomorrowDay;
  final String dayAfterTomorrowDay;

  const CardStatus({
    super.key,
    required this.dailyAvg,
    required this.tomorrowAvg,
    required this.dayAfterTomorrowAvg,
    required this.city,
    required this.updateTime,
    required this.tomorrowDay,
    required this.dayAfterTomorrowDay,
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

  Widget _getIcon() {
    const double iconSize = 50.0;
    if (dailyAvg >= 0 && dailyAvg <= 50) {
      return const Icon(
        Icons.sentiment_satisfied_alt_outlined,
        size: iconSize,
      );
    } else if (dailyAvg >= 51 && dailyAvg <= 100) {
      return const Icon(
        Icons.sentiment_neutral_outlined,
        size: iconSize,
      );
    } else if (dailyAvg >= 101 && dailyAvg <= 200) {
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
              style: TextStyle(
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
    Color mainColor = _getColor(dailyAvg);

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
                    _getIcon(),
                    SizedBox(height: 1),
                    Text(
                      '$dailyAvg',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1),
                    const Text(
                      'US AQI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // ข้อความ
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
        width: 240,
        height: 52,
        child: Center(
          child: Text(
            city,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
        ),
      ),
      Row(
        children: [
          Container(
            width: 120,
            height: 70,
            color: Colors.grey,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tomorrowDay,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildValueContainer(tomorrowAvg),
                ],
              ),
            ),
          ),
          SizedBox(width: 1),
          Container(
            width: 120,
            height: 70,
            color: Colors.grey,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayAfterTomorrowDay,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildValueContainer(dayAfterTomorrowAvg),
                ],
              ),
            ),
          ),
        ],
      ),
      Container(
        width: 240,
        height: 15,
        child: Center(
          child: Text(
            updateTime,
            style: const TextStyle(
              color: Colors.white,
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
