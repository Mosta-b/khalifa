import 'package:khalifa/src/qadaya/domain/entities/qadiya.dart';

class QadiyaModel extends Qadiya {
  QadiyaModel({
    required super.qadiyaTitle,
    required super.priority,
  });
  Map<String, dynamic> toMap() {
    return {
      'qadiyaTitle': qadiyaTitle,
      'priority': priority,
    };
  }

  static Qadiya convertToQadiyaEntity({required QadiyaModel qadiyaModel}) {
    return Qadiya(
        qadiyaTitle: qadiyaModel.qadiyaTitle, priority: qadiyaModel.priority);
  }

  static QadiyaModel convertToQadiyaModel({required Qadiya qadiyaModel}) {
    return QadiyaModel(
        qadiyaTitle: qadiyaModel.qadiyaTitle, priority: qadiyaModel.priority);
  }

  static List<Qadiya> convertToListOfQadaya(
      {required List<QadiyaModel> qadaya}) {
    List<Qadiya> finaList = [];
    for (QadiyaModel qadiya in qadaya) {
      finaList.add(
          Qadiya(qadiyaTitle: qadiya.qadiyaTitle, priority: qadiya.priority));
    }
    return finaList;
  }

  static List<QadiyaModel> convertToListOfQadayaModel(
      {required List<Qadiya> qadaya}) {
    List<QadiyaModel> finaList = [];
    for (Qadiya qadiya in qadaya) {
      finaList.add(QadiyaModel(
          qadiyaTitle: qadiya.qadiyaTitle, priority: qadiya.priority));
    }
    return finaList;
  }
}
