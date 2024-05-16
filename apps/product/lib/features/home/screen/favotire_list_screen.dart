import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product/features/home/data/models/favorite.dart';
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
              return ListTile(
                title: Text(favorite?.name ?? 'Unknown'),
                subtitle: Text('${favorite?.country ?? 'Unknown'}\nAQI: ${favorite?.aqi ?? '-'}\nTime: ${favorite?.stime ?? '-'}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    box.deleteAt(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}