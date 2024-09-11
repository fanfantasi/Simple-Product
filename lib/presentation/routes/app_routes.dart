import 'package:flutter/material.dart';
import 'package:klontong/presentation/apps.dart';
import 'package:klontong/presentation/pages/products/add/screen.dart';
import 'package:klontong/presentation/pages/products/detail/screen.dart';

import '../pages/products/screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
            builder: (_) => const AppsPage(), settings: settings);
      case Routes.productPage:
        return MaterialPageRoute(
            builder: (_) => const ProductScreen(), settings: settings);
      case Routes.productDetailPage:
        return MaterialPageRoute(
            builder: (_) => const ProductDetailScreen(), settings: settings);
      case Routes.productAddPage:
        return MaterialPageRoute(
            builder: (_) => const AddProductScreen(), settings: settings);
      
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
            title: const Text("Page Not Found")),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterLogo(),
              Text('404'),
            ],
          ),
        ),
      );
    });
  }
}
