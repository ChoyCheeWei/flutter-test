import 'package:equatable/equatable.dart';
import 'package:myeg_flutter_test/models/product/rating_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: RatingModel.fromJson(json['rating'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  static List<ProductModel> fromList(List<dynamic> list) {
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  ProductModel copyWith({
    int? id,
    String? title,
    num? price,
    String? description,
    String? category,
    String? image,
    RatingModel? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  factory ProductModel.empty() {
    return ProductModel(
      id: 0,
      title: '',
      price: 0,
      description: '',
      category: '',
      image: '',
      rating: RatingModel.empty(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}
