import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klontong/core/config/config.dart';
import 'package:klontong/core/widgets/shimmerwidget.dart';
import 'package:klontong/domain/entities/products_entity.dart';
import 'package:klontong/presentation/routes/routes.dart';

class ProductWidget extends StatelessWidget {
  final ResultProductsEntity data;
  const ProductWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.productDetailPage, arguments: data),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(.5, .5),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 132,
              width: MediaQuery.of(context).size.width / 2.15,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  child: CachedNetworkImage(
                    imageUrl: '${Configs.uri}/${data.image ?? ''}',
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.15,
                    child: Text(
                      data.name??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.15,
                    child: Text(
                      data.category?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    Configs.currency(data.price ?? 0),
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red.shade900),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}