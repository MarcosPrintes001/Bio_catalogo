import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlantForm extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final int? petalCount;
  final bool? hasLeafHair;
  final bool? isGlabrous;
  final bool? hasSimpleLeaf;
  final bool? hasStipule;
  final bool? hasCompostLeaf;
  final String? observation;
  final String? gpsLocation;

  final ValueChanged<String> onChangedimagePath;
  final ValueChanged<String> onChangedname;
  final ValueChanged<int> onChangedpetalCount;

  final ValueChanged<bool> onChangedhasLeafHair;
  final ValueChanged<bool> onChangedisGlabrous;
  final ValueChanged<bool> onChangedhasSimpleLeaf;
  final ValueChanged<bool> onChangedhasCompostLeaf;
  final ValueChanged<bool> onChangedhasStipule;

  final ValueChanged<String> onChangedobservation;
  final ValueChanged<String> onChangedgpsLocation;

  const PlantForm({
    Key? key,
    this.name = '',
    this.petalCount = 0,
    this.hasLeafHair = false,
    this.isGlabrous = false,
    this.hasSimpleLeaf = false,
    this.hasCompostLeaf = false,
    this.hasStipule = false,
    this.gpsLocation = '',
    this.observation = '',
    this.imagePath = '',
    required this.onChangedimagePath,
    required this.onChangedname,
    required this.onChangedpetalCount,
    required this.onChangedhasLeafHair,
    required this.onChangedisGlabrous,
    required this.onChangedhasSimpleLeaf,
    required this.onChangedhasCompostLeaf,
    required this.onChangedhasStipule,
    required this.onChangedobservation,
    required this.onChangedgpsLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildImagePreview(),
              const SizedBox(height: 16),
              buildName(),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Switch(
                      value: hasLeafHair ?? false,
                      onChanged: (newValue) {
                        onChangedhasLeafHair(newValue);
                      },
                    ),
                    const Text(
                      "Pelo nas Folhas",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    
                    Switch(
                      value: isGlabrous ?? false,
                      onChanged: (newValue) {
                        onChangedisGlabrous(newValue);
                      },
                    ),
                    const Text(
                      "É Glabro",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                
                    Switch(
                      value: hasStipule ?? false,
                      onChanged: (newValue) {
                        onChangedhasStipule(newValue);
                      },
                    ),
                    const Text(
                      "Tem Estípula",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Switch(
                      value: hasSimpleLeaf ?? false,
                      onChanged: (newValue) {
                        onChangedhasSimpleLeaf(newValue);
                      },
                    ),
                    const Text(
                      "Folhas Simples",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Switch(
                      value: hasCompostLeaf ?? false,
                      onChanged: (newValue) {
                        onChangedhasCompostLeaf(newValue);
                      },
                    ),
                    const Text(
                      "Folhas Compostas",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white38,
              ),
              const Text("Quantidade de Petalas",
                  style: TextStyle(color: Colors.white)),
              Slider(
                value: (petalCount ?? 0).toDouble(),
                label: "$petalCount",
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (petal) => onChangedpetalCount(petal.toInt()),
              ),
              const SizedBox(height: 8),
              buildGPS(),
              const SizedBox(height: 16),
              buildObservation(),
            ],
          ),
        ),
      );

  Widget buildImagePreview() {
    return GestureDetector(
      onTap: () => _openCamera(),
      child: imagePath != null && imagePath!.isNotEmpty
          ? Image.file(
              File(imagePath!),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            )
          : Container(
              height: 300,
              width: 300,
              alignment: Alignment.center,
              color: Colors.green[800],
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 50,
                  ),
                  Text(
                    "Nenhuma imagem selecionada,\nclique aqui para adicionar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      onChangedimagePath(pickedFile.path);
    }
  }

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white, // Cor do texto
        ),
        decoration: const InputDecoration(
          hintText: 'Nome',
          hintStyle: TextStyle(
            color: Colors.white70,
          ),
          contentPadding: EdgeInsets.only(bottom: 1.6),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'O nome não pode ficar vazio'
            : null,
        onChanged: onChangedname,
      );

  Widget buildObservation() => TextFormField(
        maxLines: 3,
        initialValue: observation,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white, // Cor do texto
        ),
        decoration: const InputDecoration(
          hintText: 'Observação',
          hintStyle: TextStyle(
            color: Colors.white70,
          ),
          contentPadding: EdgeInsets.only(bottom: 1.6),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'A observação não pode ficar vazia'
            : null,
        onChanged: onChangedobservation,
      );

  Widget buildGPS() => TextFormField(
        maxLines: 1,
        initialValue: gpsLocation,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white, // Cor do texto
        ),
        decoration: const InputDecoration(
          hintText: 'GPS',
          hintStyle: TextStyle(
            color: Colors.white70,
          ),
          contentPadding: EdgeInsets.only(bottom: 1.6),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
        validator: (gps) =>
            gps != null && gps.isEmpty ? 'O GPS não pode ficar vazio' : null,
        onChanged: onChangedgpsLocation,
        keyboardType: TextInputType.number,
      );
}
