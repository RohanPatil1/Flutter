import 'package:chill_sounds/data/modal.dart';
import 'package:hive/hive.dart';

class Data {
  static Box<bool> boolBox = Hive.box<bool>('bool');
  static Box<String> stringBox = Hive.box<String>('string');
  static Box<int> intBox = Hive.box<int>('int');
  static Box<double> doubleBox = Hive.box<double>('double');
  static Box<Sound> soundBox = Hive.box<Sound>('sounds');
  static Box<Category> categoryBox = Hive.box<Category>('category');

  static Future<void> init() async {
    await Hive.openBox<bool>('bool');
    await Hive.openBox<String>('string');
    await Hive.openBox<double>('double');
    await Hive.openBox<int>('int');
    await Hive.openBox<Sound>('sounds');
    await Hive.openBox<Category>('category');
  }
}
