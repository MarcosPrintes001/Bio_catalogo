import 'dart:io';

import 'package:bio_catalogo/model/plant.dart';
import 'package:flutter/material.dart';

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
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.file(
          File(plant.imagePath),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          '${plant.name.toUpperCase()} \n${plant.gpsLocation}',
        ),
        subtitle: Text(
          plant.observation,
        ),
      ),
    );
  }
}
