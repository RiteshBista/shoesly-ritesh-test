import 'package:flutter/material.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/features/product/data/model/product_model.dart';
import 'package:project_init/features/product/presentation/screen/widgets/color_options.dart';

class ShoeContainer extends StatefulWidget {
  const ShoeContainer({
    required this.product,
    super.key,
    this.imageSize = const Size(120, 85),
    this.height = 150,
    this.padding = const EdgeInsets.fromLTRB(15, 15, 15, 22),
    this.showColorOptions = false,
  });

  final ProductModel product;
  final Size? imageSize;
  final double height;
  final EdgeInsets padding;
  final bool showColorOptions;

  @override
  _ShoeContainerState createState() => _ShoeContainerState();
}

class _ShoeContainerState extends State<ShoeContainer> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: widget.padding,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.showColorOptions)
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    widget.product.logo,
                    width: 24,
                    height: 24,
                  ),
                ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: 4, // Number of images to show
                  itemBuilder: (context, index) {
                    return Center(
                      child: Image.asset(
                        widget.product.image,
                        width: widget.imageSize?.width,
                        height: widget.imageSize?.height,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 10 : 6,
                    height: _currentPage == index ? 10 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? AppColors.black
                          : AppColors.textGrey,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        if (widget.showColorOptions)
          const Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ColorOptions(),
            ),
          ),
      ],
    );
  }
}
