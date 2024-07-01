import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_init/constants/app_images.dart';
part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String image,
    required String logo,
    required String name,
    required String brand,
    required String description,
    required List<int> sizes,
    required double price,
    required int reviews,
    required double rating,
    required int id,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

List<BrandModel> brands = [
  BrandModel(title: 'All', logo: AppImages.reebokLogo.path),
  BrandModel(title: 'Jordan', logo: AppImages.jordanLogo.path),
  BrandModel(title: 'Nike', logo: AppImages.nikeLogo.path),
  BrandModel(title: 'Reebok', logo: AppImages.reebokLogo.path),
  BrandModel(title: 'Adidas', logo: AppImages.adidasLogo.path),
  BrandModel(title: 'Vans', logo: AppImages.vansLogo.path),
];
List<String> reviewFilter = [
  'All',
  '5 Stars',
  '4 Stars',
  '3 Stars',
  '2 Star',
  '1 Star',
];

class BrandModel {
  BrandModel({required this.title, required this.logo});

  final String title;
  final String logo;
}
