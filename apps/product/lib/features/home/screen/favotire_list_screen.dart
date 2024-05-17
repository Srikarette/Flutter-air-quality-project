import 'package:core_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product/features/home/data/models/favorite.dart';
import 'package:product/features/home/presentation/widgets/component/card_status_search_result.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final color = ref.watch(appThemeProvider).themeColor;
      return Scaffold(
        backgroundColor: color.backgroundPrimary,
         appBar: AppBar(
              title:  Text('Bookmarks',
              style: TextStyle(
                          color: color.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),),
              backgroundColor: const Color.fromRGBO(29, 196, 250, 1),
            ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Favorite>('favorites').listenable(),
          builder: (context, Box<Favorite> box, _) {
            if (box.values.isEmpty) {
              return Center(child: Text('No favorites added.',
              style: TextStyle(
            color: Colors.grey, 
          ),
              ));
            }
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var favorite = box.getAt(index);
                return Column(
                  children: [
                    SizedBox(height: 10),
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
    });
  }
}
