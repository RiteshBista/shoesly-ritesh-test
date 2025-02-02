import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_init/constants/app_colors.dart';
import 'package:project_init/features/common/app_scaffold.dart';
import 'package:project_init/features/common/app_spacing.dart';
import 'package:project_init/features/common/app_state_wrapper.dart';
import 'package:project_init/features/common/custom_app_bar.dart';
import 'package:project_init/features/common/review_widget.dart';
import 'package:project_init/features/product/data/model/product_model.dart';
import 'package:project_init/features/review/presentation/bloc/review_bloc.dart';

@RoutePage()
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({required this.shoeId, super.key});
  final int shoeId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReviewBloc>(context).add(
      ReviewEvent.fetchAllReview(
        productId: widget.shoeId,
        calculateReview: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return AppScaffold(
          appBar: CustomAppBar(
            title: 'Review (${state.reviews.length})',
            actions: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.yellow,
                  ),
         5.horizontalSpacer,
                  Text(
                    '${state.averageReviews?.toStringAsFixed(2) ?? 0}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
          15.horizontalSpacer,
                ],
              ),
            ],
          ),
          body: Column(
            children: [
      20.verticalSpacer,
              SizedBox(
                height: 30,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  scrollDirection: Axis.horizontal,
                  itemCount: reviewFilter.length,
                  separatorBuilder: (context, index) =>
            20.horizontalSpacer,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => BlocProvider.of<ReviewBloc>(context).add(
                      ReviewEvent.fetchAllReview(
                        productId: widget.shoeId,
                        selectedFilter: reviewFilter[index],
                      ),
                    ),
                    child: Text(
                      reviewFilter[index],
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: state.selectedFilter == reviewFilter[index]
                                ? null
                                : AppColors.textGrey,
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AppStateWrapper(
                  theStates: state.theStates,
                  successChild: ListView.separated(
                    padding: const EdgeInsets.all(30),
                    itemBuilder: (context, index) => ReviewWidget(
                      review: state.reviews[index],
                    ),
                    separatorBuilder: (context, index) =>
              20.verticalSpacer,
                    itemCount: state.reviews.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
