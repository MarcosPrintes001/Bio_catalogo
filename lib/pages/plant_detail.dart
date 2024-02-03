// ignore_for_file: use_build_context_synchronously, unnecessary_this

import 'dart:io';

import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/pages/edit_plant.dart';
import 'package:flutter/material.dart';

class PlantDetailPage extends StatefulWidget {
  final int plantId;

  const PlantDetailPage({
    Key? key,
    required this.plantId,
  }) : super(key: key);

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  late Plant plant;
  bool isLoading = false;
  Color textCor = const Color.fromARGB(225, 2, 2, 2);

  @override
  void initState() {
    super.initState();

    refreshPlant();
  }

  Future refreshPlant() async {
    setState(() => isLoading = true);

    this.plant = await PlantsDatabase.instance.readNote(widget.plantId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 38, 123, 98),
          actions: [
            editButton(),
            deleteButton(),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 40, 176, 143),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 300,
                      height: 300,
                      child: Image.file(
                        File(plant.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome: ${plant.name}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Quantidade Pétalas: ${plant.petalCount}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Folha com Pelos: ${plant.getYesNo(plant.hasLeafHair)}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Folha Glabro: ${plant.getYesNo(plant.isGlabrous)}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Folha Simples: ${plant.getYesNo(plant.hasSimpleLeaf)}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Folha Composta: ${plant.getYesNo(plant.hasCompostLeaf)}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tem Estípula: ${plant.getYesNo(plant.hasStipule)}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'GPS: ${plant.gpsLocation}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Observação: ${plant.observation}',
                          style: TextStyle(
                            color: textCor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(
        Icons.edit_outlined,
        color: Colors.white,
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditPlantPage(plant: plant),
        ));

        refreshPlant();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () async {
          if (isLoading) return;

          // Mostra o diálogo de confirmação antes de excluir
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  "ATENÇÃO!⚠",
                )),
                content: Text(
                  "Tem certeza de que deseja excluir '${plant.name}'",
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Exclui a planta
                      await PlantsDatabase.instance.delete(widget.plantId);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Confirmar"),
                  ),
                ],
              );
            },
          );
        },
      );
}
