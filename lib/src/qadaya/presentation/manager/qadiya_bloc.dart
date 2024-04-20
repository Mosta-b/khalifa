import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
            log("am here so it does have qadaya");
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
            log("no it doesn't list should be empty");
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
    on<QadiyaEventAddNewQadiya>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _createNewQadiya
            .call(CreateNewQadiyaParams(qadiya: event.qadiya));
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
          add(const QadiyaEventGetAllQadaya());
        });
      },
    );
    on<QadiyaEventGetAllSolutions>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _getListOfAvailableSolutions
            .call(GetListOfAvailableSolutionsParams(qadiya: event.qadiya));
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          final List<SolutionModel> convertedList = r != null
              ? SolutionModel.convertToListOfSolutionModel(solutions: r)
              : [];
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: convertedList,
              isLoading: false,
            ),
          );
        });
      },
    );
    on<QadiyaEventUpdateSolution>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _saveLastEditedSolution
            .call(SaveLastEditedSolutionParams(solution: event.solution));
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        });
      },
    );
    on<QadiyaEventAddNewSolution>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _createNewSolution.call(
          CreateNewSolutionParams(
            qadiya: event.qadiyaModel,
            solution: event.solution,
          ),
        );
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        });
      },
    );
    on<QadiyaEventDeleteSolution>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _deleteSolution.call(
          DeleteSolutionParams(
            solution: event.solution,
          ),
        );
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
          add(const QadiyaEventGetAllQadaya());
        });
      },
    );
    on<QadiyaEventDeleteQadiya>(
      (event, emit) async {
        emit(
          QadiyaState(
            existingQadaya: state.existingQadaya,
            exception: null,
            existingSolutions: state.existingSolutions,
            isLoading: true,
          ),
        );
        final result = await _deleteQadiya.call(
          DeleteQadiyaParams(
            qadiya: event.qadiya,
          ),
        );
        result.fold((l) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: l,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
        }, (r) {
          emit(
            QadiyaState(
              existingQadaya: state.existingQadaya,
              exception: null,
              existingSolutions: state.existingSolutions,
              isLoading: false,
            ),
          );
          add(const QadiyaEventGetAllQadaya());
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
