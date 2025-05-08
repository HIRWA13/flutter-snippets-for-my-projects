import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("de", LocaleData.DE),
  MapLocale("zh", LocaleData.ZH),
  MapLocale("es", LocaleData.ES),
];

mixin LocaleData {
  static const title = 'title';
  static const body = 'body';
  static const buttonText = 'buttonText';

  static const Map<String, dynamic> EN = {
    title: 'Localization',
    body:
        'Hey there am exploring how to implement localization in flutter applications',
    buttonText: 'Get Started',
  };

  static const Map<String, dynamic> DE = {
    title: 'Lokalisierung',
    body:
        'Hallo, ich untersuche gerade, wie man die Lokalisierung in Flatteranwendungen implementiert',
    buttonText: 'Fangen Sie an',
  };

  static const Map<String, dynamic> ZH = {
    title: '本土化',
    body: '你好，我目前正在研究如何在flutter应用中实现本地化',
    buttonText: '开始使用',
  };

  static const Map<String, dynamic> ES = {
    title: 'localización',
    body:
        'Hola, estoy explorando cómo implementar la localización en aplicaciones de flutter.',
    buttonText: 'empezar',
  };
}
