import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khalifa/core/errors/failure.dart';
import 'package:khalifa/src/qadaya/data/models/qadiya_model.dart';
import 'package:khalifa/src/qadaya/data/models/solution_model.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/create_new_qadiya.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/create_new_solution.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/delete_qadiya.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/delete_solution.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/get_list_of_available_qadaya.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/get_list_of_available_solutions.dart';
import 'package:khalifa/src/qadaya/domain/use_cases/save_last_edited_solution.dart';
import 'package:meta/meta.dart';

part 'qadiya_event.dart';
part 'qadiya_state.dart';

class QadiyaBloc extends Bloc<QadiyaEvent, QadiyaState> {
  QadiyaBloc({
    required CreateNewQadiya createNewQadiya,
    required CreateNewSolution createNewSolution,
    required DeleteQadiya deleteQadiya,
    required DeleteSolution deleteSolution,
    required GetListOfAvailableQadaya getListOfAvailableQadaya,
    required GetListOfAvailableSolutions getListOfAvailableSolutions,
    required SaveLastEditedSolution saveLastEditedSolution,
  })  : _createNewQadiya = createNewQadiya,
        _createNewSolution = createNewSolution,
        _deleteQadiya = deleteQadiya,
        _deleteSolution = deleteSolution,
        _getListOfAvailableQadaya = getListOfAvailableQadaya,
        _getListOfAvailableSolutions = getListOfAvailableSolutions,
        _saveLastEditedSolution = saveLastEditedSolution,
        super(const QadiyaState(
            existingQadaya: [], exception: null, isLoading: true)) {
    on<QadiyaEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<QadiyaEventGetAllQadaya>(
      (event, emit) async {
        log("am searching you now");
        final result = await _getListOfAvailableQadaya.call();
        result.fold((l) {
          log("i got this  $l");
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          if (r != null) {
            final listToConvert =
                QadiyaModel.convertToListOfQadayaModel(qadaya: r);
            emit(
              QadiyaState(
                existingQadaya: listToConvert,
                exception: null,
                existingSolutions: state.existingSolutions,
                isLoading: false,
              ),
            );
          } else {
            emit(
              QadiyaState(
                existingQadaya: [],
                exception: null,
                existingSolutions: state.existingSolutions,
                isLoading: false,
              ),
            );
          }
        });
      },
    );
  }
  final CreateNewQadiya _createNewQadiya;
  final CreateNewSolution _createNewSolution;
  final DeleteQadiya _deleteQadiya;
  final DeleteSolution _deleteSolution;
  final GetListOfAvailableQadaya _getListOfAvailableQadaya;
  final GetListOfAvailableSolutions _getListOfAvailableSolutions;
  final SaveLastEditedSolution _saveLastEditedSolution;
}
