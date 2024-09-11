import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klontong/core/widgets/loadingwidget.dart';
import 'package:klontong/core/widgets/loadmore.dart';
import 'package:klontong/core/widgets/textfield.dart';
import 'package:klontong/presentation/pages/products/widgets/product_widget.dart';
import 'package:klontong/presentation/provider/product/notifier.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductNotifier notifier;
  Timer? _debounce;

  @override
  void initState() {
    notifier = context.read<ProductNotifier>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notifier.page = 1;
      notifier.isLastPage = false;
      notifier.params = '?page=${notifier.page}&limit=10';
      if (!mounted) return;
      await notifier.getProducts();
    });
    super.initState();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
          if (notifier.textSearchController.text.isEmpty){
            notifier.page = 1;
            notifier.isLastPage = false;
            notifier.params = '?page=${notifier.page}&limit=10';
          }else{
            notifier.focusSearch.unfocus();
            notifier.page = 1;
            notifier.isLastPage = false;
            notifier.params = '?name[contains]=${notifier.textSearchController.text}&name[mode]=insensitive&page=${notifier.page}&limit=10';
          }
          
          notifier.getProducts();
      });
  }
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          color: Colors.white,
          child: const FlutterLogo(
            size: 10,
          ), 
        ), 
        title: const Text('KLONTONG', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()=> notifier.showDialogPost(context, mounted), icon: const Icon(Icons.add))
        ],
      ),
      body: Consumer<ProductNotifier>(
        builder: (context, value, child) {
          return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFieldCustom(
                    controller: notifier.textSearchController,
                    focusNode: notifier.focusSearch,
                    placeholder: 'Search keyword',
                    onChange: _onSearchChanged,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                  ),
                ),
                Expanded(
                  child: notifier.isloading
                    ? Center(
                        child: LoadingWidget(leftcolor: Theme.of(context).primaryColor),
                      )
                    : RefreshLoadmore(
                      color: Theme.of(context).primaryColor,
                      onRefresh: () async {
                        notifier.isLastPage = false;
                        notifier.isloadmore = false;
                        notifier.page = 1;
                        notifier.params = '?page=${notifier.page}&limit=10'; 
                        notifier.getProducts();
                      },
                      isLastPage: notifier.isLastPage,
                      onLoadmore: () async {
                        if (notifier.isloadmore) {
                          return;
                        }
                        notifier.isloadmore = true;
                        notifier.page += 1;
                        notifier.params = '?page=${notifier.page}&limit=10'; 
                        notifier.getLoadMore(context, mounted);
                        await Future.delayed(const Duration(seconds: 2),
                            () async {
                          notifier.isloadmore = false;
                        });
                      },
                      child: (notifier.products.isEmpty)
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  kToolbarHeight,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const FlutterLogo(
                                       size: kToolbarHeight * 2,
                                        textColor: Colors.blue,
                                        style: FlutterLogoStyle.stacked,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Products is Empty',
                                      style: TextStyle(
                                          color: Theme.of(context).disabledColor),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Wrap(
                              alignment: WrapAlignment.center,
                              children: widgetGenerate(notifier),
                            ),
                    ),
                ),
              ],
            );
        },
      ),
    );
  }

  List<Widget> widgetGenerate(ProductNotifier notifier) {
    List<Widget> widget = [];
    for (var i = 0; i < notifier.products.length; i++) {
      widget.add(
        Container(
          height: 192,
          width: MediaQuery.of(context).size.width / 2.1,
          padding: const EdgeInsets.all(6),
          child: ProductWidget(data: notifier.products[i]),
        )
      );
    }
    return widget;
  }
}