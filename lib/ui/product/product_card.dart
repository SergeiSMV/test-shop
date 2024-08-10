
import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';
import '../../data/models/product_model.dart';
import 'product_image_indicator.dart';
import 'product_images.dart';




class ProductCard extends StatefulWidget {
  final ProductModel product;
  final Widget favorite;
  const ProductCard({super.key, required this.product, required this.favorite});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  final PageController _pageController = PageController();

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            productImages(widget.product.images, _pageController, 300),
            const SizedBox(height: 8,),
            widget.product.images.isEmpty || widget.product.images.length == 1 ? const SizedBox(height: 8,) : productImageIndicator(widget.product.images, _pageController),
            const SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: Text(widget.product.name, style: black54(20, FontWeight.w500))
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.favorite,
                    const SizedBox(width: 10,),
                    Text('${widget.product.salePrice.toInt()}₽', style: black54(30, FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis,),
                    const SizedBox(width: 8,),
                    Text('${widget.product.price.toInt()}', style: black54Through(25, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                    Text('₽', style: black54(25, FontWeight.w500), maxLines: 3, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(widget.product.discription, style: black54(16), overflow: TextOverflow.fade,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}