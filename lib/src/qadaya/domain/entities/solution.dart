import '../../../../core/enums/enum.dart';

class Solution {
  final String id;
  final String title;
  final String solution;
  final List<String>? images;

  final List<Mawadie> topics;

  Solution({
    required this.id,
    required this.title,
    required this.solution,
    required this.images,
    required this.topics,
  });
}
