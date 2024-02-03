// ignore_for_file: use_build_context_synchronously, unnecessary_this

import 'dart:io';

import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/pages/edit_plant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
            : Column(
                children: [
                  Container(
                    color: Colors.black87, // Cor escura para a parte superior
                    height: MediaQuery.of(context).size.height *
                        0.3, // 30% da altura da tela
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: PhotoView(
                                  imageProvider: FileImage(
                                    File(plant.imagePath),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(plant.imagePath)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                plant.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors
                          .grey[200], // Cor mais clara para a parte inferior
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: const Border.symmetric(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "Detalhes".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  _buildTableRow("Quantidade Pétalas:",
                                      plant.petalCount.toString()),
                                  const Divider(),
                                  _buildTableRow("Folha com Pelos:",
                                      plant.getYesNo(plant.hasLeafHair)),
                                  const Divider(),
                                  _buildTableRow("Folha Glabro:",
                                      plant.getYesNo(plant.isGlabrous)),
                                  const Divider(),
                                  _buildTableRow("Folha Simples:",
                                      plant.getYesNo(plant.hasSimpleLeaf)),
                                  const Divider(),
                                  _buildTableRow("Folha Composta:",
                                      plant.getYesNo(plant.hasCompostLeaf)),
                                  const Divider(),
                                  _buildTableRow("Tem Estípula:",
                                      plant.getYesNo(plant.hasStipule)),
                                  const Divider(),
                                  _buildTableRow("GPS:", plant.gpsLocation),
                                  const Divider(),
                                  _buildTableRow(
                                      "Observação:", plant.observation),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );

  Widget _buildTableRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: textCor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: textCor,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
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

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  "ATENÇÃO!⚠",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
                content: Text(
                  "Tem certeza de que deseja excluir '${plant.name}'"
                      .toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
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
