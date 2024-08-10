
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_shop/constants/text_styles.dart';

import '../../data/hive_implements/hive_implements.dart';
import '../../data/models/product_model.dart';
import '../../riverpod/product_provider.dart';
import '../product/product_image_indicator.dart';
import '../product/product_images.dart';


class FavoriteViews extends ConsumerStatefulWidget {
  final ProductModel product;
  const FavoriteViews({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewsState();
}

class _CartViewsState extends ConsumerState<FavoriteViews> {

  final HiveImplements hive = HiveImplements();
  final TextEditingController _quantityController = TextEditingController();
  final PageController _controller = PageController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _quantityController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            color: Colors.transparent,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(width: 100, child: productImages(widget.product.images, _controller, 100)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: productImageIndicator(widget.product.images, _controller),
                ),
              ],
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(widget.product.name, style: black54(16, FontWeight.w500), overflow: TextOverflow.clip,),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${widget.product.salePrice.toInt()}₽', style: black54(18, FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis,),
                        const SizedBox(width: 8,),
                        Text('${widget.product.price.toInt()}', style: black54Through(16, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                        Text('₽', style: black54(16, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () async {
                              await hive.removeFavoriteProduct(widget.product.id);
                              return ref.refresh(baseFavoriteIdProvider);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 3,
                                  color: Colors.transparent,
                                ),
                                color: Colors.white,
                              ),
                              child: Icon(
                                MdiIcons.heart, 
                                color: Colors.red, 
                                size: 25,
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

}