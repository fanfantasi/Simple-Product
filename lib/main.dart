import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'core/theme/theme.dart';
import 'core/widgets/error_widget.dart';
import 'injection_container.dart' as di;
import 'presentation/multi_provider.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  runApp(const MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppDependencies.inject(),
      child: MaterialApp(
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails error){
            return ErrorWidgetMessage(errorMessage: error.exception.toString());
          };
          return child!;
        },
        debugShowCheckedModeBanner: false,
        navigatorKey: mainNavigatorKey,
        title: 'KLONTONG',
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.root,
        theme: ThemeModel().lightTheme,
      ),
    );
  }
}
