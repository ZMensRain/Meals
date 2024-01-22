import 'package:isar/isar.dart';

part 'recipe_stats.g.dart';

@Collection(inheritance: false)
class RecipeStats {
  RecipeStats({
    required this.maxCalories,
    required this.minCalories,
    required this.maxMinutes,
    required this.minMinutes,
    required this.tags,
  });
  final Id id = 1;

  final double maxCalories;
  final double minCalories;
  final int maxMinutes;
  final int minMinutes;
  final List<String> tags;

  RecipeStats copyWith({
    double? maxCalories,
    double? minCalories,
    int? maxMinutes,
    int? minMinutes,
    List<String>? tags,
  }) {
    return RecipeStats(
      maxCalories: maxCalories ?? this.maxCalories,
      minCalories: minCalories ?? this.minCalories,
      maxMinutes: maxMinutes ?? this.maxMinutes,
      minMinutes: minMinutes ?? this.minMinutes,
      tags: tags ?? this.tags,
    );
  }
}
