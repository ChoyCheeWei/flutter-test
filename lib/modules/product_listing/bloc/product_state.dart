part of 'product_cubit.dart';

class ProductState extends Equatable {
  final ProductStateStatus stateStatus;
  final List<ProductModel> products;

  const ProductState({
    required this.stateStatus,
    required this.products,
  });

  bool get isLoading => stateStatus == ProductStateStatus.loading;
  bool get isLoaded => stateStatus == ProductStateStatus.loaded;
  bool get isEmpty => products.isEmpty;
  bool get isFailed => stateStatus == ProductStateStatus.failed;

  factory ProductState.initial() {
    return const ProductState(
      stateStatus: ProductStateStatus.initial,
      products: [],
    );
  }

  factory ProductState.fromJson(Map<String, dynamic> json) {
    return ProductState(
      stateStatus: ProductStateStatus.values.firstWhere(
        (e) => e.name == json['stateStatus'],
        orElse: () => ProductStateStatus.initial,
      ),
      products: ProductModel.fromList(json['products'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stateStatus': stateStatus.name,
      'products': products,
    };
  }

  ProductState copyWith({
    ProductStateStatus? stateStatus,
    List<ProductModel>? products,
  }) {
    return ProductState(
      stateStatus: stateStatus ?? this.stateStatus,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        products,
      ];
}
