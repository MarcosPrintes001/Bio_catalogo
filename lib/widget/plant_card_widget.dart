import 'dart:io';

import 'package:bio_catalogo/model/plant.dart';
import 'package:flutter/material.dart';

// final _lightColors = [
//   Colors.amber.shade300,
//   Colors.lightGreen.shade300,
//   Colors.lightBlue.shade300,
//   Colors.orange.shade300,
//   Colors.pinkAccent.shade100,
//   Colors.tealAccent.shade100
// ];

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key? key,
    required this.plant,
    required this.index,
  }) : super(key: key);

  final Plant plant;
  final int index;

  @override
  Widget build(BuildContext context) {
    // final color = _lightColors[index % _lightColors.length];
    // // final minHeight = getMinHeight(index);

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.file(
          File(plant.imagePath), // Certifique-se de ter o caminho correto
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          plant.name.toUpperCase(),
        ),
        subtitle: Text(
          plant.observation,
        ),
        // subtitle: Text('${plant.observation}'),
      ),
    );
  }

  // /// To return different height for different widgets
  // double getMinHeight(int index) {
  //   switch (index % 4) {
  //     case 0:
  //       return 100;
  //     case 1:
  //       return 150;
  //     case 2:
  //       return 150;
  //     case 3:
  //       return 100;
  //     default:
  //       return 100;
  //   }
  // }
}
