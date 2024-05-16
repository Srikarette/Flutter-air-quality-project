import 'package:core_ui/theme/color/theme_color.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardStatus extends ConsumerWidget {
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

  Widget _buildValueContainer(num value ,IThemeColor theme) {
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
                color: theme.text,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider).themeColor;
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
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1),
                     Text(
                      'US AQI',
                      style: TextStyle(
                        color: theme.text,
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
    color: theme.backgroundSecondary, 
    borderRadius: BorderRadius.circular(10), 
    border: Border.all(
      color: theme.backgroundSecondary,
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
                        style: TextStyle(
                          color: theme.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                  ),
      Row(
        children: [
          ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
         child:
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
                    style: TextStyle(
                      color: theme.text,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildValueContainer(tomorrowAvg,theme),
                ],
              ),
            ),
            ),
          ),
          SizedBox(width: 1),
          ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
         child:Container(
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
                    style: TextStyle(
                      color: theme.text,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildValueContainer(dayAfterTomorrowAvg,theme),
                ],
              ),
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
            'Today:$updateTime',
            style: TextStyle(
                          color: theme.text,
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
