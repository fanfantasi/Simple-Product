import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:klontong/presentation/provider/product/notifier.dart';
import 'package:klontong/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class CameraWidget extends StatefulWidget {
  final bool? profile;
  const CameraWidget({super.key, required this.profile});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        onMediaCaptureEvent: (event) {
          switch ((event.status, event.isPicture, event.isVideo)) {
            case (MediaCaptureStatus.success, true, false):
              event.captureRequest.when(
                single: (single) {
                  if (!mounted) return;
                  if (widget.profile??false){
                    context.read<ProductNotifier>().image = single.file?.path;
                    Navigator.pop(context);
                  }else{
                    context.read<ProductNotifier>().image = single.file?.path;
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.productAddPage
                    );
                  }
                },
              );
            default:
              debugPrint('Unknown event: $event');
          }
        },
        theme: AwesomeTheme(
          bottomActionsBackgroundColor: Colors.blue.withOpacity(.5),
          buttonTheme: AwesomeButtonTheme(
            backgroundColor: Colors.blue.withOpacity(0.5),
            iconSize: 20,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            buttonBuilder: (child, onTap) {
              return ClipOval(
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    splashColor: Colors.cyan,
                    highlightColor: Colors.cyan.withOpacity(0.5),
                    onTap: onTap,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
        middleContentBuilder: (state) {
          return Column(
            children: [
              const Spacer(),
              AwesomeFilterWidget(
                state: state,
                filterListPosition: FilterListPosition.belowButton,
                filterListPadding: const EdgeInsets.only(bottom: 8),
              ),
              Builder(builder: (context) {
                return Container(
                  color: AwesomeThemeProvider.of(context)
                      .theme
                      .bottomActionsBackgroundColor,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        "Photo Product",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
