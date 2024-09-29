import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal() {
    initPrefs();
  }

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de datos de planetas
  String get listPlanets {
    return _prefs.getString('listPlanets') ?? '';
  }

  set listPlanets(String value) {
    _prefs.setString('listPlanets', value);
  }
}

final UserPreferences prefs = UserPreferences();
