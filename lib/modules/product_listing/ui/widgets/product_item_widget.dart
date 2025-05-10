import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/models/product/product_model.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel product) onPressed;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late ProductModel product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  void didUpdateWidget(covariant ProductItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed.call(product);
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.image,
                    height: 80,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'RM ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${product.rating.rate}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
