import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';
import 'package:meal_planner/model/week.dart';
import 'package:meal_planner/widgets/share_dialog.dart';
import 'package:share_plus/share_plus.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen(this.week, {super.key});
  final Week week;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Share As",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 70,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        MeasurementSystem? system = await showDialog(
                          context: context,
                          builder: (context) => const ShareDialog(),
                        );
                        if (system == null) {
                          return;
                        }

                        var data = await week.getShoppingListAsPDF(system);

                        await Share.shareXFiles(
                          [
                            XFile.fromData(
                              data,
                              mimeType: "pdf",
                            ),
                          ],
                        );
                      },
                      child: const Text("PDF"),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        MeasurementSystem? system = await showDialog(
                          context: context,
                          builder: (context) => const ShareDialog(),
                        );
                        if (system == null) {
                          return;
                        }
                        var ies = await week.getIngredients();
                        var text =
                            ies.map((e) => "• ${e.format(system)}\n").fold(
                                  "",
                                  (previousValue, element) =>
                                      previousValue + element,
                                );
                        text = "Shopping list\n$text";

                        await Share.share(text);
                      },
                      child: const Text("Text"),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Shopping List",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: FutureBuilder(
                future: week.getIngredients(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Text(
                        "• ${snapshot.data![index].format(
                          MeasurementSystem.metric,
                        )}",
                      ),
                    );
                  }
                  return const Center(
                    child: Text("something"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
