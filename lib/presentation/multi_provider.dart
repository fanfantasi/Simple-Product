import 'package:klontong/presentation/provider/category/notifier.dart';
import 'package:klontong/presentation/provider/product/notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


import '../injection_container.dart' as di;

class AppDependencies {
  static List<SingleChildWidget> inject() => [
    ChangeNotifierProvider(create: (_) => di.getIt<ProductNotifier>()),
    ChangeNotifierProvider(create: (_) => di.getIt<CategoryNotifier>()),
  ];
}