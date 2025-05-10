import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/models/product/product_model.dart';
import 'package:myeg_flutter_test/modules/product_details/ui/widgets/image_preview_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel productDetails;

  const ProductDetailsPage({
    super.key,
    required this.productDetails,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productDetails;

  @override
  void initState() {
    super.initState();
    productDetails = widget.productDetails;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _getAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ImagePreviewWidget(
                    imageUrl: productDetails.image,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(48),
                    bottomRight: Radius.circular(48),
                  ),
                ),
                child: Hero(
                  tag: productDetails.id,
                  child: Image.network(
                    productDetails.image,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDetails.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'RM ${productDetails.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${productDetails.rating.rate}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    productDetails.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _getAppBarWidget() {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorScheme.primary,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
    );
  }
}
