import 'package:flutter/material.dart';
class ClothesBrandsScreens extends StatelessWidget {
  const ClothesBrandsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Clothing brand"),),
        body: const Center(
          child:Text("Welcome to clothing Brand ",style: TextStyle(fontSize: 20), ),

        ),
    );
  }
}
