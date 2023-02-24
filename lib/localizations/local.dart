import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {},
        "tr": {
          "Login": "Giriş yapın",
          "Email": "eposta",
          "Please enter a valid email": "lütfen geçerli eposta adresini giriniz",
          "Password": "Şifre",
          "Sign in": "Kayıt olun",
          "Sign Up": "Üye olun",
          "Forgot Password?": "Parolanızı mı unuttunuz?",
          "Sign out": "Oturumu Kapat",
          "English": "İngilizce",
          "Turkish": "Türkçe"
        },
      };
}
