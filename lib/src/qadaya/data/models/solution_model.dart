import 'package:khalifa/core/extensions/extensions.dart';
import 'package:khalifa/src/qadaya/domain/entities/solution.dart';

class SolutionModel extends Solution {
  SolutionModel({
    required super.id,
    required super.title,
    required super.solution,
    required super.images,
    required super.topics,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'solution': solution,
      'images': images?.join(','),
      // Convert List<String> to comma-separated string
      'topics': topics.map((topic) => topic.toMap()).toList(),
      // Convert List<Mawadie> to List<Map<String, dynamic>>
    };
  }

  static Solution convertSolutionModelToSolution({
    required SolutionModel solutionModel,
  }) {
    return Solution(
      id: solutionModel.id,
      title: solutionModel.title,
      solution: solutionModel.solution,
      images: solutionModel.images,
      topics: solutionModel.topics,
    );
  }

  static SolutionModel convertSolutionToSolutionModel({
    required Solution solution,
  }) {
    return SolutionModel(
      id: solution.id,
      title: solution.title,
      solution: solution.solution,
      images: solution.images,
      topics: solution.topics,
    );
  }

  static List<Solution> convertToListOfSolutions({
    required List<SolutionModel> solutions,
  }) {
    List<Solution> finaList = [];
    if (solutions.isNotEmpty) {
      for (SolutionModel solution in solutions) {
        finaList.add(
          Solution(
            id: solution.id,
            title: solution.title,
            solution: solution.solution,
            images: solution.images,
            topics: solution.topics,
          ),
        );
      }
    }

    return finaList;
  }

  static List<SolutionModel> convertToListOfSolutionModel({
    required List<Solution> solutions,
  }) {
    List<SolutionModel> finaList = [];
    if (solutions.isNotEmpty) {
      for (Solution solution in solutions) {
        finaList.add(
          SolutionModel(
            id: solution.id,
            title: solution.title,
            solution: solution.solution,
            images: solution.images,
            topics: solution.topics,
          ),
        );
      }
    }

    return finaList;
  }
}
