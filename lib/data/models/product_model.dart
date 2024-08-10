
import 'package:freezed_annotation/freezed_annotation.dart';


part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();
  const factory ProductModel({
    required Map<String, dynamic> product,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);


  int get id => product['id'];
  String get name => product['name'];
  List get images => product['images'];
  double get price => product['price'];
  double get salePrice => product['sale_price'];
  String get discription => product['description'];
  
}