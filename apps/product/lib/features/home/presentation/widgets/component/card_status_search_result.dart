import 'package:core_ui/theme/color/theme_color.dart';
import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardSearchStatus extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider).themeColor;
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
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                     Text(
                      'US AQI',
                      style: TextStyle(
                        color: theme.text,
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
                    width: 230,
                    height: 102,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          city,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 20,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        updateTime,
                        style:TextStyle(
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
