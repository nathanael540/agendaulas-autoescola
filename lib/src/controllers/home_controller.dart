import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class HomeController extends ChangeNotifier {
  late SharedPreferences _prefs;

  List _materias = [];

  List defaultMaterias = [
    {
      'id': 'legislacao',
      'order': 1,
      'title': "Legislação de\nTrânsito",
      'image': "assets/legislacao.svg",
      'totalLessons': 18,
      'lessons': [],
    },
    {
      'id': 'direcao',
      'order': 2,
      'title': "Direção\nDefensiva",
      'image': "assets/direcao.svg",
      'totalLessons': 16,
      'lessons': [],
    },
    {
      'id': 'socorros',
      'order': 3,
      'title': "Primeiros\nSocorros",
      'image': "assets/socorros.svg",
      'totalLessons': 4,
      'lessons': [],
    },
    {
      'id': 'meioambiente',
      'order': 4,
      'title': "Meio Ambiente\ne Cidadania",
      'image': "assets/meioambiente.svg",
      'totalLessons': 4,
      'lessons': [],
    },
    {
      'id': 'mecanica',
      'order': 5,
      'title': "Mecância\nBásica",
      'image': "assets/mecanica.svg",
      'totalLessons': 3,
      'lessons': [],
    },
  ];

  List get materias => _materias;

  int get totalRemaininLessons {
    int total = 0;
    for (var materia in _materias) {
      int rest = materia['totalLessons'] - materia['lessons'].length;
      total += rest;
    }
    return total;
  }

  HomeController() {
    getMaterias();
  }

  // Lessons
  getMateriaFromID(String id) {
    return _materias.firstWhere((element) => element['id'] == id);
  }

  getMateriaIndex(String id) {
    return _materias.indexWhere((element) => element['id'] == id);
  }

  getLessonIndex(String id, Map materia) {
    return materia['lessons'].indexWhere((element) => element['id'] == id);
  }

  void removeLesson(lessonId, materiaId) async {
    var index = getMateriaIndex(materiaId);
    _materias[index]['lessons']
        .removeWhere((element) => element['id'] == lessonId);
    await updateMateriaDB(_materias[index]);
    notifyListeners();
  }

  void addLesson(String id, Map lesson) async {
    var index = getMateriaIndex(id);
    if (_materias[index]['lessons'].length + 1 >
        _materias[index]['totalLessons']) {
      notifyListeners();
      return;
    }

    _materias[index]['lessons'].add(lesson);
    await updateMateriaDB(_materias[index]);
    notifyListeners();
  }

  void updateLessonsMax(int materiaIndex, int newMax) async {
    _materias[materiaIndex]['totalLessons'] = newMax;
    await updateMateriaDB(_materias[materiaIndex]);
    notifyListeners();
  }

  Future<bool> updateMateriaDB(materia) {
    return _prefs.setString(materia['id'], jsonEncode(materia));
  }

  void createMateriasFromMock() {
    _materias = defaultMaterias;
    notifyListeners();

    for (var materia in defaultMaterias) {
      _prefs.setString(materia['id'], jsonEncode(materia));
    }
  }

  void getMaterias() async {
    List<dynamic> itemsList = [];
    _prefs = await SharedPreferences.getInstance();

    var materias = _prefs.getKeys();

    if (materias.isEmpty) {
      createMateriasFromMock();
      return;
    }

    for (var materia in materias) {
      var item = _prefs.getString(materia);
      if (item != null) {
        itemsList.add(jsonDecode(item));
      }
    }

    itemsList.sort((a, b) => a['order'].compareTo(b['order']));
    _materias = itemsList;

    notifyListeners();
  }
}
