
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_shop/constants/text_styles.dart';

import '../../data/models/product_model.dart';
import '../../riverpod/product_provider.dart';
import 'favorite_views.dart';


class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<FavoriteScreen> {


  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Opacity(opacity: 0.6, child: Text('ИЗБРАННЫЕ ', style: black(30, FontWeight.w800),)),
                    Text('ТОВАРЫ', style: brand(30, FontWeight.w800),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child){
                          return ref.watch(baseFavoriteProductsProvider).when(
                            loading: () => const Center(child: CircularProgressIndicator(color: Colors.black54, strokeWidth: 3.0,),),
                            error: (error, _) => Center(child: Text(error.toString())),
                            data: (_){
                              final List favoriteProducts = ref.watch(favoriteProductsProvider);
                              return favoriteProducts.isEmpty ? 
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.sizeOf(context).height - 100
                                  ),
                                  child: Center(child: Text('нет товаров в избранном', style: black54(18),),)
                                ) 
                                : favorites(favoriteProducts);
                            }, 
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favorites(List favoriteProducts){
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: favoriteProducts.length,
      itemBuilder: (BuildContext context, int index){
        ProductModel product = ProductModel(product: favoriteProducts[index]);
        return FavoriteViews(product: product);
      }
    );
  }

}