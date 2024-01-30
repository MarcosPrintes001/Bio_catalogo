// ignore_for_file: unnecessary_this

import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/pages/edit_plant.dart';
import 'package:bio_catalogo/pages/plant_detail.dart';
import 'package:bio_catalogo/widget/plant_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Plant> plants;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  @override
  void dispose() {
    PlantsDatabase.instance.close();

    super.dispose();
  }

  Future refreshList() async {
    setState(() => isLoading = true);

    this.plants = await PlantsDatabase.instance.readAllPlants();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: const Text(
            'BIO CATALOGO',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            IconButton(
              onPressed: null, //Implementar busca de palavras
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        backgroundColor: Colors.green,
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : plants.isEmpty
                  ? const Text(
                      'Sem Plantas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    )
                  : buildPlants(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddEditPlantPage(),
              ),
            );

            refreshList();
          },
        ),
      );

  Widget buildPlants() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlantDetailPage(plantId: plant.id!),
                ),
              );

              refreshList();
            },
            child: PlantCard(plant: plant, index: index),
          );
        },
      );
}
