import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1,
                maxScale: 3,
                child: Image.network(
                  imageUrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
