import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth * 0.04;
          
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                for (int index = 0; index <= categories.length; index++)
                  Padding(
                    key: ValueKey('category_${index == 0 ? "all" : categories[index - 1]}'),
                    padding: EdgeInsets.only(right: horizontalPadding / 2),
                    child: Material(
                      type: MaterialType.transparency,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 80,
                          maxHeight: 40,
                        ),
                        child: Builder(
                          builder: (context) {
                            final isAllCategory = index == 0;
                            final category = isAllCategory ? '' : categories[index - 1];
                            final isSelected = category == selectedCategory;
                            final label = isAllCategory ? 'ALL' : category.toUpperCase();

                            return FilterChip(
                              label: Text(
                                label,
                                style: TextStyle(
                                  color: isSelected 
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (_) => onCategorySelected(category),
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              selectedColor: Theme.of(context).colorScheme.primary,
                              checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                              showCheckmark: false,
                              elevation: isSelected ? 2 : 0,
                              pressElevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
} 