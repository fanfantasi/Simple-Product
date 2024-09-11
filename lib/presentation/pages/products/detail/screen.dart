import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klontong/core/config/config.dart';
import 'package:klontong/core/widgets/divider_dashed.dart';
import 'package:klontong/core/widgets/loadingwidget.dart';
import 'package:klontong/core/widgets/shimmerwidget.dart';
import 'package:klontong/domain/entities/products_entity.dart';
import 'package:klontong/presentation/provider/product/notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/desc_detail.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductNotifier notifier;
  
  @override
  void initState() {
    notifier = context.read<ProductNotifier>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var res = ModalRoute.of(context)!.settings.arguments as ResultProductsEntity;
      notifier.product = res;
      notifier.findOneProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Consumer<ProductNotifier>(
        builder: (context, value, _) {
          return value.isloading
          ? Center(
              child: LoadingWidget(leftcolor: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 12/9,
                  child: CachedNetworkImage(
                    imageUrl: '${Configs.uri}/${value.product?.image ?? ''}',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.black12, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => const ShimmerWidget(
                        height: 110, width: 205, radius: 8.0),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/default-store-350x350.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Configs.currency(notifier.product?.price ?? 0),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400, color: Colors.red.shade900),
                      ),
                      const SizedBox(height: 8.0,),
                      const DividerDashed(),
                      const SizedBox(height: 12.0,),
                      Text(
                        notifier.product?.name??'',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                      Text(
                        notifier.product?.category?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 18,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Size', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
                  width: MediaQuery.of(context).size.width,
                  height: kToolbarHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      sized(label: 'Weight', value: value.product?.weight??0),
                      sized(label: 'Width', value: value.product?.width??0),
                      sized(label: 'Length', value: value.product?.length??0),
                      sized(label: 'Height', value: value.product?.height??0),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 18,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: Text('Description Product', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
                  ),
                ),
                DescWidget(desc: value.product?.description??'',)
              ],
            ),
          );
        }
      ),
    );
  }


  Widget sized({String? label, int? value}){
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      margin: const EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade100
      ),
      child: Column(
        children: [
          Text(label??'', style: TextStyle(fontSize: 12, color: Colors.grey.shade600),),
          const Spacer(),
          Text('${value??0}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}