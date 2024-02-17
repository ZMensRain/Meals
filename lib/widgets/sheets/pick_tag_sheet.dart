import 'package:flutter/material.dart';

import 'package:meal_planner/helper/isar.dart';

class PickTagSheet extends StatefulWidget {
  const PickTagSheet({super.key, required this.excludeTags});
  final List<String> excludeTags;
  @override
  State<PickTagSheet> createState() => _PickTagSheetState();
}

class _PickTagSheetState extends State<PickTagSheet> {
  List<String> tags = [];

  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getRecipeStats().then(
      (value) {
        setState(() {
          tags = value.tags;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  List<String> getFilteredTags() {
    var t = tags
        .where(
          (element) => element.toLowerCase().trim().contains(
                searchController.text.toLowerCase().trim(),
              ),
        )
        .toList();
    t = t.map((e) => e.toLowerCase().trim()).toList();

    var excludedTags =
        widget.excludeTags.map((e) => e.toLowerCase().trim()).toList();

    for (var excludedTag in excludedTags) {
      t.remove(excludedTag);
    }

    return t;
  }

  @override
  Widget build(BuildContext context) {
    var filteredTags = getFilteredTags();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchBar(
            hintText: "Tag",
            controller: searchController,
            leading: const Icon(Icons.search),
          ),
          filteredTags.isEmpty
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sorry we could not find any tags, would you like to create one?",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.7),
                                ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var newTag = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              var newTagValue = "no no code failed";

                              return AlertDialog(
                                content: TextField(
                                  decoration:
                                      const InputDecoration(hintText: "Tag"),
                                  onSubmitted: (value) {
                                    if (value.trim() == "") {
                                      Navigator.pop(context);
                                    }
                                    Navigator.pop(context, value.trim());
                                  },
                                  onChanged: (value) => newTagValue = value,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (newTagValue.trim() == "") {
                                        Navigator.pop(context);
                                      }

                                      Navigator.pop(
                                          context, newTagValue.trim());
                                    },
                                    child: const Text("Create"),
                                  ),
                                ],
                              );
                            },
                          );
                          if (newTag == null) {
                            return;
                          }
                          if (context.mounted) {
                            Navigator.pop(context, newTag);
                          }
                        },
                        child: const Text("Create"),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredTags.length,
                    itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () =>
                          Navigator.pop(context, filteredTags[index]),
                      child: Text(
                        filteredTags[index],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
