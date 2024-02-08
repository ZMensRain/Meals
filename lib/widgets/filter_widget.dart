import 'package:flutter/material.dart';

import 'package:meal_planner/model/recipe_stats.dart';
import 'package:meal_planner/widgets/sheets/pick_tag_sheet.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget(this.stats,
      {super.key,
      required this.onFilterChanged,
      this.showPlusButton = false,
      this.onPlusButton});

  final void Function(
    double maxCalories,
    double minCaloriesInput,
    int maxMinutes,
    int minMinutes,
    List<String> includedTags,
    List<String> excludedTags,
    String searchBarText,
  ) onFilterChanged;

  final void Function()? onPlusButton;

  final RecipeStats stats;

  final bool showPlusButton;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  var maxCaloriesInput = 100.0;
  var minCaloriesInput = 0.0;

  var maxMinutes = 100;
  var minMinutes = 0;

  List<String> includedTags = [];
  List<String> excludedTags = [];

  bool isFiltering = false;

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void update() {
    widget.onFilterChanged(
      maxCaloriesInput,
      minCaloriesInput,
      maxMinutes,
      minMinutes,
      includedTags,
      excludedTags,
      searchController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isFiltering ? 350 : 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SearchBar(
                  controller: searchController,
                  leading: const Icon(Icons.search),
                  onSubmitted: (value) => update(),
                ),
              ),
              IconButton(
                onPressed: () => setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();

                  isFiltering = !isFiltering;
                }),
                icon: const Icon(Icons.sort),
              ),
              if (widget.showPlusButton)
                IconButton(
                  onPressed: widget.onPlusButton,
                  icon: const Icon(Icons.add),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (isFiltering) ...[
            Text(
              "Calories",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            RangeSlider(
              divisions:
                  ((widget.stats.maxCalories - widget.stats.minCalories) * 10)
                          .toInt() +
                      1,
              labels: RangeLabels(
                minCaloriesInput.toString(),
                maxCaloriesInput.toString(),
              ),
              min: widget.stats.minCalories,
              max: widget.stats.maxCalories,
              values: RangeValues(minCaloriesInput, maxCaloriesInput),
              onChanged: (value) {
                setState(() {
                  maxCaloriesInput = double.parse(value.end.toStringAsFixed(1));
                  minCaloriesInput =
                      double.parse(value.start.toStringAsFixed(1));
                });
                update();
              },
            ),
            Text(
              "Cook Time",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            RangeSlider(
              divisions: widget.stats.maxMinutes,
              labels: RangeLabels(
                "${minMinutes}min",
                "${maxMinutes}min",
              ),
              min: widget.stats.minMinutes.toDouble(),
              max: widget.stats.maxMinutes.toDouble(),
              values: RangeValues(minMinutes.toDouble(), maxMinutes.toDouble()),
              onChanged: (value) {
                setState(
                  () {
                    maxMinutes = value.end.toInt();
                    minMinutes = value.start.toInt();
                  },
                );
                update();
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Included tags",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        var tag = await showModalBottomSheet<String>(
                          context: context,
                          builder: (context) => PickTagSheet(
                              excludeTags: includedTags + excludedTags),
                        );
                        if (tag == null) {
                          return;
                        }
                        setState(
                          () => includedTags.add(tag),
                        );
                        update();
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: includedTags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => TextButton(
                  onPressed: () {
                    setState(
                      () {
                        includedTags.removeAt(index);
                      },
                    );
                  },
                  child: Text(includedTags[index]),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Excluded tags",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      var tag = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) => PickTagSheet(
                            excludeTags: includedTags + excludedTags),
                      );
                      if (tag == null) {
                        return;
                      }
                      setState(
                        () => excludedTags.add(tag),
                      );
                      update();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: excludedTags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => TextButton(
                  onPressed: () {
                    setState(
                      () => excludedTags.removeAt(index),
                    );
                  },
                  child: Text(
                    excludedTags[index],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
