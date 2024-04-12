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

  List<Solution> convertToListOfSolutions({
    required List<SolutionModel> solutions,
  }) {
    List<Solution> finaList = [];
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
    return finaList;
  }

  List<SolutionModel> convertToListOfSolutionModel({
    required List<Solution> solutions,
  }) {
    List<SolutionModel> finaList = [];
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
    return finaList;
  }
}
