import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:myeg_flutter_test/models/product/product_model.dart';

import '../../../enum/enum.dart';

part 'product_state.dart';

class ProductCubit extends HydratedCubit<ProductState> {
  ProductCubit() : super(ProductState.initial()) {
    getProductListing();
  }

  Future<void> getProductListing() async {
    try {
      emit(state.copyWith(stateStatus: ProductStateStatus.loading));
      String url = 'https://fakestoreapi.com/products';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final products = ProductModel.fromList(jsonDecode(response.body));
        emit(
          state.copyWith(
            products: products,
            stateStatus: ProductStateStatus.loaded,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        stateStatus: ProductStateStatus.failed,
      ));
    }
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    return ProductState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return state.toJson();
  }
}
