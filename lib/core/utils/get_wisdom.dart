import 'dart:math';

class GetWisdom {
  static const List<String> listOfPhrases = [
    "كفى بالموت وعظى",
    "صلى الله عليه و سلم",
    "إِنما الموتُ مُنْتهى كُلِّ حي",
    "لم يصيبْ مالكٌ من الملكِ خُلْدا",
    " والموتُ حقٌ ولكن ليس كل فتىً يبكي عليه إِذا يعروهُ فقدانُ.",
    " كم من عزيزٍ أذل الموتُ مصرعه كانت على رأسهِ الراياتُ تخفقُ",
    "والعُـمـرُ مـاضٍ إنَّـمايَبقى صَنِيعُكَ والأَثَـر"
  ];

  static const List<String> listOfMosqueImages = [
    "assets/images/mosque_1.jpg",
    "assets/images/mosque_2.jpg",
    "assets/images/mosque_3.jpg",
    "assets/images/mosque_4.jpg",
    "assets/images/mosque_5.jpg",
    "assets/images/mosque_6.jpg",
  ];

  static String getWisdom() {
    final length = GetWisdom.listOfPhrases.length;
    final Random random = Random();
    final toUse = random.nextInt(length);
    return listOfPhrases.elementAt(toUse);
  }

  static String getWisdomImages() {
    final length = GetWisdom.listOfMosqueImages.length;
    final Random random = Random();
    final toUse = random.nextInt(length);
    return listOfMosqueImages.elementAt(toUse);
  }
}
