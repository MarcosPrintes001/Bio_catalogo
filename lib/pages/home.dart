import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/pages/edit_plant.dart';
import 'package:bio_catalogo/pages/plant_detail.dart';
import 'package:bio_catalogo/widget/plant_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Plant> plants;
  late List<Plant> filteredPlants; 
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

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

    plants = await PlantsDatabase.instance.readAllPlants();
    filteredPlants = List.from(plants);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 38, 123, 98),
          title: const Text(
            'BIO CATALOGO',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 40, 176, 143),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchTextChanged,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar por nome ou qtd petalas',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
              ),
              Expanded(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : filteredPlants.isEmpty
                        ? const Center(
                            child: Text(
                              'Sem Plantas',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          )
                        : buildPlants(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 2, 2, 2),
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
        itemCount: filteredPlants.length, // Use a lista de plantas filtradas
        itemBuilder: (context, index) {
          final plant = filteredPlants[index];

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

  // Método para filtrar a lista de plantas com base na consulta de pesquisa
  void onSearchTextChanged(String text) {
    setState(() {
      filteredPlants = plants.where((plant) {
        return plant.name.toLowerCase().contains(text.toLowerCase()) ||
            plant.petalCount.toString().contains(text.toLowerCase());
      }).toList();
    });
  }
}
