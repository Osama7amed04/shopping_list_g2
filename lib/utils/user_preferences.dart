import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyUserName = 'user_name';
  static const String _keyUserImage = 'user_image';

  // حفظ اسم المستخدم
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }

  // جلب اسم المستخدم
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // حفظ صورة المستخدم
  static Future<void> saveUserImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserImage, imagePath);
  }

  // جلب صورة المستخدم
  static Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserImage);
  }

  // حفظ الاسم والصورة معاً
  static Future<void> saveUserData({
    required String name,
    required String imagePath,
  }) async {
    await saveUserName(name);
    await saveUserImage(imagePath);
  }
}
