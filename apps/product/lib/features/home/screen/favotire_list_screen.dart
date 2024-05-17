import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Favorite>('favorites').listenable(),
        builder: (context, Box<Favorite> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No favorites added.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              var favorite = box.getAt(index);
              return Column(
                children: [
                  Stack(
                    children: [
                      CardSearchStatus(
                        dailyAvg: favorite?.aqi ?? 'Unknown',
                        city: favorite?.name ?? 'Unknown',
                        updateTime: favorite?.stime ?? 'Unknown',
                      ),
                      Positioned(
  bottom: 10,
  right: 2,
  child: IconButton(
    icon: Icon(
      Icons.delete,
      color: Colors.red, 
    ),
    onPressed: () {
      box.deleteAt(index);
    },
  ),
),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
