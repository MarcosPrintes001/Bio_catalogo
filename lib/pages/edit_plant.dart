import 'package:bio_catalogo/db/plants_database.dart';
import 'package:bio_catalogo/model/plant.dart';
import 'package:bio_catalogo/widget/plant_form_widget.dart';
import 'package:flutter/material.dart';

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

  // late bool isImportant;
  // late int number;
  // late String title;
  // late String description;

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

    // number = widget.plant?.number ?? 0;
    // description = widget.plant?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: 
            // PlantForm(
            //   name: name,
            //   imagePath: imagePath,
          
            //   petalCount: petalCount,
          
            //   hasLeafHair: hasLeafHair,
            //   isGlabrous: isGlabrous,
            //   hasSimpleLeaf: hasSimpleLeaf,
            //   hasStipule: hasStipule,
            //   hasCompostLeaf: hasCompostLeaf,
          
            //   observation: observation,
            //   gpsLocation: gpsLocation,
          
            //   onChangedname: (onChangedname) =>
            //       setState(() => this.name = onChangedname),
            //   onChangedimagePath: (onChangedimagePath) =>
            //       setState(() => this.imagePath = onChangedimagePath),
          
            //   onChangedpetalCount: (onChangedpetalCount) =>
            //       setState(() => this.petalCount = onChangedpetalCount),
          
            //   onChangedhasLeafHair: (onChangedhasLeafHair) =>
            //       setState(() => this.hasLeafHair),
            //   onChangedisGlabrous: (onChangedisGlabrous) =>
            //       setState(() => this.isGlabrous),
            //   onChangedhasSimpleLeaf: (onChangedhasSimpleLeaf) =>
            //       setState(() => this.hasSimpleLeaf),
            //   onChangedhasCompostLeaf: (onChangedhasCompostLeaf) =>
            //       setState(() => this.hasLeafHair),
            //   onChangedhasStipule: (onChangedhasStipule) =>
            //       setState(() => this.hasStipule),
          
            //   onChangedgpsLocation: (onChangedgpsLocation) =>
            //       setState(() => this.gpsLocation),
            //   onChangedobservation: (onChangedobservation) =>
            //       setState(() => this.observation),
          
            //   // onChangedNumber: (number) => setState(() => this.number = number),
            //   // onChangedTitle: (title) => setState(() => this.title = title),
            //   // onChangedDescription: (description) => setState(() => this.description = description),
            // ),
            
            Column(children: [

              
            ],)
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty && observation.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            // onPrimary: Colors.white,
            // primary: isFormValid ? null : Colors.grey.shade700,
            ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.plant != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
//Adicionar campos faltantes
    final plant = widget.plant!.copy(
      name: name,
      observation: observation,
      isGlabrous: isGlabrous,
      petalCount: petalCount,
    );

    await PlantsDatabase.instance.update(plant);
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
  }
}
