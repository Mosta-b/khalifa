part of 'qadiya_bloc.dart';

@immutable
class QadiyaState extends Equatable {
  final List<QadiyaModel> existingQadaya;
  final List<QadiyaModel>? existingSolutions;
  final bool isLoading;
  final Failure? exception;
  const QadiyaState({
    required this.existingQadaya,
    required this.exception,
    required this.isLoading,
    this.existingSolutions,
  });

  @override
  List<Object?> get props =>
      [existingQadaya, existingSolutions, exception, isLoading];
}
