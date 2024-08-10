
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_shop/constants/text_styles.dart';

import '../../data/hive_implements/hive_implements.dart';
import '../../data/models/product_model.dart';
import '../../riverpod/product_provider.dart';
import 'product_image_indicator.dart';
import 'product_images.dart';
import 'product_card.dart';

class ProductsViews extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductsViews({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsViewsState();
}

class _ProductsViewsState extends ConsumerState<ProductsViews> {

  final HiveImplements hive = HiveImplements();
  final TextEditingController _quantityController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _quantityController.dispose();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () => showProductCard(context),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  productImages(widget.product.images, _pageController, 120),
                  Positioned(right: 5, top: 5, child: favorite(25))
                ],
              ),
              const SizedBox(height: 8,),
              widget.product.images.isEmpty || widget.product.images.length == 1 ? const SizedBox(height: 8,) : productImageIndicator(widget.product.images, _pageController),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: SizedBox(
                  height: 50,
                  child: Text(widget.product.name, style: black54(16, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,)
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.product.salePrice.toInt()}₽', style: black54(20, FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis,),
                    const SizedBox(width: 8,),
                    Text('${widget.product.price.toInt()}', style: black54Through(16, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                    Text('₽', style: black54(16, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              detailButton()
            ],
          )
        ),
      ),
    );
  }

  Widget favorite(double heartSized){
    return Consumer(
      builder: (context, ref, child) {
        final favoriteProducts = ref.watch(favoriteIdProvider);
        bool favorite = favoriteProducts.contains(widget.product.id);
        return InkWell(
          onTap: () async {
            if (favorite) {
              await hive.removeFavoriteProduct(widget.product.id);
            } else {
              await hive.addFavoriteProduct(widget.product.id);
            }
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
              favorite ? MdiIcons.heart : MdiIcons.heartOutline, 
              color: favorite ? Colors.red : Colors.grey, 
              size: heartSized,
            )
          ),
        );
      }
    );
  }

  Widget detailButton() {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber.shade800,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () => showProductCard(context), 
        child: Text('подробнее', style: black54(16),)
      ),
    );
  }


  void showProductCard(BuildContext mainContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: mainContext,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: ProductCard(
            product: widget.product,
            favorite: favorite(25),
          ),
        );
      },
    );
  }

}