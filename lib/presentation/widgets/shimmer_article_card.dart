import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerArticleCard extends StatelessWidget {
  const ShimmerArticleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final imageHeight = width * 9 / 16; // 16:9 aspect ratio
          final contentPadding = width * 0.04;
          
          return SizedBox(
            height: imageHeight + 120, // Reduced fixed height
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surfaceVariant,
              highlightColor: Theme.of(context).colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  
                  // Content area
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(contentPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title placeholder
                          Container(
                            width: width * 0.9,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: contentPadding * 0.5),
                          Container(
                            width: width * 0.7,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Bottom metadata placeholders
                          Row(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(width: contentPadding),
                              Container(
                                width: width * 0.3,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 