import 'package:flutter/material.dart';

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
    this.imagePath = '',
    this.name = '',
    this.petalCount = 0,
    this.hasLeafHair = false,
    this.isGlabrous = false,
    this.hasSimpleLeaf = false,
    this.hasCompostLeaf = false,
    this.hasStipule = false,
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
    this.gpsLocation = '',
    this.observation = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                value: hasLeafHair ?? false,
                onChanged: onChangedhasLeafHair,
              ),
              Switch(
                value: isGlabrous ?? false,
                onChanged: onChangedisGlabrous,
              ),
              Switch(
                value: hasSimpleLeaf ?? false,
                onChanged: onChangedhasSimpleLeaf,
              ),
              Switch(
                value: hasCompostLeaf ?? false,
                onChanged: onChangedhasCompostLeaf,
              ),
              Switch(
                value: hasStipule ?? false,
                onChanged: onChangedhasStipule,
              ),
              Expanded(
                child: Slider(
                  value: (petalCount ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (petal) =>
                      onChangedpetalCount(petalCount!.toInt()),
                ),
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedname,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: observation,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedobservation,
      );
}
