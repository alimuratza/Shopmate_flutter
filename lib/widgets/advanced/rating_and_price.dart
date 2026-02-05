import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Rating widget with stars
class RatingStars extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showValue;
  final MainAxisAlignment alignment;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 18,
    this.activeColor,
    this.inactiveColor,
    this.showValue = false,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        ...List.generate(maxRating, (index) {
          final starValue = rating - index;
          IconData icon;
          Color color;

          if (starValue >= 1) {
            icon = Icons.star_rounded;
            color = activeColor ?? const Color(0xFFFFB800);
          } else if (starValue >= 0.5) {
            icon = Icons.star_half_rounded;
            color = activeColor ?? const Color(0xFFFFB800);
          } else {
            icon = Icons.star_outline_rounded;
            color = inactiveColor ?? Colors.grey[300]!;
          }

          return Icon(icon, size: size, color: color);
        }),
        if (showValue) ...[
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.8,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ],
    );
  }
}

/// Interactive rating selector
class RatingSelector extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;
  final double size;
  final bool allowHalfRating;

  const RatingSelector({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
    this.size = 40,
    this.allowHalfRating = true,
  });

  @override
  State<RatingSelector> createState() => _RatingSelectorState();
}

class _RatingSelectorState extends State<RatingSelector> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1.0;
            });
            widget.onRatingChanged(_rating);
          },
          onHorizontalDragUpdate: widget.allowHalfRating
              ? (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final pos = box.globalToLocal(details.globalPosition);
                  final starWidth = widget.size;
                  final newRating = (pos.dx / starWidth).clamp(0.0, 5.0);
                  final roundedRating =
                      (newRating * 2).round() / 2; // Round to nearest 0.5
                  if (roundedRating != _rating) {
                    setState(() {
                      _rating = roundedRating;
                    });
                    widget.onRatingChanged(_rating);
                  }
                }
              : null,
          child: AnimatedScale(
            scale: _rating >= index + 1 ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: Icon(
              _rating >= index + 1
                  ? Icons.star_rounded
                  : _rating >= index + 0.5
                      ? Icons.star_half_rounded
                      : Icons.star_outline_rounded,
              size: widget.size,
              color: _rating > index
                  ? const Color(0xFFFFB800)
                  : Colors.grey[300],
            ),
          ),
        );
      }),
    );
  }
}

/// Price display with discount
class PriceDisplay extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final String currency;
  final double fontSize;
  final bool showDiscount;

  const PriceDisplay({
    super.key,
    required this.price,
    this.originalPrice,
    this.currency = '₹',
    this.fontSize = 18,
    this.showDiscount = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = originalPrice != null && originalPrice! > price;
    final discountPercent = hasDiscount
        ? ((originalPrice! - price) / originalPrice! * 100).round()
        : 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$currency${price.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            '$currency${originalPrice!.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: fontSize * 0.75,
              color: Colors.grey[500],
              decoration: TextDecoration.lineThrough,
            ),
          ),
          if (showDiscount) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '-$discountPercent%',
                style: TextStyle(
                  fontSize: fontSize * 0.65,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }
}

/// Quantity selector
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final double size;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onTap: quantity > min ? () => onChanged(quantity - 1) : null,
          ),
          Container(
            constraints: BoxConstraints(minWidth: size),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.add,
            onTap: quantity < max ? () => onChanged(quantity + 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isEnabled ? Colors.white : Colors.grey[500],
          size: 18,
        ),
      ),
    );
  }
}

/// Badge/Tag widget
class ProductBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  const ProductBadge({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.icon,
  });

  factory ProductBadge.sale({String? text}) {
    return ProductBadge(
      text: text ?? 'SALE',
      color: const Color(0xFFFF416C),
    );
  }

  factory ProductBadge.newArrival() {
    return const ProductBadge(
      text: 'NEW',
      color: AppColors.success,
    );
  }

  factory ProductBadge.bestseller() {
    return const ProductBadge(
      text: 'BESTSELLER',
      color: Color(0xFFFFB800),
      textColor: Colors.black,
    );
  }

  factory ProductBadge.outOfStock() {
    return ProductBadge(
      text: 'OUT OF STOCK',
      color: Colors.grey[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor ?? Colors.white),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
