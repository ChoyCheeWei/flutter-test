import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/modules/product_listing/ui/widgets/product_item_widget.dart';

import '../../../../models/product/product_model.dart';
import '../../../product_details/ui/pages/product_details_page.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<ProductModel> products;

  ProductSearchDelegate({
    required this.products,
  });

  @override
  Widget buildResults(BuildContext context) {
    return _getResultListingWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _getResultListingWidget();
  }

  Widget _getResultListingWidget() {
    final results = products
        .where(
          (p) => p.title.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No Records',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: results.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        final product = results[index];
        return ProductItemWidget(
          product: product,
          onPressed: (ProductModel product) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsPage(
                  productDetails: product,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }
}
