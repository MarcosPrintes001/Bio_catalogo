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
      color: Colors.blueGrey[50],
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(
            File(plant.imagePath),
            scale: 30,
          ),
        ),
        title: Text(
          'Nome: ${plant.name.toUpperCase()}\nLocal: ${plant.gpsLocation}',
        ),
        subtitle: Text(
          'Obs: ${plant.observation}',
        ),
      ),
    );
  }
}
