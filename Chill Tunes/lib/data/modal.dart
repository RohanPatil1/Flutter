import 'package:audioplayers/audioplayers.dart';
import 'package:chill_sounds/data/dataBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  final String categoryId;

  @HiveField(1)
  final String name;

  Category({
    required this.categoryId,
    required this.name,
  });

  /// firestore

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json['id'],
        name: json['name'],
      );

  static final List<Category> _categories = [];

  static List<Category> get categories => List.unmodifiable(_categories);

  static Future<void> getCategories({bool forceFetch = false}) async {
    if (_categories.isNotEmpty && !forceFetch) return;

    /// update if old
    final s = Data.stringBox.get('categoryLastFetchedKey');
    if (s != null) {
      final d = DateTime.parse(s);
      print('#Category Last fetched diff = ${DateTime.now().difference(d)}');
      // ToDo : If old forceFetch
    }

    /// fetch from local fisrt
    if (Data.categoryBox.isNotEmpty && !forceFetch) {
      _categories.addAll(Data.categoryBox.values);
      return;
    }

    final data = await FirebaseFirestore.instance.collection('category').get();

    // clearing list before adding for future cases
    _categories.clear();
    Data.categoryBox.clear();

    for (QueryDocumentSnapshot snapshot in data.docs) {
      final c = Category.fromJson(snapshot.data());
      _categories.add(c);
      Data.categoryBox.put(c.categoryId, c);
    }

    Data.stringBox.put('categoryLastFetchedKey', DateTime.now().toString());
  }
}

@HiveType(typeId: 1)
class Sound extends HiveObject {
  @HiveField(0)
  final String soundId;

  @HiveField(1)
  final String categoryId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String sound;

  @HiveField(4)
  final String image;

  @HiveField(5)
  int volume = 50;

  @HiveField(6)
  bool isSelected;

  late final AudioPlayer audioPlayer;

  Sound({
    required this.soundId,
    required this.categoryId,
    required this.name,
    required this.sound,
    required this.image,
    required this.isSelected,
  }) {
    audioPlayer = AudioPlayer(playerId: this.soundId);
  }

  /// for offline functionality

  bool get isDownloaded =>
      Data.stringBox.containsKey(sound) && Data.stringBox.containsKey(image);

  /// firestore

  factory Sound.fromJson(Map<String, dynamic> json) => Sound(
      soundId: json['id'],
      categoryId: json['category'],
      name: json['name'],
      sound: json['sound'],
      image: json['image'],
      isSelected: false);

  static final List<Sound> _sounds = [];

  static List<Sound> get sounds => List.unmodifiable(_sounds);

  static Future<void> getSounds({bool forceFetch = false}) async {
    if (_sounds.isNotEmpty && !forceFetch) return;

    /// update if old
    final s = Data.stringBox.get('soundLastFetchedKey');
    if (s != null) {
      final d = DateTime.parse(s);
      print('# Sound Last fetched diff = ${DateTime.now().difference(d)}');
      // ToDo : If old forceFetch
    }

    /// fetch from local fisrt
    if (Data.soundBox.isNotEmpty && !forceFetch) {
      _sounds.addAll(Data.soundBox.values);
      return;
    }

    final data = await FirebaseFirestore.instance.collection('sounds').get();

    // clearing list before adding for future cases
    _sounds.clear();
    Data.soundBox.clear();

    for (QueryDocumentSnapshot snapshot in data.docs) {
      final s = Sound.fromJson(snapshot.data());
      _sounds.add(s);
      Data.soundBox.put(s.soundId, s);
    }

    Data.stringBox.put('soundLastFetchedKey', DateTime.now().toString());
  }
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      categoryId: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SoundAdapter extends TypeAdapter<Sound> {
  @override
  final int typeId = 1;

  @override
  Sound read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sound(
      soundId: fields[0] as String,
      categoryId: fields[1] as String,
      name: fields[2] as String,
      sound: fields[3] as String,
      image: fields[4] as String,
      isSelected: fields[6] as bool,
    )..volume = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Sound obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.soundId)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.sound)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.volume)
      ..writeByte(6)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
