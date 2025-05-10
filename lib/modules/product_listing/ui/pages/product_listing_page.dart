import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product/product_model.dart';
import '../../../product_details/ui/pages/product_details_page.dart';
import '../../bloc/product_cubit.dart';
import '../widgets/product_item_widget.dart';
import '../widgets/product_search_widget.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.isFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Failed to load data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _getAppBarWidget(state),
          body: _getBodyWidget(state),
        );
      },
    );
  }

  Widget _getBodyWidget(ProductState state) {
    final products = state.getProductsByCategory;
    if (products.isEmpty) {
      return Center(
        child: Text(
          'No Record(s)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 220,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
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
      ),
    );
  }

  PreferredSize? _getProductCategoryWidget(ProductState state) {
    final colorScheme = Theme.of(context).colorScheme;

    return state.products.isEmpty
        ? null
        : PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.getAllCategories().map((category) {
                        bool isSelected = category == state.selectedProductCategory;
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (isSelected) {
                              return;
                            }
                            await context.read<ProductCubit>().getProductsByCategory(category);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              category.substring(0, 1).toUpperCase() + category.substring(1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? colorScheme.onPrimaryContainer : Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          );
  }

  AppBar _getAppBarWidget(ProductState state) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorScheme.primary,
      centerTitle: false,
      title: Text(
        'Product Listing',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      bottom: _getProductCategoryWidget(state),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.search),
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: ProductSearchDelegate(
                products: state.products,
              ),
            );
          },
        ),
      ],
    );
  }
}
