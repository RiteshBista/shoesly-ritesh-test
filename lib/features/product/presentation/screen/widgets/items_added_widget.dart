import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/constants/app_images.dart';
import 'package:project_init/core/route/app_router.dart';
import 'package:project_init/features/common/app_outlined_button.dart';
import 'package:project_init/features/common/app_spacing.dart';

class ItemsAddedWidget extends StatelessWidget {
  const ItemsAddedWidget({required this.count, super.key});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.addedToCart.path,
            width: 100,
          ),
          20.verticalSpacer,
          const Text(
            'Added to cart',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          5.verticalSpacer,
          Text(
            '$count Item Total',
            style: const TextStyle(
              color: AppColors.bodyTextGrey,
            ),
          ),
          20.verticalSpacer,
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton.white(
                  text: 'Back Explore',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              15.horizontalSpacer,
              Expanded(
                child: AppOutlinedButton(
                  text: 'To Cart',
                  onPressed: () {
                    Navigator.pop(context);
                    AutoRouter.of(context).push(const CartRoute());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
