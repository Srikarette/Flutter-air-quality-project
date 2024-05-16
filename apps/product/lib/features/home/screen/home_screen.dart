import 'package:core_ui/widgets/elements/botton/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:product/features/home/presentation/widgets/component/app-bar.dart';
import 'package:product/features/home/presentation/widgets/component/location_list.dart';
import 'package:product/features/home/screen/add_location_screen.dart';
import 'package:product/features/home/screen/favotire_list_screen.dart';
import 'package:product/features/home/screen/manage_location_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark, 
        primaryColor: Colors.black, 
      ),
      home: Scaffold(
        appBar: CustomAppBar(
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                title: 'ADD LOCATION',
                titleColor: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LocationList()),
                  );
                },
              ),
              SizedBox(width: 16), // ระยะห่างระหว่างปุ่ม
              PrimaryButton(
                title: 'MANAGE',
                titleColor: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteList()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}