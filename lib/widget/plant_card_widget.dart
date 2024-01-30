import 'package:bio_catalogo/model/plant.dart';
import 'package:flutter/material.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class PlantCard extends StatelessWidget {
  PlantCard({
    Key? key,
    required this.plant,
    required this.index,
  }) : super(key: key);

  final Plant plant;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    // final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
            Text(
              plant.observation,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
