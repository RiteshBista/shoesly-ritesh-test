import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/core/route/app_router.dart';
import 'package:project_init/features/cart/data/model/cart_model.dart';
import 'package:project_init/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:project_init/features/common/app_outlined_button.dart';
import 'package:project_init/features/common/app_scaffold.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/common/app_state_wrapper.dart';
import 'package:project_init/features/common/cart_widget.dart';
import 'package:project_init/features/common/review_widget.dart';
import 'package:project_init/features/common/shoe_container.dart';
import 'package:project_init/features/common/top_shadow_box_decoration.dart';
import 'package:project_init/features/product/data/model/product_model.dart';
import 'package:project_init/features/product/presentation/screen/widgets/add_items_widget.dart';
import 'package:project_init/features/product/presentation/screen/widgets/items_added_widget.dart';
import 'package:project_init/features/product/presentation/screen/widgets/size_options.dart';
import 'package:project_init/features/review/presentation/bloc/review_bloc.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({required this.product, super.key});
  final ProductModel product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ReviewBloc>(context)
        .add(ReviewEvent.fetchAllReview(productId: widget.product.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        actions:  [const CartImage(),30.horizontalSpacer,],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              children: [
                ShoeContainer(
                  product: widget.product,
                  showColorOptions: true,
                  padding: const EdgeInsets.fromLTRB(31, 69, 31, 67),
                  height: 345,
                  imageSize: null,
                ),
          30.verticalSpacer,
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  children: [Text('(${widget.product.reviews} Reviews)')],
                ),
       30.verticalSpacer,
                Text(
                  'Size',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
         10.verticalSpacer,
                SizeOptions(
                  sizes: widget.product.sizes,
                ),
 30.verticalSpacer,
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
           10.verticalSpacer,
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.bodyTextGrey,
                  ),
                ),
         30.verticalSpacer,
                BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Review (${state.reviews.length})',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                   10.verticalSpacer,
                        AppStateWrapper(
                          theStates: state.theStates,
                          successChild: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                ReviewWidget(review: state.reviews[index]),
                            separatorBuilder: (context, index) =>
                 30.verticalSpacer,
                            itemCount: state.reviews.length > 3
                                ? 3
                                : state.reviews.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
            20.verticalSpacer,
                AppOutlinedButton.white(
                  text: 'See All Review',
                  borderColor: AppColors.buttonBorderColor,
                  onPressed: () async {
                    await AutoRouter.of(context)
                        .push(ReviewRoute(shoeId: widget.product.id));
                    if (context.mounted) {
                      BlocProvider.of<ReviewBloc>(context).add(
                        ReviewEvent.fetchAllReview(
                          productId: widget.product.id,
                        ),
                      );
                    }
                  },
                ),
        38.verticalSpacer,
              ],
            ),
          ),
          Container(
            decoration: boxDecorationTopShadow,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.textGrey),
                    ),
                    Text(
                      '\$${widget.product.price}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                AppOutlinedButton(
                  onPressed: () async {
                    final items = await showModalBottomSheet<CartModel>(
                      isScrollControlled: true,
                      useRootNavigator: true,
                      context: context,
                      builder: (context) => AddItemsWidget(
                        product: widget.product,
                      ),
                    );
                    if (items != null && context.mounted) {
                      BlocProvider.of<CartBloc>(context).add(
                        CartEvent.addToCart(
                          product: widget.product,
                          count: items.count,
                        ),
                      );
                      unawaited(
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ItemsAddedWidget(count: items.count),
                        ),
                      );
                    }
                  },
                  text: 'ADD TO CART',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
