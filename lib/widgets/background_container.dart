import 'package:flutter/material.dart';

/// Widget hiển thị background chung cho toàn bộ ứng dụng
/// 
/// Sử dụng widget này để bọc các màn hình và cung cấp background image nhất quán
class BackgroundContainer extends StatelessWidget {
  /// Widget con được hiển thị trên nền background
  final Widget child;
  
  /// Độ mờ của background image (0.0 - 1.0)
  final double opacity;

  /// Hiệu ứng đổ bóng để tăng độ tương phản với nội dung
  final bool useOverlay;
  
  /// Màu của overlay, thường là màu đen với độ trong suốt
  final Color? overlayColor;
  
  const BackgroundContainer({
    Key? key,
    required this.child,
    this.opacity = 1.0,
    this.useOverlay = false,
    this.overlayColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Xác định màu overlay dựa trên theme nếu không được chỉ định
    final effectiveOverlayColor = overlayColor ?? 
        (Theme.of(context).brightness == Brightness.dark 
            ? Colors.black.withOpacity(0.4)
            : Colors.black.withOpacity(0.1));

    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Opacity(
            opacity: opacity,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Overlay để tăng độ tương phản nếu cần
        if (useOverlay)
          Positioned.fill(
            child: Container(
              color: effectiveOverlayColor,
            ),
          ),
        
        // Child widget được hiển thị trên cùng
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
