import 'package:flutter/material.dart';
import 'package:klontong/presentation/provider/category/notifier.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
    expand: false,
    maxChildSize: .9,
    initialChildSize: 0.5,
    builder: (_, controller) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.25,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                child: Container(
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(2.5)),
                  ),
                ),
              ),
            ),
            const Text(
              'Kegiatan',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Consumer<CategoryNotifier>(
                  builder: (context, notifier, _) {
                  if (notifier.isloading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                return ListView.builder(
                  itemCount: notifier.categories.length,
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  itemBuilder: (context, i) {
                    return ListTile(
                      minLeadingWidth: 0,
                      title: Text(
                        notifier.categories[i].name ?? '',
                        style: TextStyle(fontSize: 14, fontWeight: (notifier.categorySelected?.id == notifier.categories[i].id) ? FontWeight.bold : FontWeight.normal),
                      ),
                      trailing: Icon(
                        (notifier.categorySelected?.id == notifier.categories[i].id)
                              ? Icons.check_rounded
                              : null
                      ),
                      onTap: () {
                        notifier.categorySelected = notifier.categories[i];
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}