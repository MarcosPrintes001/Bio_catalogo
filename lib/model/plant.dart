const String tablePlants = 'plants';

class PlantFields {
  static final List<String> values = [
    id,
    imagePath,
    name,
    petalCount,
    hasLeafHair,
    isGlabrous,
    hasSimpleLeaf,
    hasStipule,
    hasCompostLeaf,
    observation,
    gpsLocation,
  ];

  static const String id = '_id';
  static const String imagePath = 'imagePath';
  static const String name = 'name';
  static const String petalCount = 'petalCount';
  static const String hasLeafHair = 'hasLeafHair';
  static const String isGlabrous = 'isGlabrous';
  static const String hasSimpleLeaf = 'hasSimpleLeaf';
  static const String hasStipule = 'hasStipule';
  static const String hasCompostLeaf = 'hasCompostLeaf';
  static const String gpsLocation = 'gpsLocation';
  static const String observation = 'observation';
}

class Plant {
  final int? id;
  final String imagePath;
  final String name;
  final int petalCount;
  final bool hasLeafHair;
  final bool isGlabrous;
  final bool hasSimpleLeaf;
  final bool hasStipule;
  final bool hasCompostLeaf;
  final String observation;
  final String gpsLocation;

  const Plant({
    this.id,
    required this.imagePath,
    required this.name,
    required this.petalCount,
    required this.hasLeafHair,
    required this.isGlabrous,
    required this.hasSimpleLeaf,
    required this.hasStipule,
    required this.hasCompostLeaf,
    required this.observation,
    required this.gpsLocation,
  });

  Plant copy({
    int? id,
    String? imagePath,
    String? name,
    int? petalCount,
    bool? hasLeafHair,
    bool? isGlabrous,
    bool? hasSimpleLeaf,
    bool? hasStipule,
    bool? hasCompostLeaf,
    String? observation,
    String? gpsLocation,
  }) =>
      Plant(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        petalCount: petalCount ?? this.petalCount,
        hasLeafHair: hasLeafHair ?? this.hasLeafHair,
        isGlabrous: isGlabrous ?? this.isGlabrous,
        hasSimpleLeaf: hasSimpleLeaf ?? this.hasSimpleLeaf,
        hasCompostLeaf: hasCompostLeaf ?? this.hasCompostLeaf,
        hasStipule: hasStipule ?? this.hasStipule,
        gpsLocation: gpsLocation ?? this.gpsLocation,
        observation: observation ?? this.gpsLocation,
      );

  static Plant fromJson(Map<String, Object?> json) => Plant(
        id: json[PlantFields.id] as int?,
        imagePath: json[PlantFields.imagePath] as String,
        name: json[PlantFields.name] as String,
        petalCount: json[PlantFields.petalCount] as int,
        hasLeafHair: (json[PlantFields.hasLeafHair] as int) == 1 ? true : false,
        isGlabrous: (json[PlantFields.isGlabrous] as int) == 1 ? true : false,
        hasSimpleLeaf:
            (json[PlantFields.hasSimpleLeaf] as int) == 1 ? true : false,
        hasCompostLeaf:
            (json[PlantFields.hasCompostLeaf] as int) == 1 ? true : false,
        hasStipule: (json[PlantFields.hasStipule] as int) == 1 ? true : false,
        observation: json[PlantFields.observation] as String,
        gpsLocation: json[PlantFields.gpsLocation] as String,
      );

  Map<String, Object?> toJson() => {
        PlantFields.id: id,
        PlantFields.imagePath: imagePath,
        PlantFields.name: name,
        PlantFields.petalCount: petalCount,
        PlantFields.hasLeafHair: hasLeafHair ? 1 : 0,
        PlantFields.isGlabrous: isGlabrous ? 1 : 0,
        PlantFields.hasSimpleLeaf: hasSimpleLeaf ? 1 : 0,
        PlantFields.hasCompostLeaf: hasCompostLeaf ? 1 : 0,
        PlantFields.hasStipule: hasStipule ? 1 : 0,
        PlantFields.gpsLocation: gpsLocation,
        PlantFields.observation: observation,
      };
}
