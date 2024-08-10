
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_shop/constants/text_styles.dart';

import '../data/models/product_model.dart';
import '../riverpod/product_provider.dart';
import 'product/product_views.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
                    Opacity(opacity: 0.6, child: Text('TEST', style: black(40, FontWeight.w800),)),
                    Text('SHOP', style: brand(40, FontWeight.w800),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: searchField(),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child){
                          return ref.watch(baseProductsProvider).when(
                            loading: () => const Center(child: CircularProgressIndicator(color: Colors.black54, strokeWidth: 3.0,),),
                            error: (error, _) => Center(child: Text(error.toString())),
                            data: (_){
                              final List? searchProducts = ref.watch(searchProductsProvider);
                              final List allProducts = ref.watch(productsProvider);
      
                              return products(searchProducts ?? allProducts);
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

  Widget products(List allProducts) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: allProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 0.64
      ),
      itemBuilder: (BuildContext context, int index) {
        ProductModel product = ProductModel(product: allProducts[index]);
        return ProductsViews(product: product,);
      },
    );
  }

  Widget searchField(){
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: grey(18),
          hintText: 'поиск',
          prefixIcon: Icon(MdiIcons.magnify, color: Colors.black54, size: 20,),
          suffixIcon: _searchController.text.isEmpty ? null : 
            InkWell(
              onTap: (){
                setState(() {
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
                  ref.read(searchProductsProvider.notifier).clearSearch();
                });
              },
              child: Icon(MdiIcons.close, color: Colors.black54, size: 20,)
            ),
          isCollapsed: true,
        ),
        onChanged: (text){
          ref.read(searchProductsProvider.notifier).searchProducts(text);
          setState(() {
            _searchController.text = text;
          });
        },
      ),
    );
  }


}