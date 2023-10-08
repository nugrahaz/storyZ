import 'package:get_storage/get_storage.dart';
import 'package:storyz/app/models/login_result_model.dart';

class StorageServices {
  var box = GetStorage();
  final String _userIdKey = 'userId';
  final String _nameKey = "name";
  final String _tokenKey = 'authToken';

  final String _isLoggedKey = "isLogged";
  final String _languageKey = "languageKey";

  //Bahasa
  void setLanguage(String lang) async {
    box.write(_languageKey, lang);
  }

  String getLanguage() {
    //bahasa inisialiasi English
    return box.read(_languageKey) ?? "English";
  }

  //Sudah login?
  Future<void> setIsLogged(bool status) async {
    box.write(_isLoggedKey, status);
  }

  Future<bool> getIsLogged() async {
    bool status = box.read(_isLoggedKey) ?? false;
    return status;
  }

  Future<void> setUserInfo(LoginResult loginResult) async {
    box.write(_userIdKey, loginResult.userId);
    box.write(_nameKey, loginResult.name);
    box.write(_tokenKey, loginResult.token);
  }

  LoginResult getUserInfo() {
    var userId = box.read(_userIdKey) ?? "";
    var name = box.read(_nameKey) ?? "";
    var token = box.read(_tokenKey) ?? "";
    return LoginResult(userId: userId, name: name, token: token);
  }

  Future<void> clearUserData() async {
    box.remove(_userIdKey);
    box.remove(_nameKey);
    box.remove(_tokenKey);
    box.write(_isLoggedKey, false);
  }
}
