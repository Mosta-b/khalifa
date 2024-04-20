part of 'qadiya_bloc.dart';

@immutable
sealed class QadiyaEvent {
  const QadiyaEvent();
}

class QadiyaEventGetAllQadaya extends QadiyaEvent {
  const QadiyaEventGetAllQadaya();
}

class QadiyaEventGetAllSolutions extends QadiyaEvent {
  final QadiyaModel qadiya;

  const QadiyaEventGetAllSolutions({required this.qadiya});
}

class QadiyaEventUpdateSolution extends QadiyaEvent {
  final SolutionModel solution;

  const QadiyaEventUpdateSolution({required this.solution});
}

class QadiyaEventAddNewSolution extends QadiyaEvent {
  final SolutionModel solution;
  final QadiyaModel qadiyaModel;

  const QadiyaEventAddNewSolution({
    required this.solution,
    required this.qadiyaModel,
  });
}

class QadiyaEventAddNewQadiya extends QadiyaEvent {
  final QadiyaModel qadiya;

  const QadiyaEventAddNewQadiya({required this.qadiya});
}

class QadiyaEventDeleteSolution extends QadiyaEvent {
  final SolutionModel solution;

  const QadiyaEventDeleteSolution({required this.solution});
}

class QadiyaEventDeleteQadiya extends QadiyaEvent {
  final QadiyaModel qadiya;

  const QadiyaEventDeleteQadiya({required this.qadiya});
}
