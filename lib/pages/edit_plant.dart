// ignore_for_file: use_build_context_synchronously

import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/widget/plant_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEditPlantPage extends StatefulWidget {
  final Plant? plant;

  const AddEditPlantPage({super.key, this.plant});

  @override
  State<AddEditPlantPage> createState() => _AddEditPlantPageState();
}

class _AddEditPlantPageState extends State<AddEditPlantPage> {
  final _formKey = GlobalKey<FormState>();

  late String imagePath;
  late String name;

  late int petalCount;

  late bool hasLeafHair;
  late bool isGlabrous;
  late bool hasSimpleLeaf;
  late bool hasStipule;
  late bool hasCompostLeaf;

  late String observation;
  late String gpsLocation;

  @override
  void initState() {
    super.initState();

    name = widget.plant?.name ?? '';
    imagePath = widget.plant?.imagePath ?? '';

    petalCount = widget.plant?.petalCount ?? 0;

    hasLeafHair = widget.plant?.hasLeafHair ?? false;
    isGlabrous = widget.plant?.isGlabrous ?? false;
    hasSimpleLeaf = widget.plant?.hasSimpleLeaf ?? false;
    hasCompostLeaf = widget.plant?.hasCompostLeaf ?? false;

    hasStipule = widget.plant?.hasStipule ?? false;

    observation = widget.plant?.observation ?? '';
    gpsLocation = widget.plant?.gpsLocation ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 38, 123, 98),
          actions: [buildButton()],
        ),
        backgroundColor: const Color.fromARGB(255, 40, 176, 143),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PlantForm(
                    name: name,
                    imagePath: imagePath,
                    petalCount: petalCount,
                    hasLeafHair: hasLeafHair,
                    isGlabrous: isGlabrous,
                    hasSimpleLeaf: hasSimpleLeaf,
                    hasStipule: hasStipule,
                    hasCompostLeaf: hasCompostLeaf,
                    observation: observation,
                    gpsLocation: gpsLocation,
                    onChangedname: (onChangedname) =>
                        setState(() => name = onChangedname),
                    onChangedimagePath: (onChangedimagePath) =>
                        setState(() => imagePath = onChangedimagePath),
                    onChangedpetalCount: (onChangedpetalCount) =>
                        setState(() => petalCount = onChangedpetalCount),
                    onChangedhasLeafHair: (onChangedhasLeafHair) =>
                        setState(() => hasLeafHair = onChangedhasLeafHair),
                    onChangedisGlabrous: (onChangedisGlabrous) =>
                        setState(() => isGlabrous = onChangedisGlabrous),
                    onChangedhasSimpleLeaf: (onChangedhasSimpleLeaf) =>
                        setState(() => hasSimpleLeaf = onChangedhasSimpleLeaf),
                    onChangedhasCompostLeaf: (onChangedhasCompostLeaf) =>
                        setState(
                            () => hasCompostLeaf = onChangedhasCompostLeaf),
                    onChangedhasStipule: (onChangedhasStipule) =>
                        setState(() => hasStipule = onChangedhasStipule),
                    onChangedgpsLocation: (onChangedgpsLocation) =>
                        setState(() => gpsLocation = onChangedgpsLocation),
                    onChangedobservation: (onChangedobservation) =>
                        setState(() => observation = onChangedobservation),
                  ),
                ],
              )),
        ),
      );

  Widget buildButton() {
    final isFormValid = imagePath.isNotEmpty &&
        name.isNotEmpty &&
        observation.isNotEmpty &&
        gpsLocation.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(
            color: isFormValid ? Colors.green : Colors.red, // Cor da borda
            width: 2.0, // Largura da borda
          )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors
                  .grey; // Cor de fundo quando o botão está desabilitado
            }
            return Colors.white; // Cor de fundo quando o botão está habilitado
          }),
        ),
        onPressed: addOrUpdateNote,
        child: Text(
          'Salvar',
          style: TextStyle(
            color: isFormValid ? Colors.green : Colors.red, // Cor do texto
          ),
        ),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (imagePath.isEmpty) {
      Fluttertoast.showToast(
        msg: "Adicione uma imagem!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Retorna para evitar que a planta seja salva sem imagem
    }

    if (isValid) {
      final isUpdating = widget.plant != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
        msg: "Preencha todos os campos para adicionar uma planta",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future updateNote() async {
    final plant = widget.plant!.copy(
        imagePath: imagePath,
        name: name,
        petalCount: petalCount,
        hasLeafHair: hasLeafHair,
        isGlabrous: isGlabrous,
        hasSimpleLeaf: hasSimpleLeaf,
        hasStipule: hasStipule,
        hasCompostLeaf: hasCompostLeaf,
        observation: observation,
        gpsLocation: gpsLocation);

    await PlantsDatabase.instance.update(plant);
    Future.delayed(const Duration(seconds: 2));
  }

  Future addNote() async {
    final plant = Plant(
        imagePath: imagePath,
        name: name,
        petalCount: petalCount,
        hasLeafHair: hasLeafHair,
        isGlabrous: isGlabrous,
        hasSimpleLeaf: hasSimpleLeaf,
        hasStipule: hasStipule,
        hasCompostLeaf: hasCompostLeaf,
        observation: observation,
        gpsLocation: gpsLocation);
    await PlantsDatabase.instance.create(plant);
    Future.delayed(const Duration(seconds: 2));
  }
}
