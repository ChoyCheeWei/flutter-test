part of 'product_cubit.dart';

class ProductState extends Equatable {
  final ProductStateStatus stateStatus;
  final List<ProductModel> products;
  final String selectedProductCategory;

  const ProductState({
    required this.stateStatus,
    required this.products,
    required this.selectedProductCategory,
  });

  bool get isLoading => stateStatus == ProductStateStatus.loading;
  bool get isLoaded => stateStatus == ProductStateStatus.loaded;
  bool get isFailed => stateStatus == ProductStateStatus.failed;

  List<String> get getCategories => products.map((p) => p.category).toSet().toList();

  List<ProductModel> get getProductsByCategory {
    if (selectedProductCategory == 'All') {
      return products;
    }
    return products.where((p) => p.category == selectedProductCategory).toList();
  }

  List<String> getAllCategories() {
    final categories = getCategories;
    categories.insert(0, 'All');
    return categories;
  }

  factory ProductState.initial() {
    return const ProductState(
      stateStatus: ProductStateStatus.initial,
      selectedProductCategory: 'All',
      products: [],
    );
  }

  factory ProductState.fromJson(Map<String, dynamic> json) {
    return ProductState(
      stateStatus: ProductStateStatus.values.firstWhere(
        (e) => e.name == json['stateStatus'],
        orElse: () => ProductStateStatus.initial,
      ),
      selectedProductCategory: json['selectedProductCategory'] ?? 'All',
      products: ProductModel.fromList(json['products'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stateStatus': stateStatus.name,
      'selectedProductCategory': selectedProductCategory,
      'products': products,
    };
  }

  ProductState copyWith({
    ProductStateStatus? stateStatus,
    List<ProductModel>? products,
    String? selectedProductCategory,
  }) {
    return ProductState(
      stateStatus: stateStatus ?? this.stateStatus,
      products: products ?? this.products,
      selectedProductCategory: selectedProductCategory ?? this.selectedProductCategory,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        products,
        selectedProductCategory,
      ];
}
