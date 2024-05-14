import 'package:flutter/material.dart';

class CardStatus extends StatelessWidget {
  final int value;
  final int value1;
  final int value2;

    const CardStatus({super.key, required this.value, required this.value1, required this.value2,});


  Color _getColor(int value) {
    if (value >= 0 && value <= 50) {
      return Colors.green;
    } else if (value >= 51 && value <= 100) {
      return Colors.yellow;
    } else if (value >= 101 && value <= 200) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  Widget _getIcon() {
    double iconSize = 50.0;
    if (value >= 0 && value <= 50) {
      return Icon(
        Icons.sentiment_satisfied_alt_outlined,
        size: iconSize,
      );
    } else if (value >= 51 && value <= 100) {
      return Icon(
        Icons.sentiment_neutral_outlined,
        size: iconSize,
      );
    } else if (value >= 101 && value <= 200) {
      return Icon(
        Icons.sentiment_dissatisfied_outlined,
        size: iconSize,
      );
    } else {
      return Icon(
        Icons.sick_outlined,
        size: iconSize,
      );
    }
  }

   Widget _buildValueContainer(int value) {
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
    Color mainColor = _getColor(value);

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
                      '$value',
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
            Column(
              children: [
                Container(
                  width: 240,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'SUB DISTRICT NAME 1 CITY, COUNTRY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 70,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              'Day',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             _buildValueContainer(value1),
                    
                          ],
                        ),
                        
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 70,
                      color: Colors.blueAccent,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              'Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             _buildValueContainer(value2),
                          ],
                        ), 
                        
                        
                        
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 240,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
